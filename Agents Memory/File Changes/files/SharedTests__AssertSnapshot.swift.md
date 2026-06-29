# SharedTests/AssertSnapshot.swift

- source_path: `SharedTests/AssertSnapshot.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 17:45:00 EEST (`pending`)

- task_or_issue: `snapshot-tabbar-backgrounds`

#### Request
Fix generated screen previews where native `TabView` tab bars rendered with transparent or glass backgrounds over screen content.

#### Change Summary
Added a screen-snapshot-only `UITabBar` appearance override that installs an opaque tab bar using the active DSKit appearance colors, then restores the previous global tab bar appearance after each snapshot assertion.

#### Rationale
iOS 26 native Liquid Glass tab bars can make static documentation snapshots look like the tab bar is floating over content. The production DSKit appearance path intentionally keeps native behavior, so the deterministic opaque baseline belongs in the test snapshot harness instead of DSKit runtime code.

#### Invariants
Keep the override limited to `.screen` snapshot layouts; component snapshots should not receive global tab bar appearance changes. Always restore any global UIKit appearance proxy state before leaving `assertSnapshot`.

#### Tests Or Evidence
Verified focused DSKitExplorer tabbed screen snapshot tests on `iPhone 17 Pro, OS=26.5` passed after updating affected goldens, ran `Scripts/documentation_generator.sh`, verified generated Markdown/SVG references resolve locally, ran `python3 -m py_compile Scripts/generate_view_docs.py`, and ran `git diff --check` over the touched docs/generator/snapshot files.

#### Related Files
`DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/*.snapshot.png`, `Scripts/generate_view_docs.py`, `Content/Screens.md`, `Content/Screens/*.md`, `Content/Screens/Frames/*.framed.svg`.

#### Follow-up Risks
If future iOS tab bar APIs add more appearance slots, update the snapshot override to capture and restore those slots too.
