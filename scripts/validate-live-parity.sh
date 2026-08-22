#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
workspace="$(cd "$root/.." && pwd)"
snapshot="${1:-$root/snapshots/2026-08-22/builder-evidence.json}"
catalog="$root/catalog/live-parity.yaml"

die() {
  echo "$*" >&2
  exit 1
}

instruction_sha256() {
  local relative_path="$1"
  local file="$2"

  if [[ "$relative_path" == instructions/current-live-* ]]; then
    perl -0pe 's/\r\n?/\n/g; s/\A.*?\n---\n+//s; s/\n+\z//' "$file" \
      | shasum -a 256 | awk '{print $1}'
  else
    perl -0pe 's/\r\n?/\n/g; s/\A.*?foi acrescentada\.\n\n//s; s/\n+\z//' "$file" \
      | shasum -a 256 | awk '{print $1}'
  fi
}

test -f "$snapshot" || die "missing parity snapshot: $snapshot"
test -f "$catalog" || die "missing live parity catalog: $catalog"
bash "$root/scripts/validate-catalog.sh"

jq -e '
  .schema_version == 1 and
  (.captured_at | type == "string" and length > 0) and
  (.source | type == "string" and length > 0) and
  (.agents | type == "array" and length == 12) and
  ([.agents[].agent_id] | unique | length == 12)
' "$snapshot" >/dev/null || die "invalid parity snapshot envelope"

snapshot_ids="$(jq -r '.agents[].agent_id' "$snapshot" | sort)"
catalog_ids="$(yq -r '.agents[].agent_id' "$catalog" | sort)"
test "$snapshot_ids" = "$catalog_ids" || die "snapshot agents differ from live parity catalog"

while IFS= read -r agent; do
  entry="$(jq -c --arg agent "$agent" '.agents[] | select(.agent_id == $agent)' "$snapshot")"
  test -n "$entry" || die "missing snapshot entry: $agent"

  repository="$(jq -r '.repository' <<<"$entry")"
  catalog_repository="$(yq -r ".agents[] | select(.agent_id == \"$agent\") | .repository" "$catalog")"
  test "$repository" = "$catalog_repository" || die "repository mismatch: $agent"
  [[ "$repository" != *"/"* && "$repository" != *".."* ]] || die "unsafe repository: $agent"

  jq -e '
    (.editor_url | test("^https://chatgpt\\.com/gpts/editor/g-[A-Za-z0-9]+$")) and
    (.builder_state == "LIVE" or .builder_state == "DRAFT") and
    (.name | type == "string" and length > 0) and
    (.description | type == "string" and length > 0) and
    (.conversation_starters | type == "array") and
    (.capabilities | type == "array") and
    (.action_hosts | type == "array") and
    (.knowledge | type == "array")
  ' <<<"$entry" >/dev/null || die "invalid Builder metadata: $agent"

  instruction_path="$(jq -r '.instruction.repository_path' <<<"$entry")"
  [[ "$instruction_path" != /* && "$instruction_path" != *".."* ]] || die "unsafe instruction path: $agent"
  instruction_file="$workspace/agent-repos/$repository/$instruction_path"
  test -f "$instruction_file" || die "missing instruction file: $agent"
  local_instruction_hash="$(instruction_sha256 "$instruction_path" "$instruction_file")"
  recorded_instruction_hash="$(jq -r '.instruction.local_sha256' <<<"$entry")"
  live_instruction_hash="$(jq -r '.instruction.live_sha256' <<<"$entry")"
  test "$local_instruction_hash" = "$recorded_instruction_hash" || die "instruction evidence changed: $agent"
  test "$local_instruction_hash" = "$live_instruction_hash" || die "instruction differs from Builder: $agent"
  test "$(jq -r '.instruction.result' <<<"$entry")" = "MATCH" || die "instruction not aligned: $agent"

  knowledge_count="$(jq '.knowledge | length' <<<"$entry")"
  knowledge_unique_count="$(jq '[.knowledge[].filename] | unique | length' <<<"$entry")"
  test "$knowledge_count" = "$knowledge_unique_count" || die "duplicate knowledge filename: $agent"

  while IFS= read -r knowledge_entry; do
    filename="$(jq -r '.filename' <<<"$knowledge_entry")"
    relative_path="$(jq -r '.repository_path' <<<"$knowledge_entry")"
    [[ "$filename" != *"/"* && "$filename" != *".."* && "$relative_path" != /* && "$relative_path" != *".."* ]] || die "unsafe knowledge path: $agent"
    knowledge_file="$workspace/agent-repos/$repository/$relative_path"
    test -f "$knowledge_file" || die "missing knowledge file: $agent/$filename"
    actual_hash="$(shasum -a 256 "$knowledge_file" | awk '{print $1}')"
    actual_bytes="$(wc -c < "$knowledge_file" | tr -d '[:space:]')"
    test "$actual_hash" = "$(jq -r '.sha256' <<<"$knowledge_entry")" || die "knowledge hash mismatch: $agent/$filename"
    test "$actual_bytes" = "$(jq -r '.bytes' <<<"$knowledge_entry")" || die "knowledge byte count mismatch: $agent/$filename"
    test "$(jq -r '.hash_matches_live' <<<"$knowledge_entry")" = "true" || die "knowledge differs from Builder: $agent/$filename"
  done < <(jq -c '.knowledge[]' <<<"$entry")

  if [[ "$agent" = "ac.reforma-tributaria-rag" ]]; then
    action_schema="$workspace/agent-repos/$repository/connectors/actions/searchDayRagCorpus/openapi.live-2026-08-22.json"
    test -f "$action_schema" || die "missing live Action schema: $agent"
    jq empty "$action_schema"
    while IFS= read -r action_host; do
      grep -Fq -- "$action_host" "$action_schema" || die "Action host differs from Builder: $agent"
    done < <(jq -r '.action_hosts[]' <<<"$entry")
  else
    test "$(jq '.action_hosts | length' <<<"$entry")" = "0" || die "unexpected Action host: $agent"
  fi
done < <(jq -r '.agents[].agent_id' "$snapshot")

echo "live parity validation passed"
