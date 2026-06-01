---
name: agency-lab-refinement
description: Run the Refinement phase of an Agency Lab project — repeat the kickoff grill-me, now armed with the research, to sharpen the product's defensible edge and produce a real PRD. Use this whenever starting refinement, writing or refining a PRD, defining the product edge or differentiation, or when an approved competitive landscape is ready to be applied back to the idea in an agency-lab project (look for a knowledge-base/ with 02-research and 03-refinement folders). This is where research either confirms or reshapes the original idea. Not for the first-pass grill-me with no research yet (that's the Kickoff phase) or for cutting V1 scope (that's the Scoping phase).
---

# Agency Lab — Refinement Phase

Refinement is Kickoff done a second time — but now grounded in evidence instead of
instinct. You take the problem brief back out and run it through everything Research
turned up, asking the harder question: given who's already in this space, how they win,
and what their users complain about, *where is the real, defensible edge here* — and is
the original idea still the right one?

This phase runs **draft-then-approve**: you drive the grill-me and draft the artifacts;
the human's judgment closes the phase.

The boundary that keeps Refinement honest: it sharpens *what the product is and why it
wins*, but it does **not** decide what V1 builds (that's Scoping) and does not touch
architecture (that's Dev Kickoff). The PRD here describes the full, real product — the
cut to an MVP comes next.

## The phase contract

- **Consumes:** `knowledge-base/01-kickoff/problem-brief.md` + `shared-understanding.md` and all of `knowledge-base/02-research/`
- **Produces:** `knowledge-base/03-refinement/prd.md`, `product-edge.md`
- **Engine (optional):** `product-management:write-spec` — used if installed; otherwise apply the same methodology from this skill's steps
- **Milestone:** `03 · Refinement`

All paths are relative to the project root (the folder containing `knowledge-base/`).

## 1. Preflight

Confirm you're in an Agency Lab project. Read `knowledge-base/03-refinement/README.md`
for project-specific notes.

## 2. Consume kickoff + research

Read the problem brief, the shared-understanding doc, and the three research artifacts
(`competitive-landscape.md`, `pricing-teardown.md`, `sentiment-analysis.html`). Check
their frontmatter `status`: if the research artifacts aren't `approved`, surface that —
refining against ungated research means redoing it if the research changes. Let the user
decide explicitly if they want to proceed anyway.

Pay special attention to the **disliked** sentiment themes and the **open / crowded**
read from the landscape — those are where edges hide.

## 3. Run the grill-me, grounded in evidence

Adopt the sparring posture from Kickoff, but now every claim is testable against the
research. Push on:

- **Does the wedge survive contact with the market?** The problem brief named a wedge.
  Is it already owned? Underserved? Confirmed by what users complain about?
- **Where is the defensible edge?** Not just a feature competitors lack, but something
  that fits an underserved user and a gap the landscape shows is open.
- **What did research change?** Be explicit about assumptions the market contradicted —
  these should already be in the problem brief's amendment log from the Research gate;
  fold the absorbed ones into the refined view here.
- **Is this still the right idea?** Refinement is allowed to conclude the idea should
  pivot. That's a successful outcome, not a failure.

## 4. Produce the artifacts

Start each from `knowledge-base/_templates/_artifact-template.md`. Frontmatter:
`phase: 03 · Refinement`, `status: draft` while writing, `mode: draft-then-approve`,
`consumes:` the kickoff and research paths, `produced:` today's date (`date +%F`),
`approved:` blank.

- **`product-edge.md`** — the sharp, defensible articulation of why this wins: the wedge,
  the specific differentiation against the *grouped* competitors, and the opportunity gap
  Research exposed. This is the strategic spine the rest of the project defends.
- **`prd.md`** — the refined product requirements: what the product is, who it serves, the
  core capabilities and the user value of each, the key requirements and constraints, and
  the success metrics. It describes the *full* product, not a V1 cut. Tie requirements back
  to the edge so scope decisions later have a rationale to lean on.

## 5. Amend & hand off

Refinement consumes both Kickoff and Research, so it can dent either. If it reveals the
research missed a competitor or mis-read a theme, append a row to that research artifact's
amendment log (don't rewrite it). If it reshapes the problem itself, amend the problem
brief. Open an `amendment` issue if the project is on GitHub. Record and continue.

When the artifacts are drafted, set each to `status: in-review` and hand off. **Approval
is a human act, never automatic** — never self-approve. Once a person approves (sets
`status: approved` with an `approved:` date), tee up the next gate: if on GitHub, open a
`[Gate] Advance from 03 Refinement to 04 Scoping` gate-review issue; otherwise tell the
user Refinement is approved and Scoping is next. Do not start Scoping yourself.

## GitHub (optional, degrade gracefully)

If `gh` is authenticated, mirror the work as `[Artifact]` issues under the
`03 · Refinement` milestone and close them on approval. If not, skip silently and work in
the files — the knowledge base is the source of truth.
