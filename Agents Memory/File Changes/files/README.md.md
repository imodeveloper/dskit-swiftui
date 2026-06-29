# README.md

- source_path: `README.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:46:49 EEST (`pending`)

- task_or_issue: `remove-uikit-version-note`

#### Request
Remove the rendered README note that points readers to the old UIKit DSKit repository.

#### Change Summary
Removed the `[!Note]` block under `Get Started` that linked to the UIKit version. The README now flows directly from `Get Started` into Swift Package Manager setup.

#### Rationale
The SwiftUI package README should keep attention on the current DSKit SwiftUI installation path and avoid sending readers to the retired UIKit repo.

#### Invariants
Keep README links focused on current repo-native SwiftUI documentation and local generated docs. Do not reintroduce website or legacy UIKit repository routing unless the README explicitly needs migration context.

#### Tests Or Evidence
Verified the only targeted `UIKit Version` text was in `README.md`.

#### Related Files
`README.md`.

#### Follow-up Risks
If migration guidance is needed later, put it in a dedicated migration note rather than the main getting-started path.

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Update the main README so repo-native Markdown is the canonical entrypoint for DSKit docs.

#### Change Summary
Updated platform/support copy, SPM URL, setup guidance, generated component and screen documentation links, DSKitExplorer run guidance, and contribution notes. The README now points readers at `Content/Views.md`, `Content/Screens.md`, `UsageIndex.md`, Layout, Appearance, and workflow docs.

#### Rationale
The retired website should no longer be the documentation path. Developers and agents need the README to lead directly to generated repo docs and current local workflows.

#### Invariants
Keep README documentation links relative and local. Keep platform wording aligned with `Package.swift` and Xcode project deployment targets.

#### Tests Or Evidence
Validated local relative links across 155 Markdown files, ran generated docs coverage checks, and reran the focused component preview snapshot test.

#### Related Files
`Content/Views.md`, `Content/Screens.md`, `Content/Views/UsageIndex.md`, `Content/Layout-in-DSKit.md`, `Content/Appearance-in-DSKit.md`, `docs/WORKFLOWS.md`.

#### Follow-up Risks
If package deployment targets change, update the README, architecture memory, and workflow docs together.
