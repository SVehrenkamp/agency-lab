---
name: agency-lab-scoping
description: Run the Scoping phase of an Agency Lab project — cut a disciplined V1 from the refined PRD, deciding explicitly what the MVP will and will not build. Use this whenever starting scoping, defining MVP or V1 scope, deciding what's in or out for a first release, drawing the build/don't-build line, or when an approved PRD is ready to be narrowed in an agency-lab project (look for a knowledge-base/ with 03-refinement and 04-scoping folders). The explicit out-of-scope list matters as much as the in-scope one. Not for sharpening the product edge or writing the PRD (that's the Refinement phase) or mapping user flows (that's the UX phase).
---

# Agency Lab — Scoping Phase

Scoping turns the full-product PRD into a V1 you can actually build and ship. Its
discipline is subtraction: deciding what the MVP includes, and — just as deliberately —
what it does not. The explicit out-of-scope list is the antidote to bolted-on features;
a capability deferred *on purpose, with a reason* is a decision, while one left
unmentioned is a future surprise.

This phase runs **draft-then-approve**: you draft the cut; the human approves the line.

The cut has a north star: **V1 should deliver the product edge**, not the whole vision.
Anything that doesn't prove or serve the wedge is a candidate to defer. The boundary:
Scoping decides *what* ships, not *how* it looks or flows (UX) or how it's built (Dev
Kickoff).

## The phase contract

- **Consumes:** `knowledge-base/03-refinement/prd.md` and `product-edge.md`
- **Produces:** `knowledge-base/04-scoping/v1-scope.md`, `out-of-scope.md`
- **Engine (optional):** `product-management:write-spec` and `product-management:roadmap-update` — used if installed; otherwise apply the same methodology from this skill's steps
- **Milestone:** `04 · Scoping`

All paths are relative to the project root (the folder containing `knowledge-base/`).

## 1. Preflight

Confirm you're in an Agency Lab project. Read `knowledge-base/04-scoping/README.md` for
project-specific notes.

## 2. Consume the PRD and edge

Read `prd.md` and `product-edge.md`. Check the PRD's frontmatter `status`: if it isn't
`approved`, surface that before cutting scope against it — scoping an unapproved PRD risks
redoing the cut. Let the user decide explicitly.

Hold the product edge in view the whole time: it's the test every scope decision runs
against.

## 3. Run the scoping pass

Work the PRD's capabilities into three buckets, and make the reasoning explicit:

- **In V1** — the smallest set that genuinely delivers the edge and lets a real user get
  the core value end to end. Resist "while we're at it" additions.
- **Out of V1 (deferred)** — valuable but not needed to prove the wedge. Each gets a
  *why* (why it can wait) and a rough *when* (next / later).
- **Out entirely** — things the PRD raised that, on reflection, aren't the right bet.

Pressure-test the in-scope set two ways: does every item trace to the edge or to making
the core flow usable? And if you removed it, would V1 still prove the thesis? If removing
it changes nothing, it's probably not V1.

## 4. Produce the artifacts

Start each from `knowledge-base/_templates/_artifact-template.md`. Frontmatter:
`phase: 04 · Scoping`, `status: draft` while writing, `mode: draft-then-approve`,
`consumes: - knowledge-base/03-refinement/prd.md`, `produced:` today's date (`date +%F`),
`approved:` blank.

- **`v1-scope.md`** — the V1 build list: each included capability, the user value it
  delivers, its tie to the product edge, and a high-level acceptance note for what "in V1"
  means for it. This is what UX, Design, and Implementation will build against.
- **`out-of-scope.md`** — the explicit deferral list: what's *not* in V1, the reason it can
  wait, and roughly when it comes back (next / later / never). Deferral recorded here is a
  decision the team can point to, not an omission someone has to rediscover.

## 5. Amend & hand off

If scoping exposes that the PRD over- or under-reached — a "core" capability that turns
out inessential, or an edge that needs something the PRD didn't call out — append a row to
`prd.md`'s amendment log rather than editing it, and open an `amendment` issue if on
GitHub. Record and continue.

When drafted, set each artifact to `status: in-review` and hand off. **Approval is a
human act, never automatic** — never self-approve. Once approved (`status: approved` +
`approved:` date), tee up the next gate: if on GitHub, open a `[Gate] Advance from 04
Scoping to 05 UX` gate-review issue; otherwise tell the user Scoping is approved and UX is
next. Do not start UX yourself.

## GitHub (optional, degrade gracefully)

If `gh` is authenticated, mirror the work as `[Artifact]` issues under the `04 · Scoping`
milestone and close them on approval. If not, skip silently — the knowledge base is the
source of truth.
