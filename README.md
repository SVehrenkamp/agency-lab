# Agency Lab

**A phase-gated framework — and the tooling to run it — for taking new product and
business ideas from spark to shipped, with the rigor of waterfall and the momentum of
experimentation.**

Agency Lab gives an idea a disciplined path: each phase nails down its details before the
next begins, learnings flow backward without stalling progress, and every decision,
document, and design is captured in a structured knowledge base that lives in the repo.

---

## Why it exists

The fast way to build — start from a vision and execute immediately — is great for
experimentation and terrible for finishing. Features get bolted on. Task tracking
scatters. Documentation is sporadic. UX and design become afterthoughts. The result is
quick to prototype and painful to polish.

Agency Lab fixes this by spending real time in each phase, while deliberately protecting
the speed that makes experimentation work. Two commitments shape everything:

- **Rigor is earned, not imposed.** Most ideas should die cheaply, before any heavyweight
  process touches them. An idea only enters the full pipeline once you consciously promote
  it.
- **Momentum over re-litigation.** When a later phase contradicts an earlier decision, you
  *record* the contradiction and keep moving, then reconcile it at the next gate — instead
  of stopping to rewrite.

The full rationale lives in **[FRAMEWORK.md](FRAMEWORK.md)**.

---

## How it works

### The pipeline

```
  Spark ──(graduation gate)──▶ Kickoff ─▶ Research ─▶ Refinement ─▶ Scoping
                                                                       │
   QA ◀─ Implementation ◀─ Dev Kickoff ◀─ Design ◀─ UX/Wireframing ◀──┘

  ▲ amendments flow backward at every step; gates reconcile them forward
```

**Spark** is a cheap front door — a paragraph and a gut-check. Only ideas you promote
cross the **graduation gate** into the heavyweight phases. The first seven phases run once,
in sequence; **Implementation and QA loop per feature** (build a testable slice, QA it,
repeat).

### The phases

| # | Phase | Produces | Default mode |
|---|-------|----------|--------------|
| 0 | **Spark** | `spark.md` | collab |
| 1 | **Kickoff** | `problem-brief.md`, `shared-understanding.md` | draft → grill-me |
| 2 | **Research** | `competitive-landscape.md`, `pricing-teardown.md`, `sentiment-analysis.html` | auto |
| 3 | **Refinement** | `prd.md`, `product-edge.md` | draft → grill-me |
| 4 | **Scoping** | `v1-scope.md`, `out-of-scope.md` | draft-then-approve |
| 5 | **UX / Wireframing** | `user-flows.md`, `edge-cases.md`, `wireframes.html` | draft → review |
| 6 | **Design** | `brand-brief.md`, `design-system.html`, `design.md`, `designs.html` | collab + draft |
| 7 | **Dev Kickoff** | `architecture.md`, `system-design.md`, `adr/*.md` | draft → review |
| 8 | **Implementation** | iteration plans, test plans, code | draft + collab |
| 9 | **Review / QA** | `qa-reports.md`, `review-checklists/` | collab (sign-off) |

### Core concepts

- **Artifact contracts.** Each phase is defined by the artifacts it *consumes* and
  *produces*, not by its position. That's what lets the same framework serve a brand-new
  project (run every phase) and an existing one (re-enter at the first missing artifact).
- **The knowledge base.** A structured store of every artifact, version-controlled in the
  repo. Markdown for prose and decisions; HTML for what markdown can't render (dashboards,
  the design system, wireframes). The knowledge base *is* the repo.
- **The amendment log.** Every artifact ends with an append-only table. When a later phase
  contradicts it, you add a row — you don't rewrite the doc. Nothing silently drifts.
- **Gates.** At each phase boundary, a human reviews the accumulated amendments and decides
  *absorb* or *reopen*, then approves the advance. Advancing a phase is always a human act.
- **Modes.** The default is **draft-then-approve** (a machine drafts, a human judges), with
  `mode:auto` and `mode:collab` as the overrides.

---

## What's in this repo

This repo is itself the GitHub template — the scaffold lives at the root, so a project
created from it is ready to go.

```
agency-lab/
├── README.md                  ← you are here
├── FRAMEWORK.md               ← the full framework spec and rationale
├── CLAUDE.md                  ← orients Claude Code when working in a project
├── knowledge-base/            ← the 10 phase folders + artifact template
│   ├── 00-spark/ … 09-qa/     ← one folder per phase, each with a README
│   └── _templates/            ← _artifact-template.md (carries the amendment log)
├── .github/ISSUE_TEMPLATE/    ← Spark / Artifact / Amendment / Gate-Review forms
├── scripts/                   ← setup.sh (milestones+labels) · update.sh (pull framework updates) · build-plugin.sh
├── plugin/                    ← Cowork plugin manifest (built into agency-lab.plugin)
└── .claude/skills/            ← the orchestration layer: one skill per phase (auto-loaded by Claude Code)
    ├── README.md              ← the shared phase-skill pattern
    ├── kickoff/ research/ refinement/ scoping/ ux/
    └── design/ dev-kickoff/ implementation/ qa/
```

