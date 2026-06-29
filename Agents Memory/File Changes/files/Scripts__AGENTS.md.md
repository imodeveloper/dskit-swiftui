# Scripts/AGENTS.md

- source_path: `Scripts/AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Update script-area guidance after expanding the documentation generator.

#### Change Summary
Described `documentation_generator.sh` as the entrypoint that now generates component docs, screen docs, and the Explorer usage index from Swift source, snapshots, and usage references.

#### Rationale
Future agents editing scripts need to understand that the shell script is now a wrapper around the Python generator and that generated docs must avoid absolute local paths.

#### Invariants
Keep script behavior deterministic and repo-relative. Keep generated Markdown derived from source files, snapshots, and `DSKitExplorer/Screens`.

#### Tests Or Evidence
Ran the generator and Markdown coverage/link validation after updating the script guide.

#### Related Files
`Scripts/documentation_generator.sh`, `Scripts/generate_view_docs.py`, `Content/Views.md`, `Content/Screens.md`, `Content/Views/UsageIndex.md`.

#### Follow-up Risks
If new generator inputs are added, update this script guide and the active workflow docs.
