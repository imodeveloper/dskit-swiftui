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

## How to read this repo
- Start with `README.md` for public product positioning, then use this file for agent rules and repo routing.
- Use `docs/WORKFLOWS.md`, `docs/QUALITY.md`, and `docs/PLANS.md` for validation, testing, and current work shape.
- For DSKit component work:
  - read `DSKit/AGENTS.md`
  - read the target file under `DSKit/Sources/DSKit/Views`
  - read the matching generated page under `Content/Views/<Component>.md` for examples, snapshots, and Explorer references
  - search `Agents Memory/File Changes/files` for the repo-relative file path before editing meaningful tracked files
- For DSKitExplorer screen work:
  - read `DSKitExplorer/AGENTS.md`
  - read the target file under `DSKitExplorer/Screens`
  - read the matching generated page under `Content/Screens/<Screen>.md` for snapshot previews and component references
  - check `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests` before changing visual output
- For snapshot or test work, read the matching subscope guide first: `DSKitTests/AGENTS.md` or `DSKitExplorerTests/AGENTS.md`.
- Treat generated Markdown as output. Change Swift source comments, testable examples, snapshots, or the generator, then regenerate docs.

## Agents Memory
- Canonical memory/reference folder:
  - `Agents Memory/`
- Keep architecture notes, analysis docs, and performance audits there.
- Current key references:
  - `Agents Memory/ARCHITECTURE.md`
  - `Agents Memory/PROJECT_ANALYSIS.md`
  - `Agents Memory/File Changes/README.md`
  - `Agents Memory/CHANGELOG.md` (legacy chronological memory; do not scan for normal file-scoped work)

### File Change Memory
- Use `Agents Memory/File Changes/` as the primary required memory for meaningful source/config/doc changes.
- Each source path has one memory file under `Agents Memory/File Changes/files/`.
- Each per-file memory file is capped at 300 lines and keeps the most recent entries at the top.
- Before editing a meaningful tracked file, search the file-change memory for that repo-relative path:
  - `rg '<repo-relative-path>' 'Agents Memory/File Changes/files'`
- Before commit + push, create or update per-file memory for meaningful source/config/doc changes.
- Use the helper script for staged changes:
  - `Agents\ Memory/tools/agent_memory_file_changes.sh --check`
  - `Agents\ Memory/tools/agent_memory_file_changes.sh`
- Do not create file-change memory for generated docs, snapshots, build outputs, vendor checkouts, `.DS_Store`, or pure formatting-only churn unless the change intentionally documents behavior.

## Commit/Push Memory Rule
- Before every commit + push, run the file-change memory helper and fill the generated entries with real rationale.
- `Agents Memory/CHANGELOG.md` is legacy chronological memory. Do not append to it for normal file-scoped changes unless a release/global summary is explicitly useful.

## Agent-Oriented Comment Policy
- Add comments only when they preserve rationale the next agent needs: invariants, design-system contracts, snapshot determinism, integration constraints, or prior regression context.
- Keep comments durable and implementation-focused.
- Do not add comments that merely narrate the code or say an agent/person changed it.

## Project map
- DSKit library: `DSKit/Sources/DSKit`
- Demo catalog app: `DSKitExplorer/`
- Snapshot test surfaces:
  - Component goldens in `DSKitTests/__Snapshots__/DSKitTests`
  - Screen goldens in `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`
- Generated documentation: `Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Content/Screens.md`, and `Content/Screens/*.md`
- Determinism-sensitive tooling: `Scripts/documentation_generator.sh`
- Workspace integration: this package is consumed by `../imodeveloperlab/Workspace.xcworkspace`.

## Documentation generation
- Canonical command:
  - `cd Scripts`
  - `./documentation_generator.sh`
- Generated outputs:
  - `Content/Views.md`
  - `Content/Views/*.md`
  - `Content/Views/UsageIndex.md`
  - `Content/Screens.md`
  - `Content/Screens/*.md`
- Generator inputs:
  - DSKit view source: `DSKit/Sources/DSKit/Views/*.swift`
  - component docs and examples: source comments and `Testable_*` structs in view files
  - component previews: `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png`
  - Explorer usage: direct word-boundary references in `DSKitExplorer/Screens/*.swift`
  - screen source: `DSKitExplorer/Screens/*.swift` plus supported playground screens in `DSKitExplorer/ScreenView.swift`
  - screen previews: `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/<Screen>.snapshot.png` or numbered variants such as `<Screen>_0.snapshot.png`
- The generator is intentionally strict:
  - every `DSKit/Sources/DSKit/Views/*.swift` file needs a matching component page and exact component snapshot
  - every generated screen page needs at least one matching screen snapshot
  - generated links must stay relative and must not contain local absolute paths
- After changing docs generation, run the generator and a local link/coverage check. After changing component preview snapshots, also run the focused component preview snapshot test.

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
- Regenerate generated component and screen docs after view, screen, or snapshot changes:
  - `cd Scripts`
  - `./documentation_generator.sh`
