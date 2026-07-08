# DSKit/Sources/DSKit/Views/DSEntityCardListView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSEntityCardListView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-08 15:17:30 EEST (`pending`)

- task_or_issue: `Article details source navigation and Focus people/source polish`

#### Request
Stabilize article-detail preview/data behavior, add source navigation from article details, refine Focus people/source card visuals, and commit the current development branch changes.

#### Change Summary
Reduced entity card list spacing from `.space4` to `.space2`.

#### Rationale
Focus people cards use this component and needed tighter vertical spacing between items.

#### Invariants
Keep spacing token-based and avoid wrapping large list content in a way that breaks virtualization.

#### Tests Or Evidence
`git diff --check` passed in `dskit-swiftui`; no build was run because the user explicitly requested not to build.

#### Related Files
`DSEntityListRow.swift`, Monitor `PeopleCardsView.swift`.

#### Follow-up Risks
Snapshot/previews were not regenerated because the user asked not to build; update visual baselines if this ships through DSKit docs/tests.
