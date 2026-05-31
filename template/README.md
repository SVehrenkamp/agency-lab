# Agency Lab — Project Template

A repeatable starting point for taking a new product or business idea from spark to
shipped, using the phase-gated workflow defined in the
[Agency Lab Framework](../FRAMEWORK.md).

Every project created from this template is structurally identical: the same
knowledge-base folders, the same phase milestones, the same labels, and the same
issue types. That sameness is what makes the process repeatable.

## What's inside

```
template/
├── README.md                     ← you are here
├── knowledge-base/               ← the structured artifact store (the repo IS the docs)
│   ├── 00-spark/ … 09-qa/        ← one folder per phase, each with a README
│   └── _templates/               ← _artifact-template.md (carries the amendment log)
├── .github/
│   └── ISSUE_TEMPLATE/           ← Spark, Artifact, Amendment, Gate Review issue forms
└── scripts/
    └── setup.sh                  ← creates milestones + labels (run once per project)
```

## Spin up a new project

1. **Create a repo from the template.** On GitHub, mark this repo as a *template*
   (Settings → Template repository), then click **Use this template → Create a new
   repository** for each new project. Or, with the CLI:
   ```bash
   gh repo create my-new-idea --template <owner>/agency-lab-template --private --clone
   cd my-new-idea
   ```

2. **Bootstrap milestones and labels.** GitHub templates copy files but not
   milestones, labels, or issues — so run the setup script once:
   ```bash
   ./scripts/setup.sh
   ```
   This creates the 10 phase milestones (`00 · Spark` … `09 · Review / QA`) and the
   full label set.

3. **Start at Spark.** Open a **Spark** issue for the idea, give it a paragraph and
   a gut-check. If you promote it, move it to the `01 · Kickoff` milestone — that's
   the graduation gate.

## How the pieces map to the framework

| Framework concept | Lives here as |
|-------------------|---------------|
| Phase | A GitHub **milestone** + a `knowledge-base/NN-*/` folder |
| Artifact | A file in the phase folder, tracked by an **Artifact** issue |
| Amendment log | The table at the bottom of each artifact + an **Amendment** issue |
| Gate | A **Gate Review** issue at the phase boundary (always `mode:collab`) |
| Working mode | `mode:auto` / `mode:collab` labels (default: draft-then-approve) |

## Labels created by setup.sh

`spark` · `artifact` · `amendment` · `severity:minor` · `severity:major` ·
`mode:auto` · `mode:collab` · `gate` · `blocked`

## Conventions

- **Don't rewrite upstream artifacts mid-phase.** Record contradictions in the
  artifact's amendment log (and an Amendment issue), then reconcile at the next gate.
- **Closing a Gate Review issue is the act of advancing a phase.** It's always a
  human decision.
- **An Artifact issue closes when its document is approved**, not when a first draft
  exists.

> See [`../FRAMEWORK.md`](../FRAMEWORK.md) for the full rationale, phase-by-phase
> artifact contracts, and the open decision on board mechanics (GitHub Projects
> custom fields vs. labels). Design source is settled: self-contained HTML in the
> repo, no Figma.
