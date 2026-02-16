# Agent Instructions

## Purpose
- Demo/catalog app for DSKit components and full-screen layouts.

## Key Files
- Entry point: `DSKitExplorerApp.swift`.
- Screen list and labels: `ScreenKey.swift`.
- Individual screens live in `Screens/`.

## Integration Points
- Used as a workspace dependency by MNews to build and embed `DSKit.framework`.
- Screenshot mode is enabled by `screenshot` env var (see `DSKitExplorerApp.swift`).

## Conventions / Pitfalls
- Keep screens deterministic for snapshot tests.
- Add new screens to `ScreenKey` and `ScreenView` to expose them in the catalog.
- Use `FoodHomeScreen1` as a preview canary when changing `DSCoverFlow`; it has reproduced coverflow/preview crash regressions.

## Run / Test in Isolation
- Open `DSKitExplorer.xcodeproj` and run `DSKitExplorer` scheme.
