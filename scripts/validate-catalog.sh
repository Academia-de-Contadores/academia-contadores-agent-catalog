#!/usr/bin/env bash
set -euo pipefail
test "$(yq '.agents | length' catalog/agents.yaml)" = "12"
test "$(yq '[.agents[].id] | unique | length' catalog/agents.yaml)" = "12"
test "$(yq '[.agents[].repository] | unique | length' catalog/agents.yaml)" = "12"
test "$(yq '.aliases | length > 0' catalog/aliases.yaml)" = "true"
