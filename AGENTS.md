# Agent Instructions

## Project Purpose
- DSKit is a SwiftUI design system library.
- DSKitExplorer is the demo app and snapshot-test surface for DSKit.
- This repo is referenced by `../imodeveloperlab/Workspace.xcworkspace` to provide `DSKit.framework`.

## Architecture Pointers
- Library sources: `DSKit/Sources/DSKit` (Views, Modifiers, Appearances, Helpers, Fonts).
- Demo app: `DSKitExplorer/` with a screen catalog driven by `ScreenKey`.
- Snapshot tests: `DSKitTests` and `DSKitExplorerTests` with goldens in `__Snapshots__`.

## Build (simulator)
- Project: `DSKitExplorer.xcodeproj`
- Destination: `platform=iOS Simulator,name=iPhone 17 Pro,OS=26.1`

### DSKitExplorer
```
/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild \
  -project /Users/borinschi.ivan/Work/tmp/dskit-swiftui/DSKitExplorer.xcodeproj \
  -scheme DSKitExplorer \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.1' \
  build
```

## Run (simulator)
- Preferred: open `DSKitExplorer.xcodeproj` in Xcode and run the `DSKitExplorer` scheme on **iPhone 17 Pro (iOS 26.1)**.
- CLI alternative (if needed): install and launch from DerivedData.

Bundle ID:
- DSKitExplorer: `dskit.app.DSKitExplorer.com`

## Tests
- Snapshot tests live in `DSKitTests` and `DSKitExplorerTests`.
- Test plan: `DSKitExplorerTests/DSKitExplorer.xctestplan`.

## Notes
- This repo is referenced by `../imodeveloperlab/Workspace.xcworkspace`.
- If CoreSimulator access fails, run the build command unsandboxed.
- `Testable_DSImageView` uses a local demo image (from the app bundle) written to a temp file URL to keep snapshots deterministic.
