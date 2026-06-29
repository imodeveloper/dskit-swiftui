# Scripts/generate_view_docs.py

- source_path: `Scripts/generate_view_docs.py`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 16:52:44 EEST (`pending`)

- task_or_issue: `remove-screen-testable-examples`

#### Request
Remove generated `Testable Example` sections from screen documentation pages.

#### Change Summary
Removed the screen-page `doc.example` output block from `write_screen_page` and updated the screen index guidance so screen pages are described as source, snapshot, and DSKit view references only.

#### Rationale
Screen pages should stay focused on visual previews and navigable references. The `Testable_*` wrappers are still useful in Swift sources and tests, but including their full code in every generated screen page makes the docs harder to scan.

#### Invariants
Keep component examples unchanged; this change only removes `Testable Example` sections from generated screen pages. Continue refreshing generated docs through `Scripts/documentation_generator.sh`.

#### Tests Or Evidence
Ran `Scripts/documentation_generator.sh`, verified no `## Testable Example` or `Testable_` references remain under `Content/Screens` or `Content/Screens.md`, verified generated links/images resolve locally, and ran `git diff --check` over the generator and screen docs.

#### Related Files
`Content/Screens.md`, `Content/Screens/*.md`.

#### Follow-up Risks
If agents need the wrapper code later, link to the Swift source rather than expanding the wrapper inline in generated screen pages.

### 2026-06-29 16:48:51 EEST (`pending`)

- task_or_issue: `screen-catalog-matrix-previews`

#### Request
Make `Content/Screens.md` previews bigger, fix the tall table layout, and make each preview image link to its screen page.

#### Change Summary
Changed screen index generation from two-column Markdown tables to three-column HTML preview matrices. Each screen preview image now links directly to the generated screen page and uses a fixed `height="520"` display size.

#### Rationale
The table layout made tall screenshots dominate rows and separated the preview from the destination link. A matrix keeps the catalog visual, gives images a stable display height, and makes the screenshot itself the primary navigation target.

#### Invariants
Keep the screen catalog generated from screen docs and snapshot paths. Preserve one linked image per generated screen page and keep display sizing centralized through constants.

#### Tests Or Evidence
Ran `Scripts/documentation_generator.sh`, verified `Content/Screens.md` has 68 linked preview images, 68 fixed-height images, 10 family tables, and no old `Preview | Screen` table.

#### Related Files
`Content/Screens.md`, `Content/Screens/*.md`, `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/*.snapshot.png`.

#### Follow-up Risks
If GitHub renders three 520px-high previews too wide on smaller screens, adjust `SCREEN_INDEX_COLUMNS` or `SCREEN_INDEX_PREVIEW_HEIGHT` and regenerate docs.

### 2026-06-29 16:40:20 EEST (`pending`)

- task_or_issue: `larger-generated-page-previews`

#### Request
Make previews inside generated pages bigger, starting with component pages such as `Content/Views/DSVStack.md`.

#### Change Summary
Added page and index preview width constants, kept catalog thumbnails at 240px, and changed generated component and screen detail page preview images from `35%` to `60%`.

#### Rationale
The catalog pages should stay scan-friendly, but dedicated component and screen pages need larger snapshot previews for easier inspection.

#### Invariants
Keep preview sizing centralized in constants. Regenerate docs after changing page preview width; do not hand-edit generated component or screen pages.

#### Tests Or Evidence
Ran `Scripts/documentation_generator.sh`, verified `DSVStack.md` and `NewsScreen1.md` use `width="60%"`, verified no `width="35%"` remains under `Content/Views` or `Content/Screens`, and validated links/image references plus whitespace.

#### Related Files
`Content/Views/*.md`, `Content/Screens/*.md`, `Content/Views.md`, `Content/Screens.md`.

#### Follow-up Risks
If 60% renders too large on GitHub mobile pages, adjust `PAGE_PREVIEW_WIDTH` and regenerate docs.

### 2026-06-29 16:36:55 EEST (`pending`)

- task_or_issue: `move-views-index-agent-guidance`

#### Request
Move the generated-note and Agent Quick Start block in `Content/Views.md` to the end of the file.

#### Change Summary
Changed `write_main_index` so `Content/Views.md` starts directly with the component catalog and places the generated-note plus Agent Quick Start section after Maintenance.

#### Rationale
The main component index should prioritize the visual catalog at the top while keeping generated-file and agent guidance available at the end.

#### Invariants
Keep `Content/Views.md` generated from this script. Do not hand-edit the generated index for ordering changes; update `write_main_index` and rerun `Scripts/documentation_generator.sh`.

#### Tests Or Evidence
Ran `Scripts/documentation_generator.sh` and verified `Content/Views.md` starts with `## Component Catalog` while the generated-note and Agent Quick Start section appear at the end.

#### Related Files
`Content/Views.md`.

#### Follow-up Risks
If the screen catalog needs the same ordering treatment, update the screen index generation separately.

### 2026-06-29 15:59:37 EEST (`pending`)

- task_or_issue: `simplify-screen-index-preview-catalog`

#### Request
Update `Content/Screens.md` so the screen catalog removes Source, DSKit views, and Snapshots columns, and uses larger previews.

#### Change Summary
Changed screen index generation to produce `Preview | Screen` tables with 240px screen preview images. Kept source links, detected DSKit view references, and snapshot details on each generated per-screen page.

#### Rationale
The top-level screen catalog should work as a visual picker. Detailed metadata belongs on the dedicated screen pages.

#### Invariants
Keep `Content/Screens.md` generated from screen docs and snapshot paths. Every screen row must link to `Content/Screens/<Screen>.md` and use the first matching screen snapshot as its preview.

#### Tests Or Evidence
Ran `Scripts/documentation_generator.sh`, verified 68 screen rows, 68 `width="240"` preview images, no Source/DSKit views/Snapshots columns, and no broken links in `Content/Screens.md`.

#### Related Files
`Content/Screens.md`, `Content/Screens/*.md`, `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/*.snapshot.png`.

#### Follow-up Risks
If GitHub rendering makes 240px screen previews too large on narrow screens, adjust only `screen_preview_thumbnail` width and regenerate docs.

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
