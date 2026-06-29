# DSKit Agent-Friendly Component Docs

## Goal
Refactor component documentation into generated, repo-native Markdown so people and agents can find DSKit views, examples, snapshots, source files, and DSKitExplorer usages without relying on the retired website.

## Scope / Files
- Update `Scripts/documentation_generator.sh` and its helper generator.
- Generate `Content/Views.md`, `Content/Views/*.md`, and `Content/Views/UsageIndex.md`.
- Update README and local workflow notes to point at the generated docs.

## Constraints
- Do not modify DSKit source behavior.
- Preserve existing uncommitted Swift source and Explorer screen changes.
- Keep generated Markdown deterministic and free of local absolute paths.

## Exit Criteria
- Every Swift file in `DSKit/Sources/DSKit/Views` has a generated component page.
- Component pages include source links, examples when present, snapshots when present, curated Explorer usage, and related component links.
- `Content/Views.md` works as the table of contents and `UsageIndex.md` is exhaustive for `DSKitExplorer/Screens`.
- README points at the repo-native component docs.

## Validation Done
- `cd Scripts && ./documentation_generator.sh` generated 45 component pages plus `Content/Views.md` and `Content/Views/UsageIndex.md`.
- Local link/coverage validation confirmed every `DSKit/Sources/DSKit/Views/*.swift` file has a generated page and all generated relative links resolve.
- The documented `iPhone 17 Pro, OS=26.2` destination was unavailable locally; `xcodebuild -project DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5' build` succeeded.
