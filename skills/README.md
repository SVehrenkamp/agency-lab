# Agency Lab — Phase Skills

The orchestration layer of the [Agency Lab Framework](../FRAMEWORK.md). One skill per
phase. Each skill doesn't reinvent the methodology — it wraps a generic skill you
already have (the *engine*) and adds the artifact-contract I/O around it (the
*plumbing*) so that work flows in and out of the knowledge base correctly.

## The shared pattern

Every phase skill follows the same five-beat spine. When building the remaining
phases, copy `kickoff/SKILL.md` and re-fill each beat — the structure stays identical.

1. **Preflight** — locate `knowledge-base/`, confirm we're in an Agency Lab project,
   read the phase's own `NN-*/README.md` for project-specific notes.
2. **Consume** — read the upstream artifacts this phase depends on. If a required
   upstream artifact is missing or still `draft`, stop and surface that — a phase
   should not build on unapproved ground.
3. **Work** — run the phase's actual job, using its backing skill as the engine.
4. **Produce** — write outputs into the phase's KB folder, each started from
   `knowledge-base/_templates/_artifact-template.md`, with frontmatter filled in.
5. **Amend & hand off** — log any contradictions against upstream artifacts (don't
   rewrite them), then tee up the gate review. Advancing a phase is always a human act.

## Two rules that hold across every phase

**Momentum over rewrite.** When a phase reveals that an upstream artifact was wrong,
append a row to that artifact's amendment log (and open an `amendment` issue if the
project is on GitHub). Do not stop and rewrite the upstream doc — that's the gate
review's job. This is the single most important behavior; it's what keeps the
framework from stalling.

**Default mode is draft-then-approve.** The skill drafts; the human applies judgment.
Only deviate where the phase README marks `mode:auto` or `mode:collab`.

## Phase → engine map

| Phase | Skill folder | Backing skill (engine) | Consumes | Produces |
|-------|--------------|------------------------|----------|----------|
| 01 Kickoff | `kickoff/` | `product-management:brainstorm` | `00-spark/spark.md` | `problem-brief.md`, `shared-understanding.md` |
| 02 Research | `research/` | `product-management:competitive-brief` | `01-kickoff/problem-brief.md` | `competitive-landscape.md`, `pricing-teardown.md`, `sentiment-analysis.html` |
| 03 Refinement | `refinement/` | `product-management:write-spec` | kickoff + research | `prd.md`, `product-edge.md` |
| 04 Scoping | `scoping/` | `product-management:write-spec` / `roadmap-update` | `03-refinement/prd.md` | `v1-scope.md`, `out-of-scope.md` |
| 05 UX | `ux/` | `design:user-research` | `04-scoping/v1-scope.md` | `user-flows.md`, `edge-cases.md`, `wireframes.html` |
| 06 Design | `design/` | `design:design-system` | scope + prd + ux | `brand-brief.md`, `design-system.html`, `design.md`, `designs.html` |
| 07 Dev Kickoff | `dev-kickoff/` | `engineering:architecture` | all upstream | `architecture.md`, `system-design.md`, `adr/*.md` |
| 08 Implementation | `implementation/` | `product-management:sprint-planning` | `07-dev-kickoff/*` | iteration + test plans, code |
| 09 QA | `qa/` | `engineering:testing-strategy` | each delivered feature | `qa-reports.md`, `review-checklists/*` |

**All nine phase skills are built.** Kickoff (the reference pattern), Research,
Refinement, Scoping, UX, Design, Dev Kickoff, Implementation, and QA.

One structural note: the first seven phases run once, in sequence. **Implementation and
QA interleave per feature** — build a testable slice, QA it, repeat — so they loop rather
than running strictly once. Each QA pass is that feature's gate; the milestone advances
only when the whole V1 set has cleared.
