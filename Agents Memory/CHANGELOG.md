# Changelog

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
