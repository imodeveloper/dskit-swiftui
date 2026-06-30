# DSKitExplorer/Screens/CartScreen2.swift

- source_path: `DSKitExplorer/Screens/CartScreen2.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-30 13:12:11 EEST (`pending`)

- task_or_issue: `reusable-screen-pattern-components`

#### Request
Replace repeated cart total composition with a reusable DSKit component.

#### Change Summary
Replaced the local `TotalView` with `DSKeyValueRow(title:count:price:)`.

#### Rationale
All cart screens used the same total row shape, so the pattern belongs in DSKit instead of per-screen helper views.

#### Invariants
Keep cart item count and price supplied by the screen; `DSKeyValueRow` should remain display-only.

#### Tests Or Evidence
Focused `testCartScreen2` snapshot passed on iPhone 17 Pro OS 26.5.

#### Related Files
`DSKit/Sources/DSKit/Views/DSKeyValueRow.swift`, `DSKitExplorer/Screens/CartScreen1.swift`, `CartScreen3.swift`, `CartScreen4.swift`, `CartScreen5.swift`.

#### Follow-up Risks
If cart totals become dynamic, preserve snapshot determinism in the test fixture.

### 2026-06-29 21:45:00 EEST (`pending`)

- task_or_issue: `local-explorer-image-assets`

#### Request
Replace DSKitExplorer screen web images with repo-local images so screen snapshots and generated documentation render deterministically without network image loading.

#### Change Summary
Repointed screen image constants from direct remote `URL(string: "https://...")` values to `ExplorerImageAssets.url(named:)` references for generated asset-catalog images.

#### Rationale
Explorer screens are snapshot and documentation fixtures. Loading images from the web made snapshots blank or dependent on network timing, so screens now use local bundled images with stable asset names.

#### Invariants
Do not reintroduce direct web image URLs in DSKitExplorer screen fixtures. Keep each `ExplorerImageAssets.url(named:)` reference aligned with an image set under `DSKitExplorer/Assets.xcassets/Generated Web Images`.

#### Tests Or Evidence
Validated 211 local image references across 42 screen files against 127 generated assets, with zero unused generated assets and no remaining `https://` URL references in `DSKitExplorer/Screens`. Re-recorded Explorer snapshots and re-ran `DSKitExplorerTests`: 68 passed. Regenerated docs: 68 screen pages, 69 frames, 17 strips.

#### Related Files
`DSKitExplorer/ScreenView.swift`, `DSKit/Sources/DSKit/Views/DSImageView.swift`, `DSKitExplorer/Assets.xcassets/Generated Web Images`, `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`, `Content/Screens/Frames`, `Content/Screens/Groups`.

#### Follow-up Risks
If image assets are renamed or regenerated, update the screen references, re-record affected snapshots, and rerun `Scripts/documentation_generator.sh` in the same change.
