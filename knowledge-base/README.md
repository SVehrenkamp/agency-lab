# Knowledge Base

The structured, version-controlled store of every artifact this project produces.
Each phase has a fixed home and a known set of outputs. Markdown is for prose and
decisions; HTML is for things markdown can't render — sentiment dashboards, the
design system, clickable wireframes.

The phase you're in is simply *which artifact is currently being produced*.

| Folder | Phase | Key artifacts |
|--------|-------|---------------|
| `00-spark/` | Spark | `spark.md` (the one promoted spark — the idea backlog is lab-level) |
| `01-kickoff/` | Kickoff | `problem-brief.md`, `shared-understanding.md` |
| `02-research/` | Research | `competitive-landscape.md`, `pricing-teardown.md`, `sentiment-analysis.html` |
| `03-refinement/` | Refinement | `prd.md`, `product-edge.md` |
| `04-scoping/` | Scoping | `v1-scope.md`, `out-of-scope.md` |
| `05-ux/` | UX / Wireframing | `user-flows.md`, `edge-cases.md`, `wireframes.html` |
| `06-design/` | Design | `brand-brief.md`, `design-system.html`, `design.md`, `designs.html` |
| `07-dev-kickoff/` | Dev Kickoff | `architecture.md`, `system-design.md`, `adr/*.md` |
| `08-implementation/` | Implementation | `iteration-plans/`, `test-plans/` |
| `09-qa/` | Review / QA | `qa-reports.md`, `review-checklists/` |

## Artifacts carry an amendment log

Every markdown artifact ends with an append-only amendment section. When a later
phase surfaces a learning that contradicts this artifact, append one row and keep
moving — don't stop and rewrite. The contradiction now lives right next to what it
contradicts, so nothing silently drifts. Amendments are reconciled (absorbed or
escalated to a reopen) at the next **gate review**, not continuously.

Start every new artifact from [`_templates/_artifact-template.md`](_templates/_artifact-template.md).
