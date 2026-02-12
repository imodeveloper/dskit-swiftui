# DSKit Workflows

## Daily and PR workflows

- Build DSKitExplorer locally:
  - `/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project /Users/ivan.borinschi/Work/dskit-swiftui/DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.1' build`
- Preferred runtime flow:
  - Open `DSKitExplorer.xcodeproj`
  - Select scheme `DSKitExplorer`
  - Run on simulator `iPhone 17 Pro (iOS 26.1)`

## Testing

- Snapshot suites run through `DSKitExplorer` scheme and test plan:
  - `DSKitExplorerTests/DSKitExplorer.xctestplan`
- Scope:
  - `DSKitTests` validates component-level contracts in `DSKit/Sources/DSKit`.
  - `DSKitExplorerTests` validates catalog screen outputs.

## Snapshot documentation generation

- Generate/refresh `Content/Views.md`:
  - `cd Scripts`
  - `./documentation_generator.sh`
- The script reads view source comments and snapshot images in `DSKitTests/__Snapshots__/DSKitTests`.
- Run it after API/visual changes in `DSKit/Sources/DSKit/Views`.

## Running on CLI and automation

- `fastlane/Scanfile` defines shared scan defaults for DSKitExplorer:
  - scheme `DSKitExplorer`
  - device `iPhone 17 Pro`
  - testplan `DSKitExplorer`
- If CoreSimulator is unstable, follow the same `xcodebuild` command from a shell with full access.

## Golden maintenance policy

- Snapshot goldens live under `DSKitTests/__Snapshots__/DSKitTests` and `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`.
- Update goldens only with intended visual changes; otherwise report and fix underlying nondeterminism.
