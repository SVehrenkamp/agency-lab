# The Agency Lab Framework

*A phase-gated workflow for taking new product and business ideas from spark to shipped — with the rigor of waterfall and the momentum of experimentation.*

Status: Founding draft · Last updated: 2026-05-31

---

## 1. Why this exists

The default way of building — start from a high-level vision and execute immediately — is excellent for experimentation and terrible for finishing. Features get bolted on after the fact. Task tracking scatters. Documentation is sporadic. UX and design arrive as afterthoughts. The result is a product that's fast to prototype and painful to polish.

The Agency Lab Framework fixes this by spending real time in each phase, nailing down the details before moving on. It borrows waterfall's discipline of sequenced phases and explicit hand-offs, but rejects waterfall's fatal flaw — the assumption that you never learn anything that should change an earlier decision. Here, learnings flow backward through a lightweight mechanism that records and reconciles them without grinding the project to a halt.

Two design commitments shape everything below:

**Protect experimentation speed.** Most ideas should die cheaply, before any heavyweight process touches them. Rigor is something an idea *earns*, not something every idea is subjected to.

**Favor momentum over re-litigation.** When a later phase contradicts an earlier one, the default is to record the contradiction and keep moving, then reckon with it at the next gate — not to stop and rewrite. We are more afraid of stalling in document revision than of drifting from the original truth, because the amendment log makes drift visible anyway.

---

## 2. Core concepts

