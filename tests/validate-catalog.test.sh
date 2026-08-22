#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
workspace="$(cd "$root/.." && pwd)"
fixture=""

if [[ ! -f "$root/catalog/live-parity.yaml" ]]; then
  echo "missing catalog/live-parity.yaml" >&2
  exit 1
fi

cleanup() {
  if [[ -n "$fixture" ]]; then
    rm -rf "$fixture"
  fi
}
trap cleanup EXIT

new_fixture() {
  fixture="$(mktemp -d)"
  mkdir -p "$fixture/catalog" "$fixture/scripts"
  cp "$root/catalog/agents.yaml" "$fixture/catalog/agents.yaml"
  cp "$root/catalog/aliases.yaml" "$fixture/catalog/aliases.yaml"
  cp "$root/catalog/live-parity.yaml" "$fixture/catalog/live-parity.yaml"
  cp "$root/scripts/validate-catalog.sh" "$fixture/scripts/validate-catalog.sh"
}

assert_rejected() {
  local name="$1"
  if (cd "$fixture" && bash scripts/validate-catalog.sh); then
    echo "expected rejection: $name" >&2
    exit 1
  fi
  rm -rf "$fixture"
  fixture=""
}

bash "$root/scripts/validate-catalog.sh"
(cd "$workspace" && bash academia-contadores-agent-catalog/scripts/validate-catalog.sh)

new_fixture
yq -i '.aliases[0].source_name = ""' "$fixture/catalog/aliases.yaml"
assert_rejected "empty source_name"

new_fixture
yq -i '.aliases[0].source_url = ""' "$fixture/catalog/aliases.yaml"
assert_rejected "empty source_url"

new_fixture
yq -i '.aliases[0].canonical_agent_id = ""' "$fixture/catalog/aliases.yaml"
assert_rejected "empty canonical_agent_id"

new_fixture
yq -i '.aliases[0].relationship = "invalid"' "$fixture/catalog/aliases.yaml"
assert_rejected "invalid relationship"

new_fixture
yq -i '.aliases[0].repository_created = true' "$fixture/catalog/aliases.yaml"
assert_rejected "repository_created true"

new_fixture
yq -i '.aliases[0].canonical_agent_id = "ac.missing"' "$fixture/catalog/aliases.yaml"
assert_rejected "unknown canonical_agent_id"

new_fixture
yq -i 'del(.agents[] | select(.agent_id == "ac.fiscal"))' \
  "$fixture/catalog/live-parity.yaml"
assert_rejected "live parity inventory missing ac.fiscal"

new_fixture
yq -i '(.agents[] | select(.agent_id == "ac.fiscal").editor_url) = "https://example.invalid"' \
  "$fixture/catalog/live-parity.yaml"
assert_rejected "live parity editor URL is not a ChatGPT editor URL"

new_fixture
yq -i '(.agents[] | select(.agent_id == "ac.fiscal").repository) = "wrong-repository"' \
  "$fixture/catalog/live-parity.yaml"
assert_rejected "live parity repository differs from canonical catalog"
