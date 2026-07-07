# DSKit/Sources/DSKit/Views/DSTextParticleLoadingView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSTextParticleLoadingView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-07 17:15:00 EEST (`source-title-side-to-side-loading`)

- task_or_issue: `Monitor sync screen source-title animation should move top-to-bottom and side-to-side`
- change_id: `source-title-side-to-side-loading`

#### Request
Remove the old sync icon/progress/messages and keep a looping source-title animation that travels from top to bottom, side to side, slowed by 20 percent.

#### Change Summary
Adjusted text particle generation to start/end beyond opposite horizontal edges, keep the midpoint inside the viewport, scale movement durations by `1.2`, and use a cycle duration that lets the longest particle complete before re-seeding.

#### Rationale
The sync screen needs an ambient title field that crosses the full screen instead of hovering near the center.

#### Invariants
The particle model must remain deterministic for snapshots. Any timing change should update the exact snapshot baseline intentionally. `cycleDuration` must stay at least as long as the maximum generated particle duration.

#### Tests Or Evidence
Focused DSKit test run passed for `testExtractedMonitorComponents`, `testDSOnboardingWelcomeViewUsesAppearanceBrandForLegalLinkAndBoldHeadline`, `testDSTextParticleLoadingModelTravelsSideToSideTopToBottom`, and `testDSLoadingIndicator`.

#### Related Files
`DSKitTests/DSKitTests.swift`, `DSKitTests/__Snapshots__/DSKitTests/DSTextParticleLoadingView.snapshot.png`, Monitor `SyncScreen`.

#### Follow-up Risks
If viewport math changes, inspect both DSKit exact snapshot and Monitor sync screen snapshot.
