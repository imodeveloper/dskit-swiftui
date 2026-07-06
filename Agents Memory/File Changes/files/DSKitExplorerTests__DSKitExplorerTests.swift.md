# DSKitExplorerTests/DSKitExplorerTests.swift

- source_path: `DSKitExplorerTests/DSKitExplorerTests.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-07 00:25:17 EEST (`pending`)

- task_or_issue: `monitor-reusable-components-dskit-docs`

#### Request
Regenerate DSKitExplorer documentation after adding Monitor-derived reusable permission prompt screens.

#### Change Summary
Added exact screen snapshot assertions for `LocationPermissionScreen`, `NotificationsPermissionScreen`, and `PhotosPermissionScreen`.

#### Rationale
`Scripts/documentation_generator.sh` requires every generated screen page to have at least one matching snapshot. These three screens were exposed in the Explorer catalog but had no baseline snapshots.

#### Invariants
Keep snapshot names exactly aligned with screen filenames so generated screen pages can resolve previews: `<Screen>.snapshot.png`.

#### Tests Or Evidence
Recorded the three baselines, reran the focused Explorer screen snapshot tests, and regenerated screen docs/framed previews successfully.

#### Related Files
`DSKitExplorer/Screens/LocationPermissionScreen.swift`, `NotificationsPermissionScreen.swift`, `PhotosPermissionScreen.swift`, `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/*.snapshot.png`, `Content/Screens/*.md`.

#### Follow-up Risks
Intentional visual changes to permission prompt screens require re-recording these baselines and regenerating screen docs.
