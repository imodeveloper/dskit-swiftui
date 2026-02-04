# Skills: DSKitExplorer Build/Run

## Purpose
Standardize the build/run steps for the DSKitExplorer app on the iPhone 17 Pro (iOS 26.1) simulator.

## Build
### DSKitExplorer
```
/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild \
  -project /Users/borinschi.ivan/Work/tmp/dskit-swiftui/DSKitExplorer.xcodeproj \
  -scheme DSKitExplorer \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.1' \
  build
```

## Run (Xcode)
1. Open `DSKitExplorer.xcodeproj`.
2. Select scheme `DSKitExplorer`.
3. Select simulator **iPhone 17 Pro (iOS 26.1)**.
4. Run.

## Run (CLI)
- Install: `xcrun simctl install <device-udid> <path-to-app>`
- Launch: `xcrun simctl launch <device-udid> <bundle-id>`

Bundle ID:
- DSKitExplorer: `dskit.app.DSKitExplorer.com`

## Notes
- This repo is referenced by `../imodeveloper/Workspace.xcworkspace`.
- If CoreSimulator or log access errors occur, run the build command unsandboxed.
- `Testable_DSImageView` uses a local demo image (from the app bundle) written to a temp file URL to keep snapshots deterministic.
