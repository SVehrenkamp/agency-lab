---
name: agency-lab-design
description: Run the Design phase of an Agency Lab project — align on brand and visual style through a short interview, then produce a design system and comprehensive, Claude-built HTML designs that cover every UX flow. Use this whenever starting design, running a brand or visual-style interview, building a design system or component library, or creating screen designs and mockups in an agency-lab project (look for a knowledge-base/ with 05-ux and 06-design folders). Designs are self-contained HTML built in the repo with Claude — there is no Figma step. Not for mapping user flows and edge cases (that's the UX phase) or system architecture (that's Dev Kickoff).
---

# Agency Lab — Design Phase

Design makes the V1 experience look and feel like a real product. It takes the
structural UX work — the flows, states, and wireframes — and gives it a visual language
and finished screens. It moves in three deliberate steps: a **brand/style interview**
(your taste), a **design system** (the canonical visual language), and the
**comprehensive designs** that dress every UX flow in that language.

Designs are built directly in the repo as self-contained HTML using Claude's design
capability. There is **no Figma** — `design-system.html` is the source of truth for the
visual language, and `designs.html` composes it into screens. Keeping them in the
knowledge base means the design is diffable, version-controlled, and lives next to
everything it's built from.

The boundary: Design consumes the UX structure, it doesn't redo it. If a flow or state is
missing, that's an amendment to UX — not something to silently invent here. And Design is
visual, not architectural; how it's built is Dev Kickoff's job.

## The phase contract

- **Consumes:** all of `knowledge-base/05-ux/`, plus `knowledge-base/04-scoping/v1-scope.md` and `knowledge-base/03-refinement/product-edge.md`
- **Produces:** `knowledge-base/06-design/brand-brief.md`, `design-system.html`, `design.md`, `designs.html`
- **Engine (optional):** `design:design-system` (build) and `design:design-critique` (self-review) — used if installed; otherwise apply the same methodology from this skill's steps
- **Milestone:** `06 · Design`
- **Mode:** mixed — the brand interview is `mode:collab` (taste); the system and designs are draft-then-approve.

All paths are relative to the project root (the folder containing `knowledge-base/`).

## 1. Preflight

Confirm you're in an Agency Lab project. Read `knowledge-base/06-design/README.md` for
project-specific notes.

## 2. Consume UX, scope, and edge

Read `05-ux/user-flows.md`, `edge-cases.md`, and `wireframes.html`; `04-scoping/v1-scope.md`;
and `03-refinement/product-edge.md` (the brand should express the edge). Check the UX
artifacts' `status`: if not `approved`, surface that before designing against them.

Build a checklist of every flow in `user-flows.md` and every notable state in
`edge-cases.md` — design completeness is judged against it.

## 3a. Brand / style interview — `mode:collab`, taste is human

This step cannot be automated, because it's a judgment about who the product should *feel*
like. Interview the human: brand adjectives (three to five), references and anti-references
they admire or dislike, tone, the feeling the target user should have, color and type
leanings, density, and any accessibility or platform constraints.

**Do not invent taste.** If you're running unattended with no one to interview, do not
assert a single direction — instead draft two or three genuinely distinct brand directions
as *options* and stop for a human to choose. Capturing the wrong taste confidently is worse
than pausing.

Write the agreed (or proposed) direction to `brand-brief.md`.

## 3b. Design system → `design-system.html` + `design.md`

Using the `design:design-system` methodology, turn the brand brief into a self-contained
HTML design system: color tokens, type scale, spacing, and the component set the UX
implies (buttons, inputs, cards, nav, modals, etc.) with their states. Bake in
accessibility — check color contrast as you set tokens. This file is the canonical visual
*render*; everything in `designs.html` is built from it.

Then write the same system down as `design.md` — the canonical *written* design reference
and style guide. HTML is great for seeing the system but poor for citing it, and Dev
Kickoff and Implementation will need to reference exact values in plain text. `design.md`
captures, in readable, greppable markdown:

- **Brand** — the agreed adjectives, voice and tone, and the do's and don'ts (distilled from `brand-brief.md`).
- **Color** — the palette with names and hex values, semantic roles (primary, surface, danger…), and contrast notes.
- **Typography** — the type scale (sizes, weights, line-heights) and where each level is used.
- **Spacing & layout** — the spacing scale, grid, radii, elevation.
- **Components** — an inventory of each component, its variants and states, and usage rules (when to use, when not to).
- **Accessibility** — the standards the system holds itself to (contrast targets, focus, target sizes).

Keep `design.md` and `design-system.html` in sync — they are two views of one system, the
written record and the visual render. `design.md` is the version downstream phases cite.

## 3c. Comprehensive designs → `designs.html`

Compose the design system into finished screen designs covering **every flow** in
`user-flows.md` and the key states from `edge-cases.md` — including the empty and error
states, not just the happy path. Reuse the system's tokens and components so the result is
consistent. Then run `design:design-critique` on your own output and fix what it surfaces.
Coverage is the bar: a flow without a design is an incomplete phase.

## 4. Produce the artifacts

Start the markdown artifacts (`brand-brief.md` and `design.md`) from
`knowledge-base/_templates/_artifact-template.md` so each carries an amendment log.
Frontmatter across all four: `phase: 06 · Design`, `status: draft` while working,
`mode: collab` for the brand brief and `draft-then-approve` for `design.md` and the two
HTML files, `consumes:` the UX/scope/edge paths, `produced:` today's date (`date +%F`),
`approved:` blank.

The two HTML files are self-contained single files; a single CDN library is acceptable but
inline your own styles and data.

## 5. Amend & hand off

Design is where missing UX surfaces — a flow with no defined empty state, a screen the
wireframes skipped. When that happens, append a row to the relevant `05-ux/` artifact's
amendment log (don't rewrite it) and open an `amendment` issue if on GitHub. Record and
continue.

When drafted, set each artifact to `status: in-review` and hand off. **Approval is a human
act, never automatic** — and for the brand brief especially, never self-approve a taste
call. Once a person approves (`status: approved` + `approved:` date), tee up the next gate:
if on GitHub, open a `[Gate] Advance from 06 Design to 07 Dev Kickoff` gate-review issue;
otherwise tell the user Design is approved and Dev Kickoff is next. Do not start Dev Kickoff
yourself.

## GitHub (optional, degrade gracefully)

If `gh` is authenticated, mirror the work as `[Artifact]` issues under the `06 · Design`
milestone and close them on approval. If not, skip silently — the knowledge base is the
source of truth.
