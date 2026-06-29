# DSKit/AGENTS.md

- source_path: `DSKit/AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Refresh repo guidance while preserving source behavior.

#### Change Summary
Updated the DSKit subscope guide to refer to Monitor as the downstream consumer through `../imodeveloperlab/Workspace.xcworkspace`.

#### Rationale
The guide still used the older MNews naming. Current agents need the current downstream project name.

#### Invariants
Keep this file focused on DSKit source conventions and pitfalls. Do not add historical notes here.

#### Tests Or Evidence
Ran stale-term scans, Markdown link validation, and `git diff --check`.

#### Related Files
`AGENTS.md`, `Agents Memory/PROJECT_ANALYSIS.md`, `DSKitExplorer/AGENTS.md`.

#### Follow-up Risks
If downstream project naming changes, update top-level and subscope guides together.
