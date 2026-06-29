# DSKit Agent-Friendly Component Docs

## Goal
Refactor component documentation into generated, repo-native Markdown so people and agents can find DSKit views, examples, required preview images, source files, and DSKitExplorer usages without relying on the retired website.

## Scope / Files
- Update `Scripts/documentation_generator.sh` and its helper generator.
- Generate `Content/Views.md`, `Content/Views/*.md`, and `Content/Views/UsageIndex.md`.
- Generate `Content/Screens.md` and `Content/Screens/*.md` with snapshot previews for DSKitExplorer screens.
- Update README and local workflow notes to point at the generated docs.

## Constraints
- Do not modify DSKit source behavior.
- Preserve existing uncommitted Swift source and Explorer screen changes.
- Keep generated Markdown deterministic and free of local absolute paths.

## Exit Criteria
- Every Swift file in `DSKit/Sources/DSKit/Views` has a generated component page.
- Component pages include source links, examples when present, required preview images, curated Explorer usage, and related component links.
- Every Swift file in `DSKit/Sources/DSKit/Views` has an exact preview image at `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png`.
- `Content/Views.md` works as the visual component table of contents and `UsageIndex.md` is exhaustive for `DSKitExplorer/Screens`.
- Every `DSKitExplorer/Screens/*.swift` screen has a generated page with at least one snapshot preview, plus source links and detected DSKit view references.
- README points at the repo-native component docs.

## Validation Done
- `cd Scripts && ./documentation_generator.sh` generated 45 component pages plus `Content/Views.md` and `Content/Views/UsageIndex.md`.
- `Content/Views.md` renders a complete visual component catalog with inline preview thumbnails.
- `SNAPSHOT_RECORD=1 xcodebuild ... -only-testing:DSKitTests/DSKitTests/testGeneratedComponentPreviewSnapshots test` recorded the 22 missing exact preview images and passed.
- `cd Scripts && ./documentation_generator.sh` generated 68 screen pages plus `Content/Screens.md` from DSKitExplorer screen source and screen snapshots.
- Local link/coverage validation confirmed 45 view pages, 45 exact component preview images, 68 screen pages, 68 screen pages with at least one snapshot preview, expected catalog sections, and zero broken checked relative links.
- The documented `iPhone 17 Pro, OS=26.2` destination was unavailable locally; `xcodebuild -project DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5' build` succeeded.
