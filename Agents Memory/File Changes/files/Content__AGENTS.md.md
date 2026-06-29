# Content/AGENTS.md

- source_path: `Content/AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:40:29 EEST (`pending`)

- task_or_issue: `separate-generated-docs-workflow`

#### Request
Move the generated documentation maintenance paragraph out of the README and into a separate documentation page.

#### Change Summary
Added `Content/Documentation.md` to the Content guide as a hand-maintained generated-docs workflow guide referenced by README.

#### Rationale
Agents editing Content need to know that the new workflow page is not generated, while the Views and Screens documentation surfaces remain generated outputs.

#### Invariants
Keep generated-doc output rules explicit. Do not hand-edit generated `Content/Views*` or `Content/Screens*` pages.

#### Tests Or Evidence
Validated Markdown links for README, Content docs, and the new workflow page; ran staged whitespace validation and file-change memory check.

#### Related Files
`Content/Documentation.md`, `README.md`, `Content/CONTRIBUTING.md`.

#### Follow-up Risks
If more hand-maintained Content pages are added, keep this routing guide current.

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
