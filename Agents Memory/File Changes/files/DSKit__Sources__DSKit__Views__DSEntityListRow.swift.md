# DSKit/Sources/DSKit/Views/DSEntityListRow.swift

- source_path: `DSKit/Sources/DSKit/Views/DSEntityListRow.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-08 15:17:30 EEST (`pending`)

- task_or_issue: `Article details source navigation and Focus people/source polish`

#### Request
Stabilize article-detail preview/data behavior, add source navigation from article details, refine Focus people/source card visuals, and commit the current development branch changes.

#### Change Summary
Set people avatar size to 1.1x the base token, made row height configurable with a compact source-row option, reserved subtitle height for metadata updates, limited subtitles to two scalable lines, and removed title minimum-scale behavior.

#### Rationale
People rows needed larger but not oversized images, stable title and row size during metadata updates, and source rows needed a way to avoid inheriting the taller people-card height.

#### Invariants
Keep entity row title font fixed; do not reintroduce title scaling that changes apparent size during layout updates. Keep source rows on the compact height while people rows keep the default taller height.

#### Tests Or Evidence
`git diff --check` passed in `dskit-swiftui`; no build was run because the user explicitly requested not to build.

#### Related Files
`DSEntityCardListView.swift`, Monitor `PeopleCardsView.swift`.

#### Follow-up Risks
Snapshot/previews were not regenerated because the user asked not to build; update visual baselines if this ships through DSKit docs/tests.
