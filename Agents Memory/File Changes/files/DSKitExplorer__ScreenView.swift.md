# DSKitExplorer/ScreenView.swift

- source_path: `DSKitExplorer/ScreenView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 21:45:00 EEST (`pending`)

- task_or_issue: `local-explorer-image-assets`

#### Request
Give DSKitExplorer screens a stable way to reference generated local image assets instead of direct web image URLs.

#### Change Summary
Added `ExplorerImageAssets.url(named:)`, which creates `dskit-asset://<asset-name>` URLs consumed by `DSImageView`.

#### Rationale
Keeping URL-shaped image inputs avoids rewriting every screen model and preserves the existing `DSImageView` API while making the fixtures network-independent.

#### Invariants
Use this helper for generated web-image replacements in Explorer screens. Keep asset names synchronized with `DSKitExplorer/Assets.xcassets/Generated Web Images` and avoid direct remote URLs in screen fixtures.

#### Tests Or Evidence
Validated all 211 `ExplorerImageAssets.url(named:)` references resolve to generated assets. `DSKitExplorerTests` passed 68/68 after snapshot recording. Generated docs rebuilt 68 screen pages, 69 frames, and 17 strips.

#### Related Files
`DSKit/Sources/DSKit/Views/DSImageView.swift`, `DSKitExplorer/Screens/*.swift`, `DSKitExplorer/Assets.xcassets/Generated Web Images`, `Content/Screens/Groups`.

#### Follow-up Risks
If the asset URL scheme changes in DSKit, update this helper and all generated screen references together.
