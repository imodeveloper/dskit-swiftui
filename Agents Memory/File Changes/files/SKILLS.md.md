# SKILLS.md

- source_path: `SKILLS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Review docs for stale paths and outdated validation commands.

#### Change Summary
Updated the DSKitExplorer build skill to use repo-relative project paths, the current documented iPhone 17 Pro simulator target, and the `../imodeveloperlab` workspace reference.

#### Rationale
The previous command used an old temp checkout path and iOS 26.1 runtime, which made the skill misleading.

#### Invariants
Keep commands repo-relative. If the exact simulator runtime is unavailable, record the actual runtime used in validation notes.

#### Tests Or Evidence
Ran stale-term scans, Markdown link validation, and `git diff --check`.

#### Related Files
`docs/WORKFLOWS.md`, `AGENTS.md`.

#### Follow-up Risks
Simulator OS availability is local-machine dependent.
