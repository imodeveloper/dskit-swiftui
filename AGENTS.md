# Agent Instructions

This repo is treated as an agent-first workspace: `AGENTS.md` is a map, not the full manual.

## Read first (30–60 seconds)
- `ARCHITECTURE.md`
- `docs/design-docs/ds-wrapper-principles.md`
- `docs/WORKFLOWS.md`
- `docs/QUALITY.md`
- `docs/PLANS.md`
- Subscope entry points:
  - `DSKit/AGENTS.md`
  - `DSKitExplorer/AGENTS.md`
  - `DSKitTests/AGENTS.md`
  - `DSKitExplorerTests/AGENTS.md`
  - `Scripts/AGENTS.md`
  - `Content/AGENTS.md`

## Project map
- DSKit library: `DSKit/Sources/DSKit`
- Demo catalog app: `DSKitExplorer/`
- Snapshot test surfaces:
  - Component goldens in `DSKitTests/__Snapshots__/DSKitTests`
  - Screen goldens in `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`
- Generated documentation: `Content/Views.md`
- Determinism-sensitive tooling: `Scripts/documentation_generator.sh`
- Workspace integration: this package is consumed by `../imodeveloperlab/Workspace.xcworkspace`.

## Runtime constraints
- Build target: `DSKitExplorer` scheme in `DSKitExplorer.xcodeproj`
- Primary simulator: `platform=iOS Simulator,name=iPhone 17 Pro,OS=26.1`
- Bundle ID: `dskit.app.DSKitExplorer.com`
- Snapshot harness:
  - Keep visual tests stable and deterministic
  - Preserve local test fixtures used by image snapshots
  - Update goldens only when behavior is intentionally changed

## List Virtualization Pitfall
- Do not wrap full `DSSection` content in a `VStack` when the content contains many rows (`ForEach`) intended for `List` virtualization.
- Wrapping all rows in one container can collapse the section into a single giant list cell, causing freeze/memory spikes in consuming apps.
- Preserve native `Section { content() }` row structure for large feeds.

## DSHScroll Margin Keys
- `dsScrollableContentMarginKey` is the inset used by `DSHScroll` for horizontal content alignment.
- `dsContentMarginKey` represents host/container margins and should not be re-applied in `DSHScroll` outer compensation.
- `dsScreenMarginsAlreadyApplied` signals parent ownership of screen margins (notably `DSList`/`DSSection` contexts).
- Stable `DSHScroll` math across standalone, `ScrollView + dsScreen`, and `DSList` is:
  - inner `.padding(.horizontal, scrollableContentMargin)`
  - outer `.padding(.horizontal, -scrollableContentMargin)`

## DSCoverFlow Stability Notes
- Keep `DSCoverFlow` on the UIKit `UIScrollView` bridge path for runtime and previews.
- Avoid ID-only pagination state rewrites that change `currentPage` binding semantics; this previously triggered SwiftUI preview crashes in `FoodHomeScreen1`.
- `DSCoverFlow.height` is the carousel viewport height; when `showPaginationView` is enabled, total view height must also include pagination dot height and its top padding.

## Design tokens reference
- `DSAppearance` is the source of theme, spacing, and typography tokens.
- Spacing system: `DSSpacingSystem` and `DSPaddingSystem` expose `.small/.regular/.medium` scales from `appearance`.
- Typography system: `DSFonts` + `DSTextFontKey`, resolved through `DSText` via `dsTextStyle(...)`.
- Colors and surface tokens are exposed via `DSColorKey` and mapped through `DSViewStyle`/`DSAppearance`.

## Quick command
- Build DSKitExplorer:
  - `/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project /Users/ivan.borinschi/Work/dskit-swiftui/DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.1' build`

## Quick workflow
- Regenerate `Content/Views.md` after view or snapshot changes:
  - `cd /Users/ivan.borinschi/Work/dskit-swiftui/Scripts`
  - `./documentation_generator.sh`
