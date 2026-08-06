#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
agents="$root/catalog/agents.yaml"
aliases="$root/catalog/aliases.yaml"

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
