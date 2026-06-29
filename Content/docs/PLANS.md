# DSKit Execution & Debt Plan Register

## Plan folders

- Active plans: `Content/docs/exec-plans/active/`
- Completed plans: `Content/docs/exec-plans/completed/`
- Debt tracker: `Content/docs/tech-debt-tracker.md` (create when recurring drift is identified)

## Plan format
- Keep each plan short:
  - Goal
  - Scope/Files
  - Constraints
  - Exit criteria
  - Validation done
- One plan per significant non-trivial change (UI system-level change, snapshot contract change, doc generator update, dependency bump).

## When to use a plan

- Use only for work that will touch:
  - multiple directories
  - snapshot expectations
  - public API surface
  - release or migration behavior

## When to close a plan

- Move completed plan files to `Content/docs/exec-plans/completed/`.
- Include final decision logs and any follow-up debt items before close.
