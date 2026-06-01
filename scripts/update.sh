#!/usr/bin/env bash
#
# Update an Agency Lab project with the latest framework changes from the template.
#
# Projects created from the template are NOT linked to it, so this script pulls the
# framework files in directly. It only touches *framework* paths — your knowledge-base
# artifacts, your code, and your README are never modified.
#
#   ./scripts/update.sh                       # update from SVehrenkamp/agency-lab
#   ./scripts/update.sh <git-url-or-path>     # update from a fork or local mirror
#
# After it runs, the framework changes are staged; review with `git diff --cached`
# and commit when you're happy.

set -euo pipefail

REMOTE="agency-lab-template"
TEMPLATE_URL="${1:-https://github.com/SVehrenkamp/agency-lab.git}"

# Framework paths that get synced. Everything else in your project is left alone.
# (README.md and .gitignore are intentionally excluded — those are yours to customize.)
PATHS=(.claude .github CLAUDE.md FRAMEWORK.md plugin scripts knowledge-base)

# --- preconditions ----------------------------------------------------------
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "error: run this from inside your project's git repository." >&2
  exit 1
fi

# Move to the repo root so the pathspecs resolve consistently.
cd "$(git rev-parse --show-toplevel)"

if [[ -n "$(git status --porcelain)" ]]; then
  echo "error: you have uncommitted changes." >&2
  echo "       Commit or stash them first so the update is easy to review and undo." >&2
  exit 1
fi

# --- fetch the template -----------------------------------------------------
if git remote get-url "$REMOTE" >/dev/null 2>&1; then
  git remote set-url "$REMOTE" "$TEMPLATE_URL"
else
  git remote add "$REMOTE" "$TEMPLATE_URL"
fi

echo "Fetching latest framework from $TEMPLATE_URL ..."
git fetch -q "$REMOTE"

# Resolve the template's default branch (main, master, …).
BRANCH="$(git remote show "$REMOTE" 2>/dev/null | sed -n 's/.*HEAD branch: //p')"
BRANCH="${BRANCH:-main}"
REF="$REMOTE/$BRANCH"

# --- sync framework paths ---------------------------------------------------
echo "Updating framework files from $REF ..."
updated=0
for p in "${PATHS[@]}"; do
  if git cat-file -e "$REF:$p" 2>/dev/null; then
    git checkout "$REF" -- "$p"
    echo "  updated $p"
    updated=1
  else
    echo "  (skip $p — not present in template)"
  fi
done

echo
if [[ "$updated" -eq 0 || -z "$(git status --porcelain)" ]]; then
  echo "Already up to date — no framework changes to apply."
  exit 0
fi

echo "Framework files are staged. Review and commit:"
echo "    git diff --cached"
echo "    git commit -m \"Update Agency Lab framework from template\""
echo
echo "Your knowledge-base artifacts, code, and README were left untouched."
echo "If you use the Cowork plugin, rebuild it with ./scripts/build-plugin.sh"
