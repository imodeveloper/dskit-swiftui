# Agents Memory/README.md

- source_path: `Agents Memory/README.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Remove stale path details while reviewing repo documentation.

#### Change Summary
Replaced a personal absolute `AGENTS.md` path with the repo-relative `AGENTS.md` reference.

#### Rationale
Repository memory should avoid personal absolute paths and remain portable across worktrees.

#### Invariants
Keep this file as a concise memory folder index. Do not turn it into a changelog.

#### Tests Or Evidence
Ran stale-term scans, Markdown validation, and `git diff --check`.

#### Related Files
`AGENTS.md`, `Agents Memory/File Changes/README.md`.

#### Follow-up Risks
If memory folders move, update this index and the top-level agent guide together.

### 2026-05-18 21:39:14 EEST (`pending`)

- task_or_issue: `agent-file-memory-workflow`

#### Request
Make the DSKit memory index point agents to bounded per-file memory first.

#### Change Summary
Listed `File Changes/README.md` and `File Changes/files/` as the primary file-scoped memory entrypoints and marked `CHANGELOG.md` as legacy chronological memory.

#### Rationale
The README is the memory folder index. It needs to prevent agents from treating the large changelog as the default context source.

#### Invariants
Keep this README as a short index. Detailed schema and workflow rules belong in `File Changes/README.md` and `AGENTS.md`.

#### Tests Or Evidence
Generated this memory file through the helper and confirmed direct `rg` lookup in `File Changes/files/` finds the bounded per-file memory.

#### Related Files
`AGENTS.md`, `Agents Memory/File Changes/README.md`, `Agents Memory/File Changes/files/`.

#### Follow-up Risks
If new memory folders are added, keep the README concise and avoid turning it into a changelog replacement.
