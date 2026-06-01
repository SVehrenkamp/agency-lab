# Agency Lab (plugin)

Installs the nine **Agency Lab** phase skills so the spark-to-ship workflow is available in
Cowork (and Claude Code, across projects). It's the packaged form of the skills that live in
[`.claude/skills/`](https://github.com/SVehrenkamp/agency-lab) in the Agency Lab repo.

## What it adds

Nine skills, one per phase of the framework:

`kickoff` · `research` · `refinement` · `scoping` · `ux` · `design` · `dev-kickoff` ·
`implementation` · `qa`

Each reads the upstream artifacts, runs its phase, and writes outputs into the project's
`knowledge-base/` folder. To use them, work inside an Agency Lab project (create one from the
[template](https://github.com/SVehrenkamp/agency-lab) — `gh repo create my-idea --template
SVehrenkamp/agency-lab --clone`), then ask, e.g. "run the Kickoff phase."

## Companion plugins (optional)

The phase skills are self-contained, but each can lean on an optional "engine" skill for extra
depth when its plugin is installed. This plugin declares them as dependencies:

- **product-management** — brainstorm, competitive-brief, write-spec, roadmap-update, sprint-planning
- **design** — user-research, ux-copy, design-system, design-critique
- **engineering** — architecture, system-design, code-review, testing-strategy
- **marketing** — competitive-brief (go-to-market angle)

If a companion plugin isn't installed, the matching skill still works — it applies the same
methodology from its own steps.

## Learn more

See the [Agency Lab repository](https://github.com/SVehrenkamp/agency-lab) for the framework
spec (`FRAMEWORK.md`), the project template, and the shared phase-skill pattern.
