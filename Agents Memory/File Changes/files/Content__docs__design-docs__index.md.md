# Content/docs/design-docs/index.md

- source_path: `Content/docs/design-docs/index.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:49:34 EEST (`pending`)

- task_or_issue: `move-root-docs-under-content`

#### Request
Move the root `docs/` folder into `Content/` and update references.

#### Change Summary
Moved the design-doc index from `docs/design-docs/index.md` to `Content/docs/design-docs/index.md`.

#### Rationale
The design-doc index should live beside the design docs it indexes under the unified `Content/docs/` tree.

#### Invariants
Keep this index short and aligned with files in the same folder.

#### Tests Or Evidence
Validated local Markdown links, ran staged whitespace validation, and ran the file-change memory check.

#### Related Files
`Content/docs/design-docs/core-principles.md`, `Content/docs/design-docs/ds-wrapper-principles.md`.

#### Follow-up Risks
If more design docs are added, update this index.
