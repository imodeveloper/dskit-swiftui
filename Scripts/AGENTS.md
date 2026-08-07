# Agent Instructions

## Purpose
- Tooling scripts for documentation or release workflows.

## Key Script
- `documentation_generator.sh`: generates `Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Content/Screens.md`, `Content/Screens/*.md`, `Content/Screens/Frames/*.framed.png`, and `Content/Screens/Groups/*.strip.png` from DSKit view source, DSKitExplorer screen source, snapshot images, and usage references.
- `agent_memory_audit.sh`: validates the compact memory index, topic metadata
  and size limits, retired journal paths, personal paths, and credential-like
  files after memory/routing changes.
- The generator requires one exact preview image per view file: `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png`.
- The generator requires at least one preview image per screen page: `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/<Screen>.snapshot.png` or numbered variants such as `<Screen>_0.snapshot.png`.
- Screen frame PNGs are generated from the source snapshot PNGs; do not hand-edit the files under `Content/Screens/Frames/`.
- Screen catalog strip PNGs are generated from the frame PNGs; do not hand-edit the files under `Content/Screens/Groups/`.
- The Python generator requires Pillow to build the flattened screen frame PNGs.

## Pitfalls
- Script expects component snapshots under `DSKitTests/__Snapshots__/DSKitTests/` and screen snapshots under `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/`.
- Keep paths relative when running from `Scripts/`.
- Keep output deterministic; generated docs should not contain local absolute paths.
