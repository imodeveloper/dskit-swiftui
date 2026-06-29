# Scripts/AGENTS.md

- source_path: `Scripts/AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Update script-area guidance after replacing the documentation generator implementation.

#### Change Summary
Described `documentation_generator.sh` as the entrypoint that now generates the component index, per-component Markdown pages, and Explorer usage index from Swift view sources, snapshots, and Explorer screen usage.

#### Rationale
Future agents editing scripts need to understand that the shell script is now a wrapper around the Python generator and that generated docs must avoid absolute local paths.

#### Invariants
Keep script behavior deterministic and repo-relative. Keep generated Markdown derived from source files, snapshots, and `DSKitExplorer/Screens`.

#### Tests Or Evidence
Ran the generator and generated docs validation after updating the script guide.

#### Related Files
`Scripts/documentation_generator.sh`, `Scripts/generate_view_docs.py`, `Content/Views.md`, `Content/Views/UsageIndex.md`.

#### Follow-up Risks
If new generator inputs are added, update this script guide and the active workflow docs.
