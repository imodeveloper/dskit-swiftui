# Agent Instructions

This repo is treated as an agent-first workspace: `AGENTS.md` is a map, not the full manual.

## Read first (30–60 seconds)
- `Agents Memory/ARCHITECTURE.md`
- `Agents Memory/PROJECT_ANALYSIS.md`
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

## Agents Memory
- Canonical memory/reference folder:
  - `Agents Memory/`
- Keep architecture notes, analysis docs, and performance audits there.
- Current key references:
  - `Agents Memory/ARCHITECTURE.md`
  - `Agents Memory/PROJECT_ANALYSIS.md`
  - `Agents Memory/CHANGELOG.md`

## Commit/Push Changelog Rule
- Before every commit + push, update `Agents Memory/CHANGELOG.md`.
- Each entry must include:
  - `Request`: what was asked.
  - `Done`: what was implemented.

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
- Primary simulator: `platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2`
- Bundle ID: `dskit.app.DSKitExplorer.com`
- Snapshot harness:
  - Keep visual tests stable and deterministic
  - Preserve local test fixtures used by image snapshots
  - Update goldens only when behavior is intentionally changed

## List Virtualization Pitfall
- Do not wrap full `DSSection` content in a `VStack` when the content contains many rows (`ForEach`) intended for `List` virtualization.
- Wrapping all rows in one container can collapse the section into a single giant list cell, causing freeze/memory spikes in consuming apps.
- Preserve native `Section { content() }` row structure for large feeds.

## DSList Spacing Contract
- `DSList(sectionSpacing: ...)` controls spacing between logical sections.
- `.dsSpacing(...)` on `DSSection` controls spacing between rows inside that section.
- Do not treat `.dsSpacing(...)` as a substitute for list-level section spacing.
- DSKit intentionally zeroes native SwiftUI `List` section spacing and owns spacing through DSKit row/section insets.
- If a header is implemented as its own `DSSection`, mark it with `.dsSectionRole(.header)` so list `sectionSpacing` does not leak into the header-to-content gap.
- Use `DSList(sectionHeaderSpacing: ...)` for the gap between a header section and the rows it introduces.
- `DSList(exactSectionHeaderRowHeight: ...)` is opt-in exact header-row sizing:
  - use it only when the rendered `List` header row must match a fixed height exactly
  - when enabled, DSKit applies `defaultMinListRowHeight = 0` so SwiftUI `List` does not inflate the row height
- Keep the default path unchanged for screens that do not need exact header-row sizing.

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
- `DSAppearance` is the source of theme, spacing, typography, and semantic color tokens.
- Spacing system uses `DSSpatialToken` through `appearance.spacing` and `appearance.padding`.
- Typography system uses `DSTypographyToken`, resolved through `DSText` via `dsTextStyle(...)`.
- Colors are exposed through `DSColorToken` and resolved against `DSSurfaceStyle` through `appearance.colors`.

## File Header Rule
- Never use `Created by Codex` in source file headers.
- Use `Created by Ivan Borinschi` instead when a created-by header is present.

## Quick command
- Build DSKitExplorer:
  - `/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2' build`

## Run (CLI)
- Install: `xcrun simctl install <device-udid> <path-to-app>`
- Launch: `xcrun simctl launch <device-udid> dskit.app.DSKitExplorer.com`

## Lint
- SwiftLint runs via Xcode build phases. To run manually:
  - `cd .`
  - `swiftlint lint --config swiftlint.yml`

## Quick workflow
- Regenerate `Content/Views.md` after view or snapshot changes:
  - `cd Scripts`
  - `./documentation_generator.sh`
