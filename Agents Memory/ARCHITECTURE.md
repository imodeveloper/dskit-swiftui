# DSKit Architecture

## 1) Domain map

- `DSKit/`
  - Swift Package product `DSKit`
  - Source zones:
    - `Sources/DSKit/Views`
    - `Sources/DSKit/Modifiers`
    - `Sources/DSKit/Appearances`
    - `Sources/DSKit/Designable`
    - `Sources/DSKit/Fonts`
    - `Sources/DSKit/Helpers`
  - Supports rendering primitives and appearance/tokens used by apps.

- `DSKitExplorer/`
  - SwiftUI demo/catalog app for all DSKit screens.
  - `ScreenKey` and `ScreenView` drive the component/screen surface area.
  - Uses `DSKit` public API as primary consumer.

- `DSKitTests/`
  - Snapshot coverage for individual components.
  - Goldens represent rendered view contracts.

- `DSKitExplorerTests/`
  - Snapshot coverage for full-screen examples.
  - Uses a shared test plan at `DSKitExplorerTests/DSKitExplorer.xctestplan`.

- `Content/`
  - Human-facing docs and reference images.
  - `Views.md`, `Views/*.md`, `Views/UsageIndex.md`, `Screens.md`, and `Screens/*.md` are generated from source comments, snapshots, and Explorer usage.

- `Scripts/`
  - Automation for documentation generation and consistency tasks.
  - `Scripts/documentation_generator.sh` is the source of truth for the generated screen/component index.

## 2) Data and platform boundaries

- Package-level target:
  - Swift package target: `DSKit`
  - Package platforms: iOS 17+, macOS 12+
  - Xcode project deployment targets: iOS 17.6+, macOS 14.6+
  - External dependencies:
    - `Nuke`
    - `NukeUI`

- App target:
  - `DSKitExplorer.xcodeproj` compiles `DSKitExplorer`
  - Bundled via `DSKitExplorerTests` for coverage validation

## 3) Integration touchpoints

- `../imodeveloperlab/Workspace.xcworkspace` references this repo for `DSKit.framework`.
- Deterministic snapshots are required because downstream apps can rely on both API and visual contracts.

## 4) Where to start for context
- For build/test execution and commands: `Content/docs/WORKFLOWS.md`
- For snapshot and test quality constraints: `Content/docs/QUALITY.md`
- For active work planning and cleanup: `Content/docs/PLANS.md`
- For DS wrapper/token rationale: `Content/docs/design-docs/ds-wrapper-principles.md`
- For generated component references: `Content/Views.md`
- For generated screen references: `Content/Screens.md`
