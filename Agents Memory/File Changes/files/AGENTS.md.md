# AGENTS.md

- source_path: `AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Refactor DSKit documentation into generated repo-native Markdown and keep future agents oriented to the repo.

#### Change Summary
Added a repo read path, documented generated component and screen docs, listed generator inputs/outputs, and described strict snapshot/link requirements.

#### Rationale
The top-level guide is the handoff point for future agents. It needs to explain where to start, which docs are generated, and how to refresh them safely.

#### Invariants
Keep generated documentation listed as generated. Preserve the rule that generated docs are refreshed through `Scripts/documentation_generator.sh`, not hand-edited.

#### Tests Or Evidence
Ran the documentation generator, generated coverage/link validation across 155 Markdown files, and the focused component preview snapshot test.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Content/Screens.md`, `Content/Screens/*.md`, `Scripts/generate_view_docs.py`.

#### Follow-up Risks
If future generated outputs are added, update this guide and the memory helper exclusions together.

### 2026-05-18 21:39:14 EEST (`pending`)

- task_or_issue: `agent-file-memory-workflow`

#### Request
Make per-file memory the primary agent handoff and stop relying on the global changelog for normal DSKit work.

#### Change Summary
Added rules for one bounded memory file per source path, newest entries first, capped at 300 lines. Removed `INDEX.md` from the workflow, demoted `CHANGELOG.md` to legacy/global-summary use, and made the helper script the commit memory gate.

#### Rationale
DSKit has file-local design-system invariants and snapshot constraints. Agents need scoped memory tied to the component or script they are editing rather than a growing global timeline.

#### Invariants
Keep file-change memory as the required pre-commit memory path. Keep changelog usage optional and global only. Do not let this guide become a historical log.

#### Tests Or Evidence
Generated the bounded memory file through the helper and validated script syntax/check behavior after the workflow change.

#### Related Files
`Agents Memory/README.md`, `Agents Memory/File Changes/README.md`, `Agents Memory/File Changes/files/`, `Agents Memory/tools/agent_memory_file_changes.sh`.

#### Follow-up Risks
Subscope guides may still mention older commit conventions and should be updated when touched.
