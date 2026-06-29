# Content/docs/PLANS.md

- source_path: `Content/docs/PLANS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:49:34 EEST (`pending`)

- task_or_issue: `move-root-docs-under-content`

#### Request
Move the root `docs/` folder into `Content/` and update references.

#### Change Summary
Moved the plan register to `Content/docs/PLANS.md` and updated its plan/debt paths to the new `Content/docs/` location.

#### Rationale
The plan register should not continue pointing at the removed root `docs/` folder after the documentation tree is consolidated under `Content/`.

#### Invariants
Keep active and completed plan paths aligned with the actual `Content/docs/exec-plans/` folders.

#### Tests Or Evidence
Validated local Markdown links, ran staged whitespace validation, and ran the file-change memory check.

#### Related Files
`Content/docs/exec-plans/active/README.md`, `Content/docs/exec-plans/completed/README.md`.

#### Follow-up Risks
If a debt tracker is created, place it under `Content/docs/tech-debt-tracker.md`.
