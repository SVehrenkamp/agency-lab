---
name: agency-lab-research
description: Run the Research phase of an Agency Lab project — identify and group every competitor, adjacent product, and status-quo substitute in the space, analyze their competitive edges, pricing structures, and review sentiment (what users love and hate), and produce a competitive landscape, a pricing teardown, and a sentiment dashboard. Use this whenever starting research, building a competitive landscape or pricing teardown, analyzing reviews or user sentiment, or when an approved problem brief is ready to be pressure-tested against the market in an agency-lab project (look for a knowledge-base/ with 01-kickoff and 02-research folders). This is the phase where market reality most often contradicts kickoff assumptions — capture those as amendments. Not for refining the idea against the findings (that's the Refinement phase) or deciding V1 scope (that's Scoping).
---

# Agency Lab — Research Phase

Research takes the problem brief and pressure-tests it against the real market. Its job
is to map who else is solving this problem (or the job around it), how they win, what
they charge, and what their users actually love and hate — so the next phase can sharpen
a real edge instead of guessing.

This phase runs **`mode:auto`**: the work — searching, gathering, grouping, analyzing —
can run largely unattended. But the **gate to Refinement is still human**. Draft
everything autonomously, then hand off for review; never self-approve.

Two things make Research distinctive. First, it is evidence-based — every claim about a
competitor, a price, or a sentiment theme should trace to a source, so cite as you go.
Second, it is the phase where the market most often contradicts what Kickoff assumed —
treat that as the point of the exercise, not a problem (see step 5).

## The phase contract

- **Consumes:** `knowledge-base/01-kickoff/problem-brief.md` (and `shared-understanding.md` for context)
- **Produces:** `knowledge-base/02-research/competitive-landscape.md`, `pricing-teardown.md`, `sentiment-analysis.html`
- **Engine (optional):** `product-management:competitive-brief` (and `marketing:competitive-brief` for go-to-market angle) — used if installed; otherwise apply the same methodology from this skill's steps
- **Milestone:** `02 · Research`

All paths are relative to the project root (the folder containing `knowledge-base/`).

## 1. Preflight

Confirm you're in an Agency Lab project (a `knowledge-base/` with numbered phase
folders). Read `knowledge-base/02-research/README.md` for project-specific notes.

## 2. Consume the problem brief

Read `knowledge-base/01-kickoff/problem-brief.md` and `shared-understanding.md`.

Check the problem brief's frontmatter `status`. If it is not `approved`, stop and surface
that — Research builds on the brief, and building on an unapproved brief means redoing
this work if the brief changes at its gate. If the user wants to proceed anyway, let
them make that call explicitly rather than assuming it.

Pull the search space from the brief: the problem, the job-to-be-done, the target user,
and the *current alternatives* named in the brief. Those alternatives are your first
competitors.

## 3. Run the research

Use the `product-management:competitive-brief` methodology as the engine. Search the web
as you go (`WebSearch` / `web_fetch`); if SimilarWeb, Ahrefs, or similar connectors are
available, use them for traffic, share, and SEO signal. Work toward four things:

- **Identify and group.** Find competitors and cluster them — *direct* (same job, same
  user), *adjacent* (overlapping job or a neighboring category), and *status-quo /
  DIY substitutes* (what people do today instead, including "nothing" and spreadsheets).
  Grouping matters more than a flat list: it reveals where the space is crowded and where
  it's open.
- **Competitive edge.** For each notable player: what they're genuinely good at, who they
  serve, and how they position. Be specific and fair — steelman them.
- **Pricing structure.** Model, tiers, anchors, what's gated, free/trial mechanics, and
  what the pricing signals about their target segment.
- **Review sentiment.** What users praise and what they complain about — from app stores,
  G2/Capterra/TrustRadius, Reddit, YouTube, support forums. Cluster into recurring
  themes (loved / disliked) rather than cherry-picked quotes, and note which competitor
  each theme attaches to.

Cite sources inline as you collect — a finding without a link is hard to trust later.

## 4. Produce the artifacts

Start each markdown file from `knowledge-base/_templates/_artifact-template.md`. Fill the
frontmatter: `phase: 02 · Research`, `status: draft` while writing, `mode: auto`,
`consumes: - knowledge-base/01-kickoff/problem-brief.md`, `produced:` today's date
(`date +%F`), `approved:` blank.

- **`competitive-landscape.md`** — the grouped competitor map: the clusters, each notable
  player's edge / segment / positioning, and a short read on where the space is crowded
  versus open. Sources linked.
- **`pricing-teardown.md`** — pricing across the set: models and tiers side by side, the
  common anchors, and what the patterns imply about willingness to pay and segment.
- **`sentiment-analysis.html`** — a self-contained HTML dashboard of the review themes:
  what users love and hate, organized by theme and by competitor, so the patterns are
  visible at a glance. Keep it a single file; if you want charts, a single CDN library
  (e.g. Chart.js) is fine, but inline the data. This is HTML rather than markdown because
  the value is in seeing the clusters, not reading a list.

## 5. Amend & hand off

This is the phase that most often dents Kickoff. When a finding contradicts the problem
brief — the wedge is already owned, a "competitor doesn't do X" assumption is false, the
target user is served better than the brief assumed — **do not edit the problem brief.**
Append a row to the amendment log at the bottom of `problem-brief.md` (date, "Research",
the assumption touched, severity), and open an `amendment` issue if the project is on
GitHub. Record it and keep researching; the Research → Refinement gate is where someone
decides whether it's an absorb or a reopen. Capturing these honestly is the whole reason
this phase comes before Refinement.

When the artifacts are drafted, set each to `status: in-review` and hand off for review.
**Approval is a human act, never automatic** — even on an unattended run, never set
`status: approved` yourself. Once a person approves (sets `status: approved` with an
`approved:` date), tee up the next gate: if the project is on GitHub, open a `[Gate]
Advance from 02 Research to 03 Refinement` gate-review issue; otherwise tell the user
Research is approved and Refinement is next. Do not start Refinement yourself.

## GitHub (optional, degrade gracefully)

If `gh` is authenticated and the repo exists, mirror the work as `[Artifact]` issues
under the `02 · Research` milestone and close them on approval. If `gh` isn't set up,
skip this silently and work in the files alone — the knowledge base is the source of
truth.
