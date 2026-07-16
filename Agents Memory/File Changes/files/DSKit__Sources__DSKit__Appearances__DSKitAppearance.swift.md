# DSKit/Sources/DSKit/Appearances/DSKitAppearance.swift

- source_path: `DSKit/Sources/DSKit/Appearances/DSKitAppearance.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-16 19:00:05 EEST (`monitor-article-presentation-banner-release`)

- task_or_issue: `Monitor appearance surfaces must use the requested light background`

#### Request
Use the requested appearance background instead of hard-coded or stale light surface colors while preserving dark mode.

#### Change Summary
Changed `LightBlueAppearance.secondaryView.background` from `0xF3F4F2` to `0xF9F9F9` for light mode only.

#### Rationale
Monitor cards and appearance-driven root surfaces must resolve through one shared semantic background rather than screen-specific colors.

#### Invariants
Keep the dark value `0x101A24` unchanged unless a separate dark-mode request explicitly changes it.

#### Tests Or Evidence
`DSKitTests.testLightBlueAppearanceUsesRequestedSecondaryLightBackground` and the full DSKit component suite passed.

#### Related Files
`Monitor/App/MonitorApp.swift`, `DSKitTests/DSKitTests.swift`, and Monitor screen snapshots.

#### Follow-up Risks
This token is shared by every LightBlue secondary surface; future changes require visual review across DSKit and Monitor.
