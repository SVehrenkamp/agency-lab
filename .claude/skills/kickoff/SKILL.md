---
name: agency-lab-kickoff
description: Run the Kickoff phase of an Agency Lab project — a thorough grill-me session that builds shared understanding of a newly promoted idea and produces its problem brief. Use this whenever starting kickoff, running a grill-me or kickoff session, writing a problem-brief or shared-understanding doc, or when an idea has just crossed the graduation gate from spark into Kickoff in an agency-lab project (look for a knowledge-base/ with 00-spark and 01-kickoff folders). Deliberately avoids architecture and implementation. Not for refining an idea against research (that's the Refinement phase) or deciding V1 scope (that's Scoping).
---

# Agency Lab — Kickoff Phase

Kickoff is the first heavyweight phase, right after an idea crosses the graduation
gate from Spark. Its only job is to reach genuine shared understanding of *what the
idea is* and *why it matters* — through interrogation, not agreement-by-default.

There is one hard boundary, and it's the whole point of the phase: **do not discuss
architecture, tech stack, or implementation.** If those come up, name them and park
them ("good — that's a Dev Kickoff question, noting it for later"). Kickoff that
drifts into solutioning produces the exact bolted-on-features problem this framework
exists to prevent.

This phase runs **draft-then-approve**: you drive the grill-me and draft the
artifacts; the human's judgment is what closes the phase.

## The phase contract

- **Consumes:** `knowledge-base/00-spark/spark.md` (a *promoted* spark)
- **Produces:** `knowledge-base/01-kickoff/problem-brief.md`, `knowledge-base/01-kickoff/shared-understanding.md`
- **Engine (optional):** the grill-me posture from `product-management:brainstorm` — used if installed; otherwise apply the same methodology from this skill's steps
- **Milestone:** `01 · Kickoff`

## 1. Preflight

Confirm you're in an Agency Lab project: there should be a `knowledge-base/` directory
with numbered phase folders. If there isn't, ask the user where the project lives
rather than guessing.

Read `knowledge-base/01-kickoff/README.md` for any project-specific notes.

## 2. Consume the spark

Read `knowledge-base/00-spark/spark.md`. Confirm it was actually promoted (its
gut-check should read *Promote*) — Kickoff is for ideas that earned it. If the spark
file doesn't exist yet but the user clearly wants to kick off an idea, run the session
from what they tell you and offer to backfill `spark.md` so the trail is complete.

## 3. Run the grill-me

Adopt the sparring-partner posture from `product-management:brainstorm`: push back,
ask for specifics, and don't accept vague answers. This is an interrogation that earns
a shared mental model, not an intake form. Work one thread at a time; when an answer is
mushy, name it and dig ("'everyone' isn't a user — who specifically, and what are they
doing the day before they'd reach for this?").

Cover these, adapting order to the conversation rather than marching through a list:

- The idea in one honest sentence.
- The problem or opportunity — and *who specifically* has it.
- The target user, concretely. Who are they, what's their context?
- The job-to-be-done, and what they do *today* instead.
- What success looks like — how would we know this worked?
- Why now? What's changed, or why hasn't it been done already?
- The core value — why would someone switch to this?
- The riskiest assumptions the whole idea rests on.
- Explicit non-goals *for the idea itself* (distinct from the parked architecture talk).

Push past the first answer on the threads that matter. A kickoff that surfaces two
uncomfortable assumptions is worth more than one that produces tidy answers.

## 4. Produce the artifacts

All paths below are relative to the project root (the folder containing
`knowledge-base/`). Start each file from
`knowledge-base/_templates/_artifact-template.md` and fill its frontmatter:

- `phase: 01 · Kickoff`
- `status: draft` while you're still writing (you'll move it to `in-review` in step 5)
- `mode:` leave the template default (`draft-then-approve`) unless the phase README says otherwise
- `consumes:` the upstream artifact as a project-root-relative path, e.g.
  `- knowledge-base/00-spark/spark.md`
- `produced:` today's date (get it with `date +%F`); leave `approved:` blank until the gate

**`problem-brief.md`** — the canonical, crisp statement: the problem/opportunity, the
target user, the job-to-be-done, what success means, and why now. No solution language.
This is the artifact every downstream phase traces back to.

**`shared-understanding.md`** — the alignment record from the session: the vision in a
paragraph, the target user, the core value, the key assumptions (flag the risky ones),
the scope boundaries, what was deliberately deferred (architecture and implementation
explicitly belong here), and the open questions.

Stay honest. If something is still fuzzy after the grill-me, put it under Open
questions rather than papering over it — an unresolved question recorded now is cheaper
than a wrong assumption discovered in Design.

## 5. Amend & hand off

Kickoff's only upstream is the spark, so contradictions are rare. But if the grill-me
reveals the spark's framing was off, don't quietly fix it — append a row to the
amendment log at the bottom of `spark.md` (date, "Kickoff", the assumption touched,
severity), and open an `amendment` issue if the project is on GitHub. Record and
continue; reconciliation is the gate's job, not yours.

When the drafts are ready for a human's eyes, set both artifacts to `status: in-review`
and hand them over for the grill. **Approval is a human act, never automatic** — even in
an unattended or `mode:auto` run, never set `status: approved` yourself. The artifacts
sit at `in-review` until a person is satisfied; only then does the human set
`status: approved` with an `approved:` date. That gap is the gate, and it must stay
human.

Once approved, tee up the next gate: if the project is on GitHub, open a `[Gate] Advance
from 01 Kickoff to 02 Research` gate-review issue; otherwise just tell the user Kickoff
is approved and Research is next. Do not start Research yourself — let them walk through
the gate.

## GitHub (optional, degrade gracefully)

If `gh` is authenticated and the repo exists, mirror the work as issues: track each
artifact with an `[Artifact]` issue under the `01 · Kickoff` milestone and close it on
approval. If `gh` isn't set up — which is normal early on — skip all of this silently
and work in the files alone. The knowledge base is the source of truth; GitHub is
bookkeeping on top of it.
