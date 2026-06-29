# Agent Instructions

## Purpose
- Tooling scripts for documentation or release workflows.

## Key Script
- `documentation_generator.sh`: generates `Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Content/Screens.md`, and `Content/Screens/*.md` from DSKit view source, DSKitExplorer screen source, snapshot images, and usage references.
- The generator requires one exact preview image per view file: `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png`.
- The generator requires at least one preview image per screen page: `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/<Screen>.snapshot.png` or numbered variants such as `<Screen>_0.snapshot.png`.

## Pitfalls
- Script expects component snapshots under `DSKitTests/__Snapshots__/DSKitTests/` and screen snapshots under `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/`.
- Keep paths relative when running from `Scripts/`.
- Keep output deterministic; generated docs should not contain local absolute paths.