There are two buildable pieces, and they're both here:

1. **The template** — the root scaffold (`knowledge-base/`, `.github/`, `scripts/`) that
   makes every project structurally identical: the same phase folders, milestones, labels,
   and issue forms. Because the repo is marked as a GitHub template, new projects copy it
   with one command.
2. **The phase skills** ([`.claude/skills/`](.claude/skills/)) — nine skills, one per phase, that read the
   upstream artifacts, run the phase's work (each wrapping a proven engine skill), and
   write outputs into the right knowledge-base folder.

---

## Quick start

### 1. Create a project from the template

`SVehrenkamp/agency-lab` is a [GitHub template
repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository),
so a new project is one line:

```bash
gh repo create my-new-idea --template SVehrenkamp/agency-lab --private --clone && cd my-new-idea
```

Or click **Use this template → Create a new repository** on the repo page.

Each new project starts with the full scaffold at its root — the `knowledge-base/` folders,
the `.github/` issue forms, and `scripts/setup.sh` — and carries the framework (`FRAMEWORK.md`)
and the phase skills (`.claude/skills/`) along with it, so the project is self-contained.

### 2. Bootstrap milestones and labels

GitHub's template feature copies files but **not** milestones, labels, or issues — so run
the setup script once per project:

```bash
chmod +x scripts/setup.sh   # if it didn't carry over as executable
./scripts/setup.sh
```

