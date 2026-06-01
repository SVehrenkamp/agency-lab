#!/usr/bin/env bash
#
# Build the Agency Lab Cowork/Claude Code plugin (.plugin bundle) from the canonical
# skills in .claude/skills/. Single source of truth — no duplicated skill tree.
#
#   ./scripts/build-plugin.sh                 # outputs dist/agency-lab.plugin
#   ./scripts/build-plugin.sh /path/out.plugin
#
# Requires: zip (and a POSIX shell). Run from anywhere; paths resolve to the repo root.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-$ROOT/dist/agency-lab.plugin}"

BUILD="$(mktemp -d)/agency-lab"
mkdir -p "$BUILD/.claude-plugin" "$BUILD/skills"

cp "$ROOT/plugin/.claude-plugin/plugin.json" "$BUILD/.claude-plugin/plugin.json"
cp "$ROOT/plugin/README.md" "$BUILD/README.md"
cp -R "$ROOT/.claude/skills/." "$BUILD/skills/"

# zip the plugin root (so .claude-plugin/ and skills/ sit at the archive root)
rm -f /tmp/agency-lab.plugin
( cd "$BUILD" && zip -rq /tmp/agency-lab.plugin . -x '*.DS_Store' )

mkdir -p "$(dirname "$OUT")"
cp /tmp/agency-lab.plugin "$OUT"
echo "Built: $OUT"
echo "Skills bundled: $(find "$BUILD/skills" -name SKILL.md | wc -l | tr -d ' ')"
