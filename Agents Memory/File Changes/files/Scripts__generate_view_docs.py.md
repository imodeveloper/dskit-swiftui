# Scripts/generate_view_docs.py

- source_path: `Scripts/generate_view_docs.py`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Create generated, agent-friendly DSKit component and screen documentation from Swift source, snapshots, and Explorer usage.

#### Change Summary
Expanded the Python generator to enforce exact component preview snapshots, generate component pages, generate a primitive/component catalog, generate per-screen pages with snapshot previews, generate `Content/Screens.md`, and link component usage to screen docs.

#### Rationale
DSKit has many views and many Explorer screens. Generated docs keep source comments, examples, snapshots, source links, related components, and screen usage synchronized without relying on the retired website.

#### Invariants
Component identity is the Swift filename basename. Screen docs are snapshot-backed. Usage scanning stays limited to `DSKitExplorer/Screens/*.swift`. Keep output stable, sorted, repo-relative, and free of website/domain or absolute local path references.

#### Tests Or Evidence
Ran the generator and Markdown coverage/link validation across 155 Markdown files. Focused component preview snapshot test passed after adding missing goldens.

#### Related Files
`Scripts/documentation_generator.sh`, `Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Content/Screens.md`, `Content/Screens/*.md`, `DSKitTests/DSKitTests.swift`.

#### Follow-up Risks
Swift parsing is intentionally lightweight. If source examples become more complex, update brace/comment extraction conservatively and keep deterministic output tests/checks.
