# Agents Memory/tools/agent_memory_file_changes.sh

- source_path: `Agents Memory/tools/agent_memory_file_changes.sh`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-05-18 21:39:14 EEST (`pending`)

- task_or_issue: `agent-file-memory-workflow`

#### Request
Support one per-file memory file per source path, newest entries on top, capped at 300 lines.

#### Change Summary
Changed the helper from dated per-commit records to stable files under `Agents Memory/File Changes/files/`. It now prepends new entries, trims each file to 300 lines, ignores `CHANGELOG.md`, handles empty changed-file lists under `set -u`, and no longer creates or updates an index.

#### Rationale
Per-file bounded memory lets agents load only the history relevant to files they touch. It avoids unbounded global changelog growth and avoids many scattered dated records for the same source file.

#### Invariants
Keep one memory file per source path. Keep newest entries first. Keep the 300-line cap. Do not require changelog or index updates for normal file-scoped work.

#### Tests Or Evidence
Validated with `bash -n`, staged-file generation, empty staged-file `--check`, missing-memory `--check` failure, and ignored build-noise checks.

#### Related Files
`Agents Memory/File Changes/README.md`, `Agents Memory/File Changes/files/`, `AGENTS.md`.

#### Follow-up Risks
The 300-line trim is simple `head` truncation and can cut an old entry mid-section; this is acceptable because only newest context is guaranteed.
