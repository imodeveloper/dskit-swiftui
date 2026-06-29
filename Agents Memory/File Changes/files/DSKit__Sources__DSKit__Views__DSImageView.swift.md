# DSKit/Sources/DSKit/Views/DSImageView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSImageView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 21:45:00 EEST (`pending`)

- task_or_issue: `local-explorer-image-assets`

#### Request
Support local bundled image assets for DSKitExplorer screens so former web-image examples render in snapshots and generated documentation without network access.

#### Change Summary
Added a `dskit-asset://` URL path in `DSImageView` that resolves the URL host as a `DSUIImage(named:)` asset before falling back to existing test file-image handling or remote Nuke loading.

#### Rationale
DSKitExplorer screen models already pass image URLs into `DSImageView`. A private local URL scheme lets Explorer keep the same image-data shape while replacing network URLs with bundled assets and preserving normal remote image behavior for real HTTP URLs.

#### Invariants
Keep `dskit-asset://` handling ahead of unit-test file URLs and remote loading. Keep regular `http`/`https` URLs on the existing Nuke path. Asset names must be URL hosts and must exist in the app asset catalog.

#### Tests Or Evidence
`DSKitExplorerTests` passed 68/68 after re-recording screen snapshots. Focused `DSKitTests/DSKitTests/testDSImageView` passed. Asset validation confirmed 127 generated JPEG image sets and 211 screen references with zero missing or unused assets.

#### Related Files
`DSKitExplorer/ScreenView.swift`, `DSKitExplorer/Screens/*.swift`, `DSKitExplorer/Assets.xcassets/Generated Web Images`, `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`.

#### Follow-up Risks
The scheme intentionally loads by asset name from the app bundle; framework consumers should only use it when they also bundle the referenced asset names.
