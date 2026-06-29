# DSKitTests/DSKitTests.swift

- source_path: `DSKitTests/DSKitTests.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:59:01 EEST (`pending`)

- task_or_issue: `component-snapshot-doc-coverage-guard`

#### Request
Make sure every DSKit view/component has snapshot test coverage and those snapshots are used in documentation.

#### Change Summary
Added `testEveryDSKitViewHasSnapshotCoverageAndDocumentationPreview()` to enumerate `DSKit/Sources/DSKit/Views/*.swift` and verify each component has an exact snapshot assertion, an exact snapshot PNG, a generated component page, a page preview image, and a preview image reference in `Content/Views.md`.

#### Rationale
The documentation generator already requires snapshot files for generated pages, but the test suite should also fail when a future component is added without an exact snapshot assertion or when docs stop embedding the component snapshot.

#### Invariants
Keep exact component snapshot names aligned to Swift filenames: `<Component>.snapshot.png` and `named: "<Component>"`. Generated component pages and the index must continue to use those exact snapshot files.

#### Tests Or Evidence
Ran the focused Xcode test `DSKitTests/DSKitTests/testEveryDSKitViewHasSnapshotCoverageAndDocumentationPreview`; it passed. Ran a static audit confirming 45 components and no missing assertions, snapshots, pages, page snapshot links, or index snapshot links.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `DSKitTests/__Snapshots__/DSKitTests/*.snapshot.png`, `Scripts/generate_view_docs.py`.

#### Follow-up Risks
If snapshot assertions move out of `DSKitTests.swift`, update this guard so it checks the new source of truth instead of looking for exact names in this file.

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
