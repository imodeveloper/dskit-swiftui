# DSKit execution plans

- Status: current
- Read when: work spans multiple directories, public API, snapshot contracts,
  release, or migration behavior
- Last reviewed: 2026-08-07

## When to use a plan

Routine component, example, snapshot, or documentation edits use the request,
source, focused tests, and generated-doc gate directly. Use a plan only when
sequencing or resumability would otherwise be unclear.

Do not use a plan as architectural history. Add a standalone ADR only when the
decision is costly or risky to reverse, would surprise a future maintainer, and
records a real rejected alternative. Accepted ADRs are preserved; a later
decision creates a replacement and marks the old record superseded.

Keep plans in an OS temporary directory by default. A repository-visible plan
is exceptional and belongs in `Content/docs/exec-plans/active/` only while work
is genuinely active.

## Required shape

A tracked plan must stay compact and contain:

- `Status: active`
- `Last reviewed: YYYY-MM-DD`
- `Review by: YYYY-MM-DD`
- goal and stable acceptance IDs when a governing specification provides them;
- scope/files and constraints;
- Red -> Green -> Refactor seam or characterization reason;
- validation and the exact resume trigger when paused.

## Completion

Delete a completed or abandoned plan after folding lasting behavior into
source, tests, generated documentation, a current specification, or a rare ADR.
Do not maintain a completed-plan archive; Git history preserves it. Record
recurring unresolved work in the issue tracker, not in agent memory.
