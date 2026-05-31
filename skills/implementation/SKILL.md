---
name: agency-lab-implementation
description: Run the Implementation phase of an Agency Lab project — break V1 into phased, testable iterations and build them against the approved architecture, producing iteration plans, test plans, and code. Use this whenever starting implementation, planning a build iteration or sprint, writing feature code against the architecture and design system, or preparing a feature for QA in an agency-lab project (look for a knowledge-base/ with 07-dev-kickoff and 08-implementation folders). Each iteration ends by handing a testable feature to the QA phase. Not for deciding the architecture (that's Dev Kickoff) or final feature sign-off (that's the QA phase).
---

# Agency Lab — Implementation Phase

Implementation builds V1 — in phased, testable increments rather than one big push. Each
iteration delivers a slice that a human (or a test) can actually exercise, then hands it
to QA. Unlike the document phases, this one **loops**: plan an iteration, build it, hand
the delivered feature to the QA phase, and come back for the next. The phase as a whole
completes when every V1 scope item has been built and passed QA.

This phase runs **mixed mode**: planning and building can auto-draft, but code review and
acceptance are `mode:collab` — a human signs off on what merges.

The boundary: Implementation builds against the architecture as decided; it does not
redesign it. When the code reveals an architectural problem, that's an amendment back to
Dev Kickoff (see step 5), not a quiet divergence.

## The phase contract

- **Consumes:** `knowledge-base/07-dev-kickoff/architecture.md` + `system-design.md` + `adr/`, plus `04-scoping/v1-scope.md`, `06-design/design.md`, and `05-ux/` for behavior
- **Produces:** `knowledge-base/08-implementation/iteration-plans/`, `test-plans/`, and the project's code
- **Engine:** `product-management:sprint-planning` (iteration planning) and `engineering:code-review`
- **Milestone:** `08 · Implementation`

All paths are relative to the project root (the folder containing `knowledge-base/`).

## 1. Preflight

Confirm you're in an Agency Lab project. Read `knowledge-base/08-implementation/README.md`
for project-specific notes. Check that `07-dev-kickoff` artifacts are `approved` — building
on an unapproved architecture is how rework happens; surface it if they aren't.

## 2. Plan the iterations

Using `product-management:sprint-planning`, slice `v1-scope.md` into a sequence of
iterations, each one independently **testable** and end-to-end meaningful (a thin vertical
slice beats a horizontal layer nobody can exercise). Order them so the riskiest or most
foundational work comes first. Write the plan to `iteration-plans/`.

For each iteration, write a `test-plans/` entry up front: what "working" means for this
slice, derived from the scope's acceptance notes and the relevant UX flows and edge cases.
Writing the test plan before the code keeps the iteration honest.

## 3. Build the iteration

Implement the slice against the architecture, the design system (`design.md` for exact
tokens and components), and the UX flows (including the empty/error states — they're not
optional). Keep changes reviewable. Run `engineering:code-review` on your own work before
calling a slice done — check correctness, edge cases, error handling, and security.

When the slice is built and self-reviewed, it's a **delivered feature**: hand it to the QA
phase (`09 · Review / QA`) with its test plan. Do not mark it done yourself — QA sign-off
is what closes a feature.

## 4. Produce the artifacts

Iteration plans and test plans are markdown; start them from
`knowledge-base/_templates/_artifact-template.md`. Frontmatter:
`phase: 08 · Implementation`, `status: draft` → `in-review`, `mode: draft-then-approve`,
`consumes:` the dev-kickoff/scope/design paths, `produced:` today's date (`date +%F`).

Code lives where the architecture says it should (typically a `src/` or app directory in
the repo, not inside `knowledge-base/`). The knowledge base holds the *plans and the test
intent*; the repo holds the *code*.

## 5. Amend & hand off

The most common amendment here is architectural: a design that doesn't survive contact
with the code. When that happens, append a row to `architecture.md`'s amendment log (or add
a superseding ADR note) rather than silently diverging, and open an `amendment` issue if on
GitHub. If the code reveals a scope or flow gap, amend `v1-scope.md` or the `05-ux/` doc.

Each iteration hands its delivered feature to QA at `status: in-review`. **Acceptance is a
human act** — a feature is done only when QA signs off, never because the build finished.
The phase completes when all V1 iterations are delivered and QA-passed; then tee up the
project-level review. On GitHub, mirror iterations as issues/PRs under the `08 ·
Implementation` milestone; if `gh` isn't set up, skip silently.

## A note on the loop

Implementation and QA interleave per feature, not strictly in sequence. Build a slice →
QA it → build the next. Treat each QA pass as that feature's gate; the milestone advances
only when the whole V1 set has cleared.
