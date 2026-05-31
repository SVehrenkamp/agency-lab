---
name: agency-lab-ux
description: Run the UX / Wireframing phase of an Agency Lab project — an exhaustive pass over every user flow, state, and edge case for the V1 scope, captured as flow docs and low-fidelity wireframes. Use this whenever starting UX, mapping user flows, enumerating edge cases and empty/error states, wireframing screens, or when an approved V1 scope is ready to be turned into flows in an agency-lab project (look for a knowledge-base/ with 04-scoping and 05-ux folders). Thoroughness is the deliverable — every scope item must have a flow. Not for cutting what's in V1 (that's the Scoping phase) or visual design and brand (that's the Design phase).
---

# Agency Lab — UX / Wireframing Phase

UX is where V1 scope becomes a complete, walkable experience. The job is breadth and
rigor: every flow a user can take, every state a screen can be in, and every edge and
error case — mapped before a single pixel is styled. Skipping this is how products ship
with dead ends, missing empty states, and "we never thought about that" moments.

This phase runs **draft-then-approve** (auto-draft → review): you map it all out; the
human reviews for gaps and judgment calls.

The boundary that keeps UX from bleeding into Design: this phase is about *structure and
behavior* — what screens exist, what's on them, how a user moves between them, and what
happens in every state. It is **not** visual design (color, type, brand — that's Design)
and not architecture. Wireframes here are deliberately low-fidelity: boxes and labels,
not beauty.

## The phase contract

- **Consumes:** `knowledge-base/04-scoping/v1-scope.md`
- **Produces:** `knowledge-base/05-ux/user-flows.md`, `edge-cases.md`, `wireframes.html`
- **Engine:** `design:user-research` and `design:ux-copy`
- **Milestone:** `05 · UX / Wireframing`

All paths are relative to the project root (the folder containing `knowledge-base/`).

## 1. Preflight

Confirm you're in an Agency Lab project. Read `knowledge-base/05-ux/README.md` for
project-specific notes.

## 2. Consume the V1 scope

Read `v1-scope.md` (and `out-of-scope.md`, so you don't accidentally design deferred
features). Check the scope's frontmatter `status`: if it isn't `approved`, surface that
— building flows on unapproved scope means reworking them. Let the user decide explicitly.

Make a checklist of every in-scope capability. Completeness is judged against it: by the
end, **every scope item must have at least one flow.**

## 3. Run the UX pass

Be exhaustive — this is the one phase where thoroughness is the whole point.

- **Map every flow.** For each scope item: the entry points, the happy path step by step,
  and the alternate paths. Include first-run vs. returning, and any cross-flow transitions.
- **Enumerate every state.** For each screen: loading, empty, populated, partial, error,
  permission-denied, offline, and success. Empty and error states are where products
  usually fall down — give them real attention.
- **Hunt edge cases.** What happens at the limits — no data, too much data, slow network,
  interrupted actions, invalid input, concurrent edits, the unhappy human. Write them down
  even if the answer is "out of scope for V1" (note that explicitly).
- **Wire the copy lightly.** Use `design:ux-copy` for the words that carry a flow — button
  labels, empty-state prompts, error messages — since copy often reveals a missing state.

## 4. Produce the artifacts

Start the markdown files from `knowledge-base/_templates/_artifact-template.md`.
Frontmatter: `phase: 05 · UX / Wireframing`, `status: draft` while writing,
`mode: draft-then-approve`, `consumes: - knowledge-base/04-scoping/v1-scope.md`,
`produced:` today's date (`date +%F`), `approved:` blank.

- **`user-flows.md`** — every V1 flow, step by step, with entry points and branches, each
  flow labeled with the scope item it serves so coverage is auditable.
- **`edge-cases.md`** — the exhaustive list of edge cases and screen states, with the
  intended behavior for each (or an explicit "deferred — V2" note).
- **`wireframes.html`** — a self-contained, low-fidelity wireframe set covering the
  screens and key states: structural boxes, labels, and layout only, no visual styling.
  One HTML file; keep it simple enough that the *structure* is the message.

## 5. Amend & hand off

UX routinely exposes scope gaps — a flow that needs a capability scope didn't list, or a
"simple" feature that fans out into many states. When that happens, append a row to
`v1-scope.md`'s amendment log (don't rewrite it) and open an `amendment` issue if on
GitHub. A discovered state that genuinely expands V1 is exactly the kind of thing the gate
should weigh — record it and continue.

When drafted, set each artifact to `status: in-review` and hand off. **Approval is a human
act, never automatic** — never self-approve. Once approved (`status: approved` +
`approved:` date), tee up the next gate: if on GitHub, open a `[Gate] Advance from 05 UX
to 06 Design` gate-review issue; otherwise tell the user UX is approved and Design is
next. Do not start Design yourself.

## GitHub (optional, degrade gracefully)

If `gh` is authenticated, mirror the work as `[Artifact]` issues under the
`05 · UX / Wireframing` milestone and close them on approval. If not, skip silently — the
knowledge base is the source of truth.
