# DSKitTests/DSKitTests.swift

- source_path: `DSKitTests/DSKitTests.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-17 18:55:00 EEST (`article-presentation-snapshot-reconciliation`)

- task_or_issue: `Align DSKit contracts and visual baselines with the delivered article presentation tuning`
- change_id: `article-presentation-snapshot-reconciliation`

#### Request
After delivering the authored source changes unchanged, update tests and snapshots only where the intentional appearance, article image, or letter-badge behavior changed.

#### Change Summary
Updated the LightBlue secondary-light-background assertion from `0xF9F9F9` to `0xF3F4F2` and refreshed the five component baselines affected by the 48-point article image default and tighter/larger letter badges. The full suite also exposed 19 stale Explorer baselines: two are direct palette/swatch changes, while 17 include visually reviewed current-runtime raster or layout catch-up in addition to the requested palette. Their generated frames and catalog strips were regenerated. Two component images unnecessarily rewritten by record mode were restored because their prior baselines still pass.

#### Rationale
The source commit intentionally changed these shared DSKit contracts. Keeping the previous expectation and goldens would reject the shipped design rather than detect a regression.

#### Invariants
Keep snapshot recording disabled in committed test runs. Distinguish direct source-driven deltas from current-runtime baseline catch-up in evidence, visually review every changed screen, and continue honoring explicit article image-size overrides independently of the 48-point default.

#### Tests Or Evidence
All five focused component contract and snapshot tests and all 19 focused Explorer screen tests passed after recording was disabled. The full DSKit scheme then passed 71 Explorer tests, 50 component tests, and 6 Swift Testing interaction tests with zero failures; documentation generation completed successfully.

#### Related Files
`DSKitAppearance.swift`, `DSArticleRows.swift`, `DSLetterBadgeView.swift`, the affected component and Explorer snapshots, and generated screen frames/catalog strips.

#### Follow-up Risks
Shared badge geometry can legitimately affect any downstream view embedding `DSLetterBadgeView`. The Explorer screens include live/static imagery and one MapKit surface, so future changes should avoid bulk acceptance and should audit runtime raster drift separately from source-driven color changes.

### 2026-07-17 15:14:00 EEST (`thread-terminal-connector-fade`)

- task_or_issue: `The final connector fade needed meaningful exact visual coverage`
- change_id: `thread-terminal-connector-fade`

#### Request
Protect one final connector, zero spacing under its badge, and the 32-point opacity transition without accepting the obsolete overlapping footer line.

#### Change Summary
Added a dedicated full-screen `DSThreadSectionTerminalFade` fixture and golden. Its assertion uses exact pixel and perceptual precision with zero retries so the small connector geometry cannot pass through a relaxed whole-screen tolerance.

#### Rationale
The pre-existing component-sized thread snapshot compresses `DSList` into a blank strip and cannot prove the requested geometry. A deterministic screen-sized fixture exposes all three connectors and the final fade directly.

#### Invariants
Keep recording disabled in committed test code. Do not weaken the focused assertion or replace the fixed opacity steps with a nondeterministic gradient.

#### Tests Or Evidence
The test failed red against the old final-badge geometry, the refreshed 1179 by 2556 golden was visually inspected, and both the new exact snapshot and existing thread-section snapshot passed twice on Capone.

#### Related Files
`DSKit/Sources/DSKit/Views/DSThread.swift` and `DSKitTests/__Snapshots__/DSKitTests/DSThreadSectionTerminalFade.snapshot.png`.

#### Follow-up Risks
Snapshot recording reports an expected XCTest failure; always turn recording off and rerun twice before commit.

### 2026-07-16 19:00:05 EEST (`appearance-and-floating-banner-contracts`)

- task_or_issue: `Cover appearance brand resolution, requested backgrounds, and floating-banner APIs`

#### Request
Use TDD for the appearance and production sync-banner changes and preserve intentional existing visual adjustments.

#### Change Summary
Added tests for semantic brand token resolution, the `0xF9F9F9` secondary light surface, DSLoadingIndicator-backed banner loading, tint-independent transition identity, and compact banner size. Updated only the DSKeyValueRow snapshot affected by the existing label/corner changes after visual review.

#### Rationale
The behavior crosses semantic tokens and generic component presentation, so direct contracts prevent future Monitor-specific regressions or loading-surface restarts.

#### Invariants
Do not update unrelated snapshots merely to make a suite pass. Snapshot updates must correspond to an intentional requested component/token change and be visually reviewed.

#### Tests Or Evidence
The full `DSKitTests` suite passed on Capone; component documentation regenerated successfully with 55 component pages and 71 screen pages.

#### Related Files
`DSKitAppearance.swift`, `DSAppearance.swift`, `DSTypographyToken.swift`, `DSCornerRadiusModifier.swift`, `DSFloatingBannerView.swift`, and `DSKeyValueRow.snapshot.png`.

#### Follow-up Risks
Global typography and corner tokens can surface additional intentional snapshot differences when previously unexercised components are rendered.

### 2026-07-07 17:15:00 EEST (`onboarding-and-particle-snapshots`)

- task_or_issue: `DSKit visual changes need deterministic snapshot coverage`
- change_id: `onboarding-and-particle-snapshots`

#### Request
Review DSKit changes from the Monitor UI polish session and fix regressions before commit.

#### Change Summary
Replaced brittle onboarding source-string checks with a rendered brand/legal-link snapshot, updated the text-particle loading snapshot for side-to-side top-to-bottom travel, and added a direct particle-model invariant test for side crossing and cycle completion.

#### Rationale
Rendered snapshots prove the visible behavior more directly than source substrings and catch deterministic particle-model changes.

#### Invariants
Keep snapshot assertions deterministic. Regenerate docs after DSKit visual component changes.

#### Tests Or Evidence
Focused DSKit test run passed for `testExtractedMonitorComponents`, `testDSOnboardingWelcomeViewUsesAppearanceBrandForLegalLinkAndBoldHeadline`, `testDSTextParticleLoadingModelTravelsSideToSideTopToBottom`, and `testDSLoadingIndicator`.

#### Related Files
`DSKit/Sources/DSKit/Views/DSOnboardingWelcomeView.swift`, `DSKit/Sources/DSKit/Views/DSTextParticleLoadingView.swift`, `Content/Views/DSOnboardingWelcomeView.md`.

#### Follow-up Risks
Avoid adding new source-string tests when a rendered snapshot can verify the behavior.

### 2026-07-07 00:28:00 EEST (`pending`)

- task_or_issue: `monitor-reusable-components-dskit-docs`

#### Request
Finish DSKit coverage for Monitor-derived reusable components with snapshots and generated component documentation.

#### Change Summary
Added exact snapshot assertions for `DSAppIconHeroView`, `DSEntityCardListView`, `DSEntityListRow`, `DSOnboardingWelcomeView`, `DSPermissionPromptView`, and `DSTextParticleLoadingView`; recorded the missing `DSLoadingIndicator` baseline too.

#### Rationale
The strict component docs guard expects each DSKit view file to have an exact assertion, an exact PNG snapshot, a generated page, and a `Content/Views.md` preview reference.

#### Invariants
Keep assertion names, snapshot filenames, generated page names, and source filenames aligned as `<Component>`.

#### Tests Or Evidence
Ran focused Xcode tests for `testDSLoadingIndicator`, `testExtractedMonitorComponents`, and `testEveryDSKitViewHasSnapshotCoverageAndDocumentationPreview`; all passed on iPhone 17 Pro iOS 26.5.

#### Related Files
`DSKitTests/__Snapshots__/DSKitTests/*.snapshot.png`, `Content/Views.md`, `Content/Views/*.md`, `Scripts/generate_view_docs.py`.

#### Follow-up Risks
Changing extracted component visuals requires intentional snapshot updates and docs regeneration in the same commit.

### 2026-06-30 13:12:11 EEST (`pending`)

- task_or_issue: `reusable-screen-pattern-components`

#### Request
Add snapshot coverage for new reusable DSKit components extracted from Explorer screens.

#### Change Summary
Added exact component snapshot assertions for `DSKeyValueRow`, `DSPriceSummaryList`, and `DSStatusView`.

#### Rationale
Every DSKit view file must have an exact snapshot assertion and generated documentation preview.

#### Invariants
Keep assertion names aligned with component filenames and snapshot PNG names.

#### Tests Or Evidence
Focused new component snapshot tests and the generated component docs guard passed on iPhone 17 Pro OS 26.5.

#### Related Files
`DSKit/Sources/DSKit/Views/DSKeyValueRow.swift`, `DSPriceSummaryList.swift`, `DSStatusView.swift`, `DSKitTests/__Snapshots__/DSKitTests/*.snapshot.png`, `Content/Views.md`.

#### Follow-up Risks
If component snapshots are renamed or moved, update the docs guard and generator expectations together.

### 2026-06-29 14:59:01 EEST (`pending`)

- task_or_issue: `component-snapshot-doc-coverage-guard`

#### Request
Make sure every DSKit view/component has snapshot test coverage and those snapshots are used in documentation.

#### Change Summary
Added `testEveryDSKitViewHasSnapshotCoverageAndDocumentationPreview()` to enumerate `DSKit/Sources/DSKit/Views/*.swift` and verify each component has an exact snapshot assertion, an exact snapshot PNG, a generated component page, a page preview image, and a preview image reference in `Content/Views.md`.

#### Rationale
The documentation generator already requires snapshot files for generated pages, but the test suite should also fail when a future component is added without an exact snapshot assertion or when docs stop embedding the component snapshot.

#### Invariants
Keep exact component snapshot names aligned to Swift filenames: `<Component>.snapshot.png` and `named: "<Component>"`. Generated component pages and the index must continue to use those exact snapshot files.

#### Tests Or Evidence
Ran the focused Xcode test `DSKitTests/DSKitTests/testEveryDSKitViewHasSnapshotCoverageAndDocumentationPreview`; it passed. Ran a static audit confirming 45 components and no missing assertions, snapshots, pages, page snapshot links, or index snapshot links.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `DSKitTests/__Snapshots__/DSKitTests/*.snapshot.png`, `Scripts/generate_view_docs.py`.

#### Follow-up Risks
If snapshot assertions move out of `DSKitTests.swift`, update this guard so it checks the new source of truth instead of looking for exact names in this file.

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `component-preview-docs`

#### Request
Ensure every DSKit view/component has a preview image for generated documentation.

#### Change Summary
Added `testGeneratedComponentPreviewSnapshots()` and focused `ComponentPreview_*` views for DSKit views that did not already have exact component preview snapshots.

#### Rationale
The documentation generator now requires `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png` for every view file. Missing focused previews needed deterministic snapshot coverage.

#### Invariants
Keep preview views deterministic, local-data-only, and independent of unstaged app state. Use explicit spacing when a preview should not track default spacing changes.

#### Tests Or Evidence
Recorded missing snapshots, then reran `testGeneratedComponentPreviewSnapshots` without record mode on the available iPhone 17 Pro simulator; 1 test passed with 0 failures.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Views.md`, `Content/Views/*.md`, `DSKitTests/__Snapshots__/DSKitTests/*.snapshot.png`.

#### Follow-up Risks
Visual changes to component defaults may require intentional snapshot updates.
