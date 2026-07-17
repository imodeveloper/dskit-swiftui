# DSKit/Sources/DSKit/Appearances/DSKitAppearance.swift

- source_path: `DSKit/Sources/DSKit/Appearances/DSKitAppearance.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-17 18:21:20 EEST (`light-blue-final-color-tuning`)

- task_or_issue: `The Light Blue appearance needed the authored final text and surface colors`
- change_id: `light-blue-final-color-tuning`

#### Request
Preserve the current authored Light Blue appearance changes exactly as they are.

#### Change Summary
Changed the light large-title, title, headline, and body colors from `0x14171A` to pure black and changed the secondary light background from `0xF9F9F9` to `0xF3F4F2`.

#### Rationale
The final Monitor appearance uses stronger primary-text contrast over a slightly darker neutral secondary surface.

#### Invariants
Keep the change scoped to Light Blue light mode. Preserve all existing dark-mode color values and semantic token routing.

#### Tests Or Evidence
`git diff --check` passes. DSKit and Monitor snapshot reconciliation is intentionally deferred until after the requested Dev and Prod deliveries.

#### Related Files
`DSKitTests/DSKitTests.swift`, DSKit component snapshots, and Monitor screen snapshots.

#### Follow-up Risks
This shared appearance affects many light-mode surfaces, so visual baselines may need intentional refreshes.

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
