# DSKit/Sources/DSKit/Views/DSSectionHeaderView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSSectionHeaderView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-08 15:17:30 EEST (`pending`)

- task_or_issue: `Article details source navigation and Focus people/source polish`

#### Request
Stabilize article-detail preview/data behavior, add source navigation from article details, refine Focus people/source card visuals, and commit the current development branch changes.

#### Change Summary
Reduced section header call-to-action link text font from label to subheadline.

#### Rationale
Header action text needed a quieter visual weight next to Focus section titles and compact entity rows.

#### Invariants
Keep header action styling centralized in `DSSectionHeaderView` so screens do not special-case this size.

#### Tests Or Evidence
`git diff --check` passed in `dskit-swiftui`; no build was run because the user explicitly requested not to build.

#### Related Files
Focus section headers and DSKit section header consumers.

#### Follow-up Risks
Snapshot/previews were not regenerated because the user asked not to build; update visual baselines if this ships through DSKit docs/tests.
