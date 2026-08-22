#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
snapshot="$root/snapshots/2026-08-22/builder-evidence.json"
validator="$root/scripts/validate-live-parity.sh"
fixture="$(mktemp -d)"
trap 'rm -rf "$fixture"' EXIT

test -f "$snapshot"
bash "$validator" "$snapshot"

cp "$snapshot" "$fixture/tampered-instruction.json"
jq '(.agents[] | select(.agent_id == "ac.dp").instruction.local_sha256) = "0000000000000000000000000000000000000000000000000000000000000000"' \
  "$fixture/tampered-instruction.json" > "$fixture/next.json"
mv "$fixture/next.json" "$fixture/tampered-instruction.json"
if bash "$validator" "$fixture/tampered-instruction.json" >/dev/null 2>&1; then
  echo "expected tampered instruction evidence to be rejected" >&2
  exit 1
fi

cp "$snapshot" "$fixture/tampered-knowledge.json"
jq '(.agents[] | select(.agent_id == "ac.guia-operacao").knowledge[0].sha256) = "0000000000000000000000000000000000000000000000000000000000000000"' \
  "$fixture/tampered-knowledge.json" > "$fixture/next.json"
mv "$fixture/next.json" "$fixture/tampered-knowledge.json"
if bash "$validator" "$fixture/tampered-knowledge.json" >/dev/null 2>&1; then
  echo "expected tampered knowledge evidence to be rejected" >&2
  exit 1
fi

cp "$snapshot" "$fixture/tampered-action.json"
jq '(.agents[] | select(.agent_id == "ac.reforma-tributaria-rag").action.semantic_sha256) = "0000000000000000000000000000000000000000000000000000000000000000"' \
  "$fixture/tampered-action.json" > "$fixture/next.json"
mv "$fixture/next.json" "$fixture/tampered-action.json"
if bash "$validator" "$fixture/tampered-action.json" >/dev/null 2>&1; then
  echo "expected tampered Action evidence to be rejected" >&2
  exit 1
fi

echo "validate-live-parity tests passed"
