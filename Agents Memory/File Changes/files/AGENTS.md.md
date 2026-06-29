# AGENTS.md

- source_path: `AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Refactor DSKit component documentation into generated repo-native Markdown and keep future agents oriented to the new generated outputs.

#### Change Summary
Expanded the generated documentation list from the single `Content/Views.md` file to include `Content/Views/*.md` per-component pages and `Content/Views/UsageIndex.md`.

#### Rationale
The docs generator now writes an index plus component pages and an Explorer usage map. The top-level agent guide needs to name the full generated surface so agents do not hand-edit generated Markdown or miss the usage index.

#### Invariants
Keep generated documentation listed as generated. Preserve the rule that generated docs are refreshed through `Scripts/documentation_generator.sh`.

#### Tests Or Evidence
Ran the documentation generator, generated-link validation, and a DSKitExplorer build on the available `iPhone 17 Pro, OS=26.5` simulator destination.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Scripts/documentation_generator.sh`, `Scripts/generate_view_docs.py`.

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
