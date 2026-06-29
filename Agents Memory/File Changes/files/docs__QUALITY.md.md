# docs/QUALITY.md

- source_path: `docs/QUALITY.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Update quality guidance for the new generated component and screen docs.

#### Change Summary
Expanded generated-doc quality rules to include per-component pages, the usage index, screen index, and per-screen pages.

#### Rationale
The quality guide previously named only `Content/Views.md`, which hid the broader generated documentation surface.

#### Invariants
Generated docs must be regenerated from source and snapshots, not manually rewritten.

#### Tests Or Evidence
Ran generator and Markdown coverage/link validation across 155 Markdown files.

#### Related Files
`docs/WORKFLOWS.md`, `Scripts/generate_view_docs.py`, `Content/Views.md`, `Content/Screens.md`.

#### Follow-up Risks
If generated docs expand again, update this quality rule.
