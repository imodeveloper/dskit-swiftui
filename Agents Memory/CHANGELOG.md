# Changelog

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
