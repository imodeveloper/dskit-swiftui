# Content/AGENTS.md

- source_path: `Content/AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Make DSKit component and screen documentation repo-native, generated, and easy for agents to inspect.

#### Change Summary
Documented generated `Views.md`, per-component pages, usage index, `Screens.md`, per-screen pages, and required snapshot locations.

#### Rationale
Agents working in `Content/` need to know which docs are canonical hand-maintained guides and which files are generated outputs.

#### Invariants
Do not hand-edit generated component pages, screen pages, or usage indexes. Change Swift source, Explorer usage, snapshots, or the generator instead.

#### Tests Or Evidence
Ran the generator and Markdown coverage/link validation.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Content/Screens.md`, `Content/Screens/*.md`, `Scripts/generate_view_docs.py`.

#### Follow-up Risks
`Layout-in-DSKit.md` and `Appearance-in-DSKit.md` remain hand-maintained and must be audited separately when token APIs change.
