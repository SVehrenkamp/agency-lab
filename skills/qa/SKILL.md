---
name: agency-lab-qa
description: Run the Review/QA phase of an Agency Lab project — thoroughly test and review each delivered feature against its requirements before it's considered done, producing QA reports and review checklists. Use this whenever reviewing or QAing a delivered feature, verifying it meets scope acceptance, UX flows, edge cases, and the design system, checking stability before sign-off, or closing out a feature in an agency-lab project (look for a knowledge-base/ with 08-implementation and 09-qa folders). Sign-off is a human act. Not for building or fixing the feature (that's the Implementation phase) or test strategy at architecture time.
---

# Agency Lab — Review / QA Phase

QA is the gate every delivered feature passes through before it counts as done. Its job is
to verify a feature is both **correct** (it meets its requirements) and **stable** (it
holds up), and to make that judgment against the requirements the project already wrote
down — not against vibes. Like Implementation, QA **loops**: it runs once per delivered
feature, and the V1 release is shippable only when every feature has cleared it.

This phase runs **`mode:collab`**: testing can be automated, but the sign-off is a human
act. QA never self-approves a feature as done.

The boundary: QA *judges and reports*; it does not fix. A failed check goes back to
Implementation as a defect, not patched quietly here.

## The phase contract

- **Consumes:** the delivered feature (its code + `08-implementation/test-plans/` entry) and its requirements: `04-scoping/v1-scope.md` acceptance, `05-ux/user-flows.md` + `edge-cases.md`, and `06-design/design.md`
- **Produces:** `knowledge-base/09-qa/qa-reports.md`, `review-checklists/`
- **Engine:** `engineering:testing-strategy`
- **Milestone:** `09 · Review / QA`

All paths are relative to the project root (the folder containing `knowledge-base/`).

## 1. Preflight

Confirm you're in an Agency Lab project. Read `knowledge-base/09-qa/README.md` for
project-specific notes. Identify which delivered feature you're reviewing and find its
iteration plan and test plan in `08-implementation/`.

## 2. Assemble the requirements

A feature's bar is the union of what the upstream artifacts already committed to:

- **Scope acceptance** — the `v1-scope.md` acceptance note for this capability.
- **Behavior** — the `user-flows.md` paths it implements and the `edge-cases.md` states it
  must handle (empty, error, permission, offline — the ones products skip).
- **Surface** — does it match `design.md`: tokens, components, states?
- **Stability** — does it pass its `test-plans/` entry, and does it hold under the edges?

## 3. Review and test

Use `engineering:testing-strategy` to structure the pass. Walk every flow the feature
touches and every state it should reach. Where checks can be automated, write and run them
rather than eyeballing — automated checks are repeatable when the feature changes later.
Record each check as pass/fail with evidence, not just a verdict.

Be specific about failures: what was expected, what happened, and which requirement it
violates. A vague "looks off" doesn't help Implementation fix it.

## 4. Produce the artifacts

Start `qa-reports.md` from `knowledge-base/_templates/_artifact-template.md`. Frontmatter:
`phase: 09 · Review / QA`, `status: draft` → `in-review`, `mode: collab`,
`consumes:` the feature's test plan and the requirement paths, `produced:` today's date
(`date +%F`).

- **`review-checklists/<feature>.md`** — the per-feature checklist: each requirement as a
  checked/unchecked line with evidence.
- **`qa-reports.md`** — the running record of feature reviews: result, defects found, and
  the disposition (passed / sent back to Implementation).

## 5. Disposition & sign-off

Two outcomes per feature:

- **Pass** — every requirement met and stable. Mark the report `in-review` and hand to a
  human for sign-off. **Sign-off is a human act, never automatic** — only a person sets the
  feature's acceptance. On approval, the feature is done.
- **Fail** — send it back to Implementation as a defect with specifics. This is the loop
  working as intended, not a setback.

If QA reveals a requirement itself was wrong or missing (not a code defect), append a row
to the relevant upstream artifact's amendment log (`v1-scope.md`, a `05-ux/` doc, or
`design.md`) and open an `amendment` issue if on GitHub — don't rewrite it.

When every V1 feature has passed, V1 is shippable. On GitHub, mirror feature reviews as
issues under the `09 · Review / QA` milestone; if `gh` isn't set up, skip silently — the
knowledge base is the source of truth.
