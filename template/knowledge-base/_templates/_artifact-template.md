---
artifact: <name, e.g. Product Requirements Document>
phase: <NN · Phase name>
status: draft        # draft | in-review | approved
mode: draft-then-approve   # draft-then-approve | auto | collab
consumes:            # upstream artifacts this one depends on
  - <path/to/upstream.md>
produced: <YYYY-MM-DD>
approved: <YYYY-MM-DD or blank>
---

# <Artifact title>

> One-line statement of what this artifact establishes and why it exists.

## Summary

<The body of the artifact. This is the current source of truth, read together
with the amendment log below.>

## Open questions

- <Anything unresolved that a downstream phase or a gate review should watch.>

---

## Amendment Log

Append-only. Add a row when a later phase surfaces a learning that contradicts
this artifact. Do not edit the body in response — record it here and let the next
gate review decide whether to **absorb** (fold in, move on) or **reopen**.

| Date | Learned in phase | Assumption touched | Severity | Disposition |
|------|------------------|--------------------|----------|-------------|
| | | | minor / major | absorb / reopen / undecided |
