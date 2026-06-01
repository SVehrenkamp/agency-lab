---
name: agency-lab-dev-kickoff
description: Run the Dev Kickoff phase of an Agency Lab project — the first phase where architecture enters. Translate the product (V1 scope, UX flows, design system) into a technical architecture, a system design, and architecture decision records (ADRs). Use this whenever starting dev kickoff, designing the architecture or system design, choosing a stack, data model, or service boundaries, or writing ADRs in an agency-lab project (look for a knowledge-base/ with 06-design and 07-dev-kickoff folders). This is where architecture — deliberately parked in every prior phase — is finally decided. Not for choosing product scope (that's the Scoping phase) or writing feature code (that's the Implementation phase).
---

# Agency Lab — Dev Kickoff Phase

Dev Kickoff is the moment architecture is finally allowed in. Every phase before this
deliberately parked it, so that the technical plan answers to a settled product rather
than the other way around. The job: turn the approved scope, flows, and design into a
technical architecture, a system design, and a clear record of the decisions behind them.

This phase runs **draft-then-approve** (auto-draft → review): you draft the architecture;
the human reviews the trade-offs before they harden.

The boundary that keeps it honest: Dev Kickoff decides **how** to build, not **what** to
build (scope is locked) and not the line-by-line implementation of each feature (that's
Implementation's iterations). It sets the structure everything downstream is built within.

## The phase contract

- **Consumes:** `knowledge-base/04-scoping/v1-scope.md`, `knowledge-base/05-ux/` (flows + edge cases), and `knowledge-base/06-design/design.md`
- **Produces:** `knowledge-base/07-dev-kickoff/architecture.md`, `system-design.md`, `adr/*.md`
- **Engine (optional):** `engineering:architecture` (ADRs) and `engineering:system-design` — used if installed; otherwise apply the same methodology from this skill's steps
- **Milestone:** `07 · Dev Kickoff`

All paths are relative to the project root (the folder containing `knowledge-base/`).

## 1. Preflight

Confirm you're in an Agency Lab project. Read `knowledge-base/07-dev-kickoff/README.md`
for project-specific notes.

## 2. Consume the product

Read `v1-scope.md` (what must be built), the UX artifacts (the behavior and states the
system must support), and `design.md` (the surface it must render). Check their
frontmatter `status`: if the scope or UX aren't `approved`, surface that — architecting
against unsettled scope means rework. Let the user decide explicitly.

Translate scope and flows into technical requirements: the data the system holds, the
operations it performs, the integrations it needs, and the non-functional constraints
(scale, latency, offline, privacy) the product implies.

## 3. Design the architecture

Use `engineering:system-design` for the structure and `engineering:architecture` for the
decisions. Work toward:

- **System design** — the components and their responsibilities, the data model, the key
  interfaces/APIs, and how a representative flow moves through the system end to end. Tie
  it back to the UX flows so it's clear every flow is actually supported.
- **The stack and the big choices** — framework, storage, hosting, auth, and the handful
  of decisions that are expensive to reverse. Steelman the alternatives.
- **Decision records** — capture each consequential choice as an ADR (context, options,
  decision, consequences). ADRs are the phase's memory: they let a future reader
  understand *why*, not just *what*.

Favor the simplest architecture that serves V1 and doesn't paint the deferred roadmap
into a corner. This is not the place to build for a scale the product hasn't earned.

## 4. Produce the artifacts

Start the markdown files from `knowledge-base/_templates/_artifact-template.md` (ADRs may
use the `engineering:architecture` ADR format inside `adr/`). Frontmatter:
`phase: 07 · Dev Kickoff`, `status: draft` while working, `mode: draft-then-approve`,
`consumes:` the scope/UX/design paths, `produced:` today's date (`date +%F`), `approved:` blank.

- **`architecture.md`** — the architecture overview: the stack, the major components, the
  cross-cutting concerns (auth, data, error handling, observability), and the rationale,
  linking out to the ADRs for the deep decisions.
- **`system-design.md`** — the concrete design: data model, interfaces, and at least one
  representative flow traced through the system.
- **`adr/NNNN-title.md`** — one file per consequential decision.

## 5. Amend & hand off

Dev Kickoff often discovers that something "small" in scope is architecturally large, or
that a flow needs a capability nobody specified. When that happens, append a row to the
relevant upstream artifact's amendment log (`v1-scope.md` or a `05-ux/` doc) rather than
rewriting it, and open an `amendment` issue if on GitHub. A feature that's technically
infeasible as scoped is exactly what the gate should weigh.

When drafted, set each artifact to `status: in-review` and hand off. **Approval is a human
act, never automatic** — never self-approve. Once approved (`status: approved` +
`approved:` date), tee up the next gate: if on GitHub, open a `[Gate] Advance from 07 Dev
Kickoff to 08 Implementation` gate-review issue; otherwise tell the user Dev Kickoff is
approved and Implementation is next. Do not start Implementation yourself.

## GitHub (optional, degrade gracefully)

If `gh` is authenticated, mirror the work as `[Artifact]` issues under the `07 · Dev
Kickoff` milestone and close them on approval. If not, skip silently — the knowledge base
is the source of truth.