It creates the ten phase milestones (`00 · Spark` … `09 · Review / QA`) and the label set
(`spark`, `artifact`, `amendment`, `severity:minor/major`, `mode:auto`, `mode:collab`,
`gate`, `blocked`). Requires the [GitHub CLI](https://cli.github.com) authenticated via
`gh auth login`. It's idempotent — safe to re-run.

> **GitHub is optional.** The knowledge base is the source of truth; GitHub is bookkeeping
> on top of it. Every phase skill degrades gracefully if `gh` isn't set up — you can run
> the whole framework in the files alone.

### 3. Drop in your idea at Spark

Open a **Spark** issue (or create `knowledge-base/00-spark/spark.md` from
`knowledge-base/_templates/_artifact-template.md`): one paragraph and a gut-check. Most
sparks stay parked. When you decide an idea is worth it, mark it **Promote** and move it to
the `01 · Kickoff` milestone — that's the graduation gate.

### 4. Run the phases with the skills

Each phase has a skill in [`.claude/skills/`](.claude/skills/) that drives it. With the skills available to
Claude, kicking off a phase is as simple as asking:

> "Run the Kickoff phase for my FieldNote idea."

The skill reads the upstream artifacts, runs the work, and writes the outputs into the
right knowledge-base folder. Every phase follows the same five beats:

1. **Preflight** — locate the knowledge base, read the phase's notes.
2. **Consume** — read the upstream artifacts (and stop if they aren't approved).
3. **Work** — run the phase's job via its engine skill.
4. **Produce** — write outputs from the artifact template, into the phase folder.
5. **Amend & hand off** — log any contradictions upstream, then hand to a human gate.

When a phase is drafted, its artifacts sit at `status: in-review` until you review and
approve them (`status: approved`). Then you walk through the gate to the next phase.

### 5. Loop Implementation and QA per feature

Once you reach building, Implementation slices V1 into testable increments. Each delivered
slice goes through QA before it counts as done; a failed check goes back to Implementation
as a defect. The `08 · Implementation` milestone advances only when the whole V1 set has
cleared QA — at which point V1 is shippable.

---

## Updating an existing project

Projects created from the template aren't linked to it, so framework improvements don't
arrive automatically. The update script pulls them in. It syncs **only framework files**
(skills, `FRAMEWORK.md`, `CLAUDE.md`, issue forms, scripts, and the knowledge-base
scaffolding) and **never touches your artifacts, your code, or your README** — those are
yours. It also won't run with a dirty tree, so the changes are always easy to review and undo.

```bash
./scripts/update.sh
```

The changes land staged; review with `git diff --cached`, then commit. If you use the
Cowork plugin, rebuild it afterward with `./scripts/build-plugin.sh`. (Updating from a fork
or mirror? Pass its URL: `./scripts/update.sh <git-url>`.)

**Older projects** created before the update script existed won't have it yet — bootstrap it
once, then use it normally from then on:

```bash
git remote add agency-lab-template https://github.com/SVehrenkamp/agency-lab.git
git fetch agency-lab-template
git checkout agency-lab-template/main -- scripts/update.sh
./scripts/update.sh
```

---

## The phase skills

Each skill carries its own methodology plus the artifact-contract plumbing, and *optionally*
leans on a proven "engine" skill for extra depth when that plugin is installed (see
[Recommended companion plugins](#recommended-companion-plugins)). The skills are
self-contained — they never break if an engine is missing. See
[`.claude/skills/README.md`](.claude/skills/README.md) for the shared pattern and the full engine map.

| Phase | Skill | Engine |
|-------|-------|--------|
| Kickoff | `.claude/skills/kickoff/` | `product-management:brainstorm` (grill-me) |
| Research | `.claude/skills/research/` | `product-management:competitive-brief` + web search |
| Refinement | `.claude/skills/refinement/` | `product-management:write-spec` |
| Scoping | `.claude/skills/scoping/` | `product-management:write-spec` / `roadmap-update` |
| UX | `.claude/skills/ux/` | `design:user-research` / `ux-copy` |
| Design | `.claude/skills/design/` | `design:design-system` / `design-critique` |
| Dev Kickoff | `.claude/skills/dev-kickoff/` | `engineering:architecture` / `system-design` |
| Implementation | `.claude/skills/implementation/` | `product-management:sprint-planning` / `engineering:code-review` |
| QA | `.claude/skills/qa/` | `engineering:testing-strategy` |

Two rules hold across all nine: **momentum over rewrite** (contradictions are logged as
amendments, never patched silently into upstream docs) and **the gate stays human** (a
skill never self-approves an artifact, even on an unattended run).

---

## Using it in Claude Code and Cowork

The same nine skills work in both, packaged two ways:

- **Claude Code** — the skills live in `.claude/skills/`, so Claude Code **auto-loads them
  with zero setup** whenever you work inside an Agency Lab project (they travel with the
  template into every project). `CLAUDE.md` orients Claude to the framework automatically.
  Just ask, e.g. "run the Kickoff phase."
- **Cowork** — install the **Agency Lab plugin** (`agency-lab.plugin`) once, and the phase
  skills are available across your Cowork sessions. The plugin bundles the same skills and
  declares the companion plugins below as dependencies.

## Recommended companion plugins

Every phase skill works on its own. These plugins are *optional accelerators* — if
installed, a skill uses the matching "engine" for extra depth; if not, it applies the same
methodology from its own steps.

| Plugin | Engine skills it provides | Used by phases |
|--------|---------------------------|----------------|
| **product-management** | `brainstorm`, `competitive-brief`, `write-spec`, `roadmap-update`, `sprint-planning` | Kickoff, Research, Refinement, Scoping, Implementation |
| **design** | `user-research`, `ux-copy`, `design-system`, `design-critique` | UX, Design |
| **engineering** | `architecture`, `system-design`, `code-review`, `testing-strategy` | Dev Kickoff, Implementation, QA |
| **marketing** | `competitive-brief` (go-to-market angle) | Research |

In Claude Code, install these as plugins; the Agency Lab plugin declares them as
dependencies so they can auto-install alongside it.

---

## A note on design

Designs are built directly in the repo as self-contained HTML with Claude — there is **no
Figma**. `design-system.html` is the visual render, `design.md` is the canonical written
style guide that downstream phases cite, and `designs.html` composes the system into
finished screens for every UX flow. Keeping design in the knowledge base means it's
diffable and version-controlled alongside everything it's built from.

---

## Status

The framework spec, the project template, and all nine phase skills are built, and the
skills ship two ways: project-local `.claude/skills/` for Claude Code (zero setup) and the
`agency-lab` plugin for Cowork (build it with `./scripts/build-plugin.sh`). The Kickoff
skill has been validated with a cold-start test run. One decision remains parked: whether
to drive the GitHub board with Projects custom fields or plain labels (see
[FRAMEWORK.md §8](FRAMEWORK.md)).

## Learn more

- **[FRAMEWORK.md](FRAMEWORK.md)** — the full spec: phases, artifact contracts, GitHub
  mechanics, the automation model, and parked decisions.
- **[.claude/skills/README.md](.claude/skills/README.md)** — the shared phase-skill pattern and engine map.
- **[knowledge-base/README.md](knowledge-base/README.md)** — the artifact map for each phase.
