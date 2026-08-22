#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
agents="$root/catalog/agents.yaml"
aliases="$root/catalog/aliases.yaml"
live_parity="$root/catalog/live-parity.yaml"

test "$(yq '.agents | length' "$agents")" = "12"
test "$(yq '[.agents[].id] | unique | length' "$agents")" = "12"
test "$(yq '[.agents[].repository] | unique | length' "$agents")" = "12"
test "$(yq '.aliases | length > 0' "$aliases")" = "true"

test "$(yq '[.aliases[] | select((.source_name | type) != "!!str" or (.source_name | length) == 0)] | length' "$aliases")" = "0"
test "$(yq '[.aliases[] | select((.source_url | type) != "!!str" or (.source_url | length) == 0)] | length' "$aliases")" = "0"
test "$(yq '[.aliases[] | select((.canonical_agent_id | type) != "!!str" or (.canonical_agent_id | length) == 0)] | length' "$aliases")" = "0"
test "$(yq '[.aliases[] | select(.relationship != "temporary" and .relationship != "copy" and .relationship != "draft" and .relationship != "superseded")] | length' "$aliases")" = "0"
test "$(yq '[.aliases[] | select(.repository_created != false)] | length' "$aliases")" = "0"

agent_ids="$(yq -r '.agents[].id' "$agents")"
while IFS= read -r canonical_agent_id; do
  if ! printf '%s\n' "$agent_ids" | grep -Fqx -- "$canonical_agent_id"; then
    echo "unknown canonical_agent_id: $canonical_agent_id" >&2
    exit 1
  fi
done < <(yq -r '.aliases[].canonical_agent_id' "$aliases")

test -f "$live_parity"
test "$(yq '.schema_version' "$live_parity")" = "1"
test "$(yq '.agents | length' "$live_parity")" = "12"
test "$(yq '[.agents[].agent_id] | unique | length' "$live_parity")" = "12"
test "$(yq '[.agents[].repository] | unique | length' "$live_parity")" = "12"
test "$(yq '[.agents[] | select((.agent_id | type) != "!!str" or (.agent_id | length) == 0)] | length' "$live_parity")" = "0"
test "$(yq '[.agents[] | select((.repository | type) != "!!str" or (.repository | length) == 0)] | length' "$live_parity")" = "0"
test "$(yq '[.agents[] | select((.editor_url | type) != "!!str" or (.editor_url | length) == 0)] | length' "$live_parity")" = "0"
test "$(yq '[.agents[] | select((.instruction_path | type) != "!!str" or (.instruction_path | length) == 0)] | length' "$live_parity")" = "0"
test "$(yq '[.agents[] | select((.knowledge_path | type) != "!!str" or (.knowledge_path | length) == 0)] | length' "$live_parity")" = "0"
test "$(yq '[.agents[] | select(.actions_policy != "none" and .actions_policy != "required")] | length' "$live_parity")" = "0"

parity_ids="$(yq -r '.agents[].agent_id' "$live_parity")"
while IFS= read -r canonical_agent_id; do
  if ! printf '%s\n' "$parity_ids" | grep -Fqx -- "$canonical_agent_id"; then
    echo "missing live parity entry: $canonical_agent_id" >&2
    exit 1
  fi

  canonical_repository="$(yq -r ".agents[] | select(.id == \"$canonical_agent_id\") | .repository" "$agents")"
  parity_repository="$(yq -r ".agents[] | select(.agent_id == \"$canonical_agent_id\") | .repository" "$live_parity")"
  if [[ "$canonical_repository" != "$parity_repository" ]]; then
    echo "live parity repository mismatch for $canonical_agent_id" >&2
    exit 1
  fi

  editor_url="$(yq -r ".agents[] | select(.agent_id == \"$canonical_agent_id\") | .editor_url" "$live_parity")"
  if [[ ! "$editor_url" =~ ^https://chatgpt\.com/gpts/editor/g-[A-Za-z0-9]+$ ]]; then
    echo "invalid live parity editor URL for $canonical_agent_id" >&2
    exit 1
  fi

  instruction_path="$(yq -r ".agents[] | select(.agent_id == \"$canonical_agent_id\") | .instruction_path" "$live_parity")"
  knowledge_path="$(yq -r ".agents[] | select(.agent_id == \"$canonical_agent_id\") | .knowledge_path" "$live_parity")"
  if [[ "$instruction_path" == /* || "$instruction_path" == *".."* || "$knowledge_path" == /* || "$knowledge_path" == *".."* ]]; then
    echo "unsafe live parity path for $canonical_agent_id" >&2
    exit 1
  fi
done < <(yq -r '.agents[].id' "$agents")