**Artifact contracts.** Each phase is a self-contained module defined by the artifacts it *consumes* and the artifacts it *produces* — not by its position in a sequence. Kickoff produces a problem brief; research consumes that and produces a competitive landscape; refinement consumes both and produces a PRD. Because phases are defined by their inputs and outputs rather than their order, the same framework serves both new projects (run every module in sequence) and existing ones (enter at the first phase whose artifacts don't yet exist).

**The knowledge base.** A structured store of every artifact, version-controlled inside the project repo. It is not a freeform docs folder — each phase has a known home and known outputs. The knowledge base *is* the repo, so documentation lives next to the code it describes.

**The amendment log.** Cheap backtracking. Every artifact carries a dated, append-only amendment section. When a later phase surfaces a learning that dents an earlier assumption, you append one entry — what you learned, which assumption it touches, and a severity flag — and keep working. Nothing silently drifts, because the contradiction is recorded right next to what it contradicts.

**Gates.** The reckoning happens at phase boundaries, not continuously. A gate review reads the amendments that piled up against upstream artifacts and dispositions each one: *absorb* (fold it in, move on) or *reopen* (big enough to formally revisit). Closing a gate is the act of advancing to the next phase — and it is always a human decision.

**Modes.** The default working mode inside every phase is **draft-then-approve**: a machine does the heavy lifting, a human applies judgment. Two labels mark the exceptions — `mode:auto` for work that can run unattended, and `mode:collab` for work that is irreducibly human. Gates are always `mode:collab`.

---

## 3. The pipeline

```
  Spark ──(graduation gate)──▶ Kickoff ─▶ Research ─▶ Refinement ─▶ Scoping
                                                                       │
   QA ◀─ Implementation ◀─ Dev Kickoff ◀─ Design ◀─ UX/Wireframing ◀──┘

  ▲ amendments flow backward at every step; gates reconcile them forward
```

**Spark** sits in front of everything as a cheap filter. An idea gets a paragraph and a gut-check. A hundred sparks can sit in a backlog costing almost nothing; only ideas you consciously promote cross the **graduation gate** into the heavyweight machinery. This is the single most important feature of the framework — it is what keeps experimentation fast.

### Phase reference

| # | Phase | Consumes | Produces | Primary mode |
|---|-------|----------|----------|--------------|
| 0 | **Spark** | An idea | `spark.md` (one paragraph + gut-check) | collab |
| — | **Graduation gate** | A spark | Decision to promote or shelve | collab |
| 1 | **Kickoff** | Promoted spark | `problem-brief.md`, `shared-understanding.md` | auto-draft → grill-me |
| 2 | **Research** | Problem brief | `competitive-landscape.md`, `pricing-teardown.md`, `sentiment-analysis.html` | auto |
| 3 | **Refinement** | Brief + research | `prd.md`, `product-edge.md` | auto-draft → grill-me |
| 4 | **Scoping** | PRD | `v1-scope.md`, `out-of-scope.md` | auto-draft |
| 5 | **UX / Wireframing** | V1 scope | `user-flows.md`, `edge-cases.md`, `wireframes.html` | auto-draft → review |
| 6 | **Design** | Scope + PRD + UX | `brand-brief.md`, `design-system.html`, `design.md`, `designs.html` | collab (taste) + auto-draft |
| 7 | **Dev Kickoff** | All of the above | `architecture.md`, `system-design.md`, `adr/*.md` | auto-draft → review |
| 8 | **Implementation** | Architecture | iteration plans, test plans, code | auto-draft + collab |
| 9 | **Review / QA** | Each delivered feature | `qa-reports.md`, review checklists | collab (sign-off) |

### Phase notes

**Kickoff** is the grill-me session — a thorough interrogation to reach shared understanding of what the idea *is*. It deliberately does not touch architecture or implementation.

**Research** identifies and groups every competitor and adjacent product in the space, analyzing competitive edges, pricing structures, and review sentiment for what users love and hate. This is the most automatable phase.

**Refinement** repeats the kickoff exercise, but now armed with the research — applying everything learned to sharpen the product edge and define the real opportunity. This is where research either confirms or quietly reshapes the original idea.

**Scoping** turns the refined PRD into an explicit V1: what we will build, and just as importantly, what we will *not* build for the MVP.

**UX / Wireframing** is a comprehensive, exhaustive pass over every user flow and edge case. Thoroughness here is the point.

**Design** runs a brand/style interview first (irreducibly human — this is your taste), then produces a design system — captured both as a rendered `design-system.html` and as a written `design.md` style guide that downstream phases cite — then the comprehensive designs that account for every UX flow. Designs are built directly in the repo as self-contained HTML with Claude — no Figma (see §8).

**Dev Kickoff** is the first time architecture and system design enter the picture, drawing on every prior artifact.

**Implementation** proceeds in phased, testable iterations.

**Review / QA** closes out each feature delivery with thorough testing and review against requirements before it's considered done.

---

## 4. Knowledge base structure

Each phase has a fixed home. Markdown for prose and decisions; HTML for things markdown can't render — sentiment dashboards, the design system, clickable wireframes.

```
/knowledge-base
  /00-spark          → spark.md
  /01-kickoff        → problem-brief.md, shared-understanding.md
  /02-research       → competitive-landscape.md, pricing-teardown.md, sentiment-analysis.html
  /03-refinement     → prd.md, product-edge.md
  /04-scoping        → v1-scope.md, out-of-scope.md
  /05-ux             → user-flows.md, edge-cases.md, wireframes.html
  /06-design         → brand-brief.md, design-system.html, design.md, designs.html
  /07-dev-kickoff    → architecture.md, system-design.md, adr/*.md
  /08-implementation → iteration-plans/, test-plans/
  /09-qa             → qa-reports.md, review-checklists/
```

Every markdown artifact ends with a standard amendment section:

```markdown
## Amendment Log
| Date | Learned in phase | Assumption touched | Severity | Disposition |
|------|------------------|--------------------|----------|-------------|
| 2026-06-03 | Research | "No competitor bundles X" — false | major | reopen |
```

---

## 5. GitHub mechanics

GitHub is the state machine. The phase you're in is simply which artifact is currently being produced.

**Milestones = phases.** The open milestone is the active phase. Nine milestones (plus the spark backlog) mirror the pipeline.

**Issues = tasks and artifacts.** An artifact issue closes when its document is approved.

**Amendments = issues labeled `amendment`,** linked to the upstream milestone they affect. They remain open and visible until a gate review dispositions them.

**Gates = a checklist issue at each milestone boundary.** Its checklist: review open amendments, confirm upstream artifacts are current, approve the advance. Closing the gate issue *is* moving to the next phase.

**Labels:**

| Label | Meaning |
|-------|---------|
| `amendment` | A learning that contradicts an upstream artifact |
| `severity:minor` / `severity:major` | How much an amendment matters |
| `mode:auto` | Safe to run unattended |
| `mode:collab` | Requires the human; cannot be drafted away |
| `gate` | A phase-boundary approval issue |

A new project is a click: spin up the template repo, and the milestones, labels, knowledge-base skeleton, and artifact issue templates already exist.

---

## 6. Automation model

The default mode is **draft-then-approve**. Inside almost every phase, the right pattern is *Claude drafts, you react* — the grill-me, the competitive teardown, the first-pass PRD, the wireframe inventory all want a machine to do the lifting and a human to apply judgment.

Two overrides handle the edges:

- `mode:auto` — let it run unattended. Scraping competitor pricing, generating a sentiment dashboard, scaffolding a repo.
- `mode:collab` — this is yours. Brand and design taste, the final QA sign-off, anything where your gut *is* the product.

Gates are always `mode:collab` by definition. That single rule guarantees a human is in the loop at every phase transition without having to babysit the work inside each phase.

---

## 7. What to build

The framework reduces to two buildable pieces.

**Piece one: the template repo.** A GitHub template containing the knowledge-base folder skeleton, the nine milestones pre-created, the full label set, and an issue template per artifact. This is the "lab" — it makes every project structurally identical and repeatable, and turns project setup into one click.

**Piece two: the phase skills.** One skill per phase that knows its artifact contract — reads the upstream documents, runs the work, and writes its outputs into the correct knowledge-base folder. Most of these map onto skills already installed in this environment:

| Phase | Backing skill(s) |
|-------|------------------|
| Kickoff | `product-management:brainstorm` (grill-me) |
| Research | `product-management:competitive-brief`, `marketing:competitive-brief` |
| Refinement | `product-management:write-spec` |
| Scoping | `product-management:write-spec`, `product-management:roadmap-update` |
| UX | `design:user-research`, `design:ux-copy` |
| Design | `design:design-system`, `design:design-critique` |
| Dev Kickoff | `engineering:architecture`, `engineering:system-design` |
| Implementation | `product-management:sprint-planning`, `engineering:code-review` |
| QA | `engineering:testing-strategy` |

The framework is mostly *sequencing and wiring* skills that already exist, not building them from scratch.

---

## 8. Decisions

One still parked, one resolved.

**Board mechanics: GitHub Projects custom fields vs. plain labels (PARKED).** Projects (v2) lets phase, mode, and severity be real fields with board and table views across issues — cleaner than labels for filtering and reporting. Leaning toward Projects, but it's a "decide when you build the template" call.

**Design source of truth — RESOLVED (2026-05-31): no Figma.** Designs are built directly in the repo as self-contained HTML using Claude's design capability. `design-system.html` is the visual render and `design.md` is the canonical written reference/style guide (tokens, components, brand, accessibility) that downstream phases cite; `designs.html` composes the system into finished screens for every UX flow. The knowledge base stays the single source of truth — diffable and version-controlled alongside everything it's built from.

---

## 9. Glossary

- **Artifact** — a versioned document produced by a phase and stored in the knowledge base.
- **Artifact contract** — the set of inputs a phase consumes and outputs it produces.
- **Spark** — a one-paragraph idea awaiting the graduation gate.
- **Graduation gate** — the promotion decision that lets an idea enter the heavyweight pipeline.
- **Amendment** — a recorded learning that contradicts an upstream artifact.
- **Gate** — a human approval at a phase boundary that dispositions amendments and advances the project.
- **Mode** — whether a unit of work runs automated (`mode:auto`), collaboratively (`mode:collab`), or in the default draft-then-approve rhythm.
