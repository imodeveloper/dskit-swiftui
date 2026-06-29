# DSKitTests/DSKitTests.swift

- source_path: `DSKitTests/DSKitTests.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `component-preview-docs`

#### Request
Ensure every DSKit view/component has a preview image for generated documentation.

#### Change Summary
Added `testGeneratedComponentPreviewSnapshots()` and focused `ComponentPreview_*` views for DSKit views that did not already have exact component preview snapshots.

#### Rationale
The documentation generator now requires `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png` for every view file. Missing focused previews needed deterministic snapshot coverage.

#### Invariants
Keep preview views deterministic, local-data-only, and independent of unstaged app state. Use explicit spacing when a preview should not track default spacing changes.

#### Tests Or Evidence
Recorded missing snapshots, then reran `testGeneratedComponentPreviewSnapshots` without record mode on the available iPhone 17 Pro simulator; 1 test passed with 0 failures.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Views.md`, `Content/Views/*.md`, `DSKitTests/__Snapshots__/DSKitTests/*.snapshot.png`.

#### Follow-up Risks
Visual changes to component defaults may require intentional snapshot updates.
