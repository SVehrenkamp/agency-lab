#!/usr/bin/env bash
#
# Agency Lab — per-project bootstrap
#
# GitHub's "template repository" feature copies files and folders into a new repo,
# but NOT milestones, labels, or issues. This script creates them.
#
# Run once, right after creating a new repo from the template:
#   ./scripts/setup.sh                 # operates on the repo in the current directory
#   ./scripts/setup.sh owner/name      # or target an explicit repo
#
# Requires: gh (GitHub CLI), authenticated via `gh auth login`.
# Idempotent: labels are upserted with --force; existing milestones are skipped.

set -euo pipefail

# --- resolve target repo ----------------------------------------------------
if ! command -v gh >/dev/null 2>&1; then
  echo "error: gh (GitHub CLI) is not installed — see https://cli.github.com" >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "error: not authenticated — run 'gh auth login' first" >&2
  exit 1
fi

REPO="${1:-}"
if [[ -n "$REPO" ]]; then
  REPO_ARGS=(--repo "$REPO")
  API_REPO="$REPO"
else
  API_REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
  REPO_ARGS=(--repo "$API_REPO")
fi

echo "Bootstrapping Agency Lab structure in: $API_REPO"
echo

# --- labels -----------------------------------------------------------------
# name|color|description
LABELS=(
  "spark|c5def5|An idea awaiting the graduation gate"
  "artifact|0052cc|Production of a knowledge-base artifact"
  "amendment|d93f0b|A learning that contradicts an upstream artifact"
  "severity:minor|fbca04|Minor amendment — absorb and move on"
  "severity:major|b60205|Major amendment — may warrant reopening a phase"
  "mode:auto|0e8a16|Safe to run unattended"
  "mode:collab|1d76db|Requires the human; cannot be drafted away"
  "gate|5319e7|Phase-boundary approval issue"
  "blocked|000000|Waiting on an upstream decision or dependency"
)

echo "Labels:"
for entry in "${LABELS[@]}"; do
  IFS='|' read -r name color desc <<< "$entry"
  gh label create "$name" --color "$color" --description "$desc" --force "${REPO_ARGS[@]}" >/dev/null
  echo "  ✓ $name"
done
echo

# --- milestones -------------------------------------------------------------
# Spark is not a phase milestone — a project repo is already one graduated idea.
# The idea backlog is tracked as `spark`-labeled issues at the lab level.
MILESTONES=(
  "01 · Kickoff"
  "02 · Research"
  "03 · Refinement"
  "04 · Scoping"
  "05 · UX / Wireframing"
  "06 · Design"
  "07 · Dev Kickoff"
  "08 · Implementation"
  "09 · Review / QA"
)

existing="$(gh api "repos/$API_REPO/milestones?state=all&per_page=100" -q '.[].title' 2>/dev/null || true)"

echo "Milestones:"
for title in "${MILESTONES[@]}"; do
  if grep -Fxq "$title" <<< "$existing"; then
    echo "  • $title (exists)"
  else
    gh api "repos/$API_REPO/milestones" -f title="$title" -f state="open" >/dev/null
    echo "  ✓ $title"
  fi
done
echo

echo "Done. The phase milestones (01-09) are ready — open '01 · Kickoff' to begin."
echo "(Triaging many ideas? Keep them as 'spark'-labeled issues on your Agency Lab"
echo " home repo — the backlog is a lab-level concern, not a per-project one.)"
