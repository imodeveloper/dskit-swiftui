# DSKit Workflows

## Daily and PR workflows

- Build DSKitExplorer locally:
  - `/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2' build`
- Preferred runtime flow:
  - Open `DSKitExplorer.xcodeproj`
  - Select scheme `DSKitExplorer`
  - Run on simulator `iPhone 17 Pro`
- If the exact documented simulator runtime is not installed, use the installed `iPhone 17 Pro` runtime and record the OS version in your validation notes.

## Testing

- Snapshot suites run through `DSKitExplorer` scheme and test plan:
  - `DSKitExplorerTests/DSKitExplorer.xctestplan`
- Scope:
  - `DSKitTests` validates component-level contracts in `DSKit/Sources/DSKit`.
  - `DSKitExplorerTests` validates catalog screen outputs.

## Snapshot documentation generation

- Generate/refresh `Content/Views.md`, per-component pages, `Content/Screens.md`, per-screen pages, framed screen previews, and the Explorer usage index:
  - `cd Scripts`
  - `./documentation_generator.sh`
- If a new view file is added under `DSKit/Sources/DSKit/Views`, add or record its exact preview snapshot first:
  - `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png`
- If a new screen file is added under `DSKitExplorer/Screens`, add or record at least one screen snapshot first:
  - `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/<Screen>.snapshot.png`
- The script reads view source comments, snapshot images in `DSKitTests/__Snapshots__/DSKitTests`, screen snapshots in `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`, and direct usage references in `DSKitExplorer/Screens`.
- Run it after API/visual changes in `DSKit/Sources/DSKit/Views` or snapshot-backed screen changes in `DSKitExplorer/Screens`.
- Do not hand-edit generated pages under `Content/Views/`, `Content/Screens/`, or generated frames under `Content/Screens/Frames/`; change source comments, `Testable_*` examples, snapshots, or the generator.
- After generation, validate that:
  - every `DSKit/Sources/DSKit/Views/*.swift` file has `Content/Views/<Component>.md`
  - every component page has `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png`
  - every generated screen page has at least one snapshot in `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`
  - every generated screen frame in `Content/Screens/Frames` points to an existing snapshot PNG
  - relative links resolve locally

## Running on CLI and automation

- `fastlane/Scanfile` defines shared scan defaults for DSKitExplorer:
  - scheme `DSKitExplorer`
  - device `iPhone 17 Pro`
  - testplan `DSKitExplorer`
- If CoreSimulator is unstable, follow the same `xcodebuild` command from a shell with full access.

## Golden maintenance policy

- Snapshot goldens live under `DSKitTests/__Snapshots__/DSKitTests` and `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`.
- Update goldens only with intended visual changes; otherwise report and fix underlying nondeterminism.
- Component preview snapshots are documentation inputs. If a new DSKit view is added, add an exact `<Component>.snapshot.png` golden before regenerating docs.
