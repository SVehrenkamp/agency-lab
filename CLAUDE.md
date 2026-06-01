# Agency Lab — working agreement

This repository is an **Agency Lab project**: a phase-gated workflow for taking an idea
from spark to shipped. Read this before working in it.

## What this is

The work moves through nine phases — Kickoff → Research → Refinement → Scoping → UX →
Design → Dev Kickoff → Implementation → QA — each producing specific artifacts into the
`knowledge-base/` folder. The full spec is in `FRAMEWORK.md`.

The phase you're in is simply *which artifact is currently being produced*. Each phase has
a driver skill in `.claude/skills/<phase>/` (auto-loaded here). To run a phase, use its
skill — e.g. "run the Kickoff phase", "do the Research phase".

## Rules that always apply

- **Stay in phase.** Don't jump ahead. Architecture and implementation are deliberately
  deferred until the Dev Kickoff and Implementation phases — if they come up earlier, park
  them. Each skill states its own boundary; honor it.
- **Momentum over rewrite.** When something you learn contradicts an earlier (approved)
  artifact, don't rewrite that artifact. Append a row to its amendment log at the bottom of
  the file (and open an `amendment` issue if the project is on GitHub). Reconciliation
  happens at the next gate, not mid-phase.
- **The gate is human.** A phase's artifacts move `draft → in-review → approved`. Never set
  `status: approved` yourself — that's the human's call, and it's what advances the project
  to the next phase. Don't start the next phase until the current one is approved.
- **Don't build on unapproved ground.** Before a phase consumes an upstream artifact, check
  it's `approved`. If it isn't, surface that rather than proceeding silently.

## Where things live

- `knowledge-base/NN-phase/` — the artifacts for each phase (each folder has a README with
  its artifact contract).
- `knowledge-base/_templates/_artifact-template.md` — start every new artifact from this;
  it carries the standard frontmatter and amendment log.
- `.claude/skills/` — the phase driver skills (and `README.md` describing the shared pattern).
- `.github/ISSUE_TEMPLATE/` — Spark / Artifact / Amendment / Gate-Review issue forms.
- `scripts/setup.sh` — one-time bootstrap of milestones + labels (needs `gh`).
- `scripts/update.sh` — pull the latest framework files from the template into this project
  (framework only; never your artifacts or README).
- `scripts/build-plugin.sh` — rebuild the Cowork `agency-lab.plugin` from `.claude/skills/`.

## Optional companion plugins

Each phase skill names an optional "engine" skill (from the product-management, design, and
engineering plugins) that deepens the work *if installed*. They are not required — every
skill is self-contained and degrades gracefully without them. See the README for the list.
