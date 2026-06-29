# Agent Instructions

## Purpose
- Tooling scripts for documentation or release workflows.

## Key Script
- `documentation_generator.sh`: generates `Content/Views.md`, `Content/Views/*.md`, and `Content/Views/UsageIndex.md` from `DSKit/Sources/DSKit/Views`, snapshot images, and `DSKitExplorer/Screens` usage references.

## Pitfalls
- Script expects snapshots under `DSKitTests/__Snapshots__/DSKitTests/`.
- Keep paths relative when running from `Scripts/`.
- Keep output deterministic; generated docs should not contain local absolute paths.
