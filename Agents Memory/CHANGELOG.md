# Changelog

## 2026-03-23 (Dotted Divider Style)

### Request
- Add a DSKit-backed dotted divider style so the Monitor hourly brief can render centered dot separators instead of line dividers.
- Keep the existing divider behavior as the default and prepare the repo changes for commit/push.

### Done
- Extended `DSDivider` with a backward-compatible `style` API.
- Added `DSDividerStyle.line` to preserve the existing default line rendering.
- Added `DSDividerStyle.dots(number:size:spacing:alignment:)` plus `DSDividerAlignment` for centered or edge-aligned dot separators.
- Kept the default `DSDivider()` behavior unchanged while enabling dotted separators for consuming apps such as Monitor.

## 2026-03-17

### Request
- Raise `dskit-swiftui` to iOS 17.6 and selectively migrate isolated DSKitExplorer screen models from `ObservableObject` to Observation.

### Done
- Raised the DSKit Swift package iOS floor from 15 to 17 and normalized `DSKitExplorer` deployment targets to iOS 17.6.
- Updated compatibility docs and project analysis notes to reflect the new iOS 17.6+ support floor.
- Migrated isolated DSKitExplorer screen-local models to `@Observable` and updated their owning views to Observation-friendly state ownership.
- Kept DSKit runtime helpers such as `KeyboardObserver` and `DSTextFieldValue` on legacy `ObservableObject` semantics.

## 2026-03-05

### Request
- Introduce an `Agents Memory` strategy and move long-lived reference docs (`ARCHITECTURE.md`, `PROJECT_ANALYSIS.md`) there.

### Done
- Moved architecture and project analysis docs to `Agents Memory/`.
- Updated root `AGENTS.md` to reference memory docs in `Agents Memory`.
- Added `Agents Memory/README.md` as the index for memory files.

## 2026-03-05 (DSThread Perf)

### Request
- Improve `DSThread`/grouped article rendering path to reduce minor UI hangs while paginating grouped news in Monitor.

### Done
- Refactored `DSThread` to compute row position by element ID (`firstID/lastID`) instead of `Data.Element` equality checks.
- Removed `Data.Element: Equatable` requirement from `DSThread`, reducing heavy comparisons for large row models.
- Precomputed shared row constants (`headerVerticalPadding`) and reused per row.
- Verified build success with `DSKitExplorer` scheme on iPhone 17 Pro (iOS 26.2).

## 2026-03-05 (AGENTS Path Cleanup)

### Request
- Remove home-directory absolute paths from `dskit-swiftui/AGENTS.md`.

### Done
- Replaced absolute `/Users/ivan.borinschi/Work/dskit-swiftui/...` references with repo-relative paths in `AGENTS.md`.
- Updated memory references, changelog rule path, build command path, lint command path, and scripts workflow path to be repository-local.

## 2026-03-15

### Request
- Commit and push all pending repository changes.

### Done
- Included current DSKit local updates in commit:
  - `DSKit/Sources/DSKit/Views/DSButton.swift`
  - `DSKit/Sources/DSKit/Views/DSSectionHeaderView.swift`
- Updated changelog before commit/push as required.

## 2026-03-17

### Request
- Commit and push all pending repository changes.

### Done
- Included the current DSKit local updates in commit:
  - increased `LightBlueAppearance` corner radius from `5` to `10`
  - documented the `DSSection` virtualization rule to avoid wrapping full row sets in `VStack`/`LazyVStack`
- Updated changelog before commit/push as required.

## 2026-03-22

### Request
- Rename the chips layout from `DSClipsView` to `DSChipsView`, move it into DSKit, document it like other DSKit views, align it with DSKit spacing/style tokens, add more flexible `dsCardStyle` padding, and prepare repository changes for commit/push.

### Done
- Added new `DSChipsView` to `DSKit/Sources/DSKit/Views` as a layout-only wrapping container with `DSSpace`-based horizontal and vertical spacing.
- Added DSKit documentation/source comments, snapshot test coverage hook, generated docs entry, and a `DSChipsView.snapshot.png` golden.
- Fixed the documentation generator to reference `.snapshot.png` assets instead of stale `.1.png` names.
- Extended `dsCardStyle` to support separate `horizontalPadding` and `verticalPadding` while keeping the existing single-padding overload.
- Added repo guidance to avoid `Created by Codex` file headers and to use `Created by Ivan Borinschi` instead.

## 2026-03-22 (Adaptive Remote Image Height)

### Request
- Replace fixed remote image heights with an adaptive DSKit sizing mode that can learn and reuse image aspect ratios for later renders.

### Done
- Added `DSDimension.adaptiveHeight(_:)` and updated `DSSizeModifier` so adaptive-height images are not pinned to a fixed runtime height.
- Extended `DSImageView` remote loading to cache aspect ratios from decoded images and reuse them through exact-image, path-family, and host-level lookups before the next render.
- Kept a fallback default height for first render while allowing later loads to refine the aspect ratio and update the cache.

## 2026-04-01

### Request
- Improve DSKit remote image loading placeholders and prepare current repository changes for commit/push.

### Done
- Updated `DSImageView` remote-image loading states so loading shows a centered `photo` placeholder and failures show `photo.badge.exclamationmark`.
- Made the loading/error placeholder icon scale with the rendered image bounds while remaining relatively smaller on large image surfaces.
- Documented the remote-image placeholder behavior in `DSKit/AGENTS.md`.
