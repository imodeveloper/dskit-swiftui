# Reusable Screen Pattern Components

## Goal

Extract stable repeated DSKitExplorer screen compositions into reusable DSKit components with snapshot-backed documentation.

## Scope / Files

- Add DSKit view components for repeated label/value summary rows and centered status/empty-state messaging.
- Refactor repeated Explorer screen-local summary and success-state compositions to use the new DSKit views.
- Add component snapshot assertions and generated component documentation.

## Constraints

- Keep domain data and screen-specific decisions in Explorer screens.
- Preserve deterministic snapshot fixtures and local image asset references.
- Regenerate generated docs from source and snapshots; do not hand-edit generated pages.

## Exit Criteria

- New DSKit views have exact component snapshots.
- `Content/Views.md`, per-component pages, and usage index include the new views.
- Refactored screens still build and remain snapshot-compatible.
- File-change memory is updated before commit.

## Validation Done

- `xcodebuild -project DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5' -only-testing:DSKitTests/DSKitTests/testDSKeyValueRow -only-testing:DSKitTests/DSKitTests/testDSPriceSummaryList -only-testing:DSKitTests/DSKitTests/testDSStatusView test`
- `xcodebuild -project DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5' -only-testing:DSKitExplorerTests/DSKitExplorerTests/testCartScreen1 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testCartScreen2 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testCartScreen3 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testCartScreen4 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testCartScreen5 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testOrder1 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testOrder2 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testOrder3 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testOrder4 -only-testing:DSKitExplorerTests/DSKitExplorerTests/testShipping2 test`
- `cd Scripts && ./documentation_generator.sh`
- `python3 -m py_compile Scripts/generate_view_docs.py`
- `git diff --check`
- `xcodebuild -project DSKitExplorer.xcodeproj -scheme DSKitExplorer -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5' -only-testing:DSKitTests/DSKitTests/testEveryDSKitViewHasSnapshotCoverageAndDocumentationPreview test`
