# README.md

- source_path: `README.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Update the main README so repo-native Markdown is the canonical entrypoint for DSKit component docs.

#### Change Summary
Pointed component documentation at `Content/Views.md`, added examples of per-component pages, linked the Explorer usage index, kept layout and appearance docs linked, and corrected the pull request link to the SwiftUI repository.

#### Rationale
The retired website should no longer be the documentation path. Developers and agents need the README to lead directly to generated repo docs.

#### Invariants
Keep README documentation links relative and local. Preserve existing Layout and Appearance links unless those docs are deliberately refactored later.

#### Tests Or Evidence
Validated local relative links and ran the generated docs validation script plus DSKitExplorer build.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Content/Layout-in-DSKit.md`, `Content/Appearance-in-DSKit.md`.

#### Follow-up Risks
If README examples name specific component pages, keep those pages generated from matching Swift view filenames.
