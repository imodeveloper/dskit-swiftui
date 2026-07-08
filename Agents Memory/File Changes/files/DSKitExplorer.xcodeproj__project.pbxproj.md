# DSKitExplorer.xcodeproj/project.pbxproj

- source_path: `DSKitExplorer.xcodeproj/project.pbxproj`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-08 21:49 EEST (`monitor-release-variant-configs`)

- task_or_issue: `Monitor Release-Dev validation could not build DSKit test dependencies`
- change_id: `monitor-release-variant-configs`

#### Request
Unblock Monitor dev/prod release delivery after validation exposed DSKit project configuration gaps.

#### Change Summary
Added `Release-Dev` and `Release-Prod` build configurations across the DSKit project, app, library, and test targets, and enabled testability for the DSKit library in those release variants.

#### Rationale
The Monitor workspace consumes DSKit as a project dependency and validates Monitor release variants. DSKit must expose matching build configurations so package dependencies such as Nuke/NukeUI resolve correctly and tests can import DSKit under Release-Dev/Release-Prod.

#### Invariants
Do not change DSKit source behavior or generated documentation for this config-only fix. Keep standard Release behavior intact.

#### Tests Or Evidence
`xcodebuild -project DSKitExplorer.xcodeproj -target DSKit -configuration Release-Dev -showBuildSettings` and the Release-Prod equivalent confirmed `ENABLE_TESTABILITY = YES`. Monitor `bundle exec fastlane ios monitor_md_validation_gate variant:dev` passed after the configuration fix.

#### Related Files
`../imodeveloperlab/fastlane/Fastfile`.

#### Follow-up Risks
If new Monitor release variants are added, DSKit workspace configs need matching names before Monitor validation/delivery can consume them.
