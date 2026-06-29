# docs/design-docs/core-principles.md

- source_path: `docs/design-docs/core-principles.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Make design docs reflect the full generated docs system.

#### Change Summary
Updated visual-doc principles to include screen snapshots, generated component pages, and generated screen pages.

#### Rationale
The design principles still described generated docs as only `Content/Views.md`.

#### Invariants
Keep this file high-level. Detailed generator rules belong in `docs/WORKFLOWS.md` and `AGENTS.md`.

#### Tests Or Evidence
Ran Markdown validation and generated-doc coverage checks.

#### Related Files
`docs/design-docs/ds-wrapper-principles.md`, `Content/Views.md`, `Content/Screens.md`.

#### Follow-up Risks
None beyond keeping generated-doc references current.
