# Scripts/generate_view_docs.py

- source_path: `Scripts/generate_view_docs.py`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:24:27 EEST (`pending`)

- task_or_issue: `simplify-views-index-preview-catalog`

#### Request
Update `Content/Views.md` so it shows the full component list with larger previews and removes Category, Purpose, Source, and Explorer usage columns.

#### Change Summary
Changed the main component index generation to produce one complete `Preview | Component` table with 240px preview images. Removed the quick-link list, primitive/component section split, metadata columns, source column, and usage counts from `Content/Views.md`.

#### Rationale
The main views index should be a visual catalog that helps humans and agents pick components by snapshot preview. Detailed source links, examples, and usage references remain on the per-component pages and generated usage index.

#### Invariants
Keep `Content/Views.md` generated from snapshots and component filenames. Every component row must include the exact `<Component>.snapshot.png` preview and link to `Content/Views/<Component>.md`.

#### Tests Or Evidence
Ran `Scripts/documentation_generator.sh`, verified 45 component rows, 45 `width="240"` preview images, no forbidden metadata columns, and no broken links in `Content/Views.md`.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `DSKitTests/__Snapshots__/DSKitTests/*.snapshot.png`.

#### Follow-up Risks
If GitHub rendering makes 240px previews too large on narrow screens, adjust only `preview_thumbnail` width and regenerate docs.

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
