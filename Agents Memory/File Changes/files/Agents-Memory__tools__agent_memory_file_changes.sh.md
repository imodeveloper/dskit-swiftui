# Agents Memory/tools/agent_memory_file_changes.sh

- source_path: `Agents Memory/tools/agent_memory_file_changes.sh`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Commit generated DSKit component and screen documentation without making per-file memory for every generated Markdown page.

#### Change Summary
Added `Content/Views/*`, `Content/Screens.md`, and `Content/Screens/*` to the helper's ignored generated-documentation paths, alongside the existing generated index exclusions. Later in the same pending commit, added `DSKitExplorer/Assets.xcassets/Generated Web Images/*` so generated asset-catalog image-set metadata is treated like snapshots instead of hand-authored source.

#### Rationale
The docs refactor introduced many generated Markdown files and generated image assets. Treating generated component pages, screen pages, or one `Contents.json` per generated image set as meaningful hand-maintained files would make memory checks noisy and misleading.

#### Invariants
Keep generated docs, snapshots, and generated web-image asset outputs excluded from file-change memory. Continue tracking source scripts, routing docs, README changes, screen source, DSKit source, and other hand-maintained files.

#### Tests Or Evidence
Re-ran `Agents Memory/tools/agent_memory_file_changes.sh` with generated docs staged and confirmed generated Content docs were ignored while hand-maintained files still required memory. Re-ran the helper against the local-image migration and confirmed generated web-image `Contents.json` files were ignored while DSKit source, Explorer source, and screen source still required memory.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `Content/Screens.md`, `Content/Screens/*.md`, `DSKitExplorer/Assets.xcassets/Generated Web Images`, `Scripts/generate_view_docs.py`, `AGENTS.md`.

#### Follow-up Risks
If other generated documentation or generated asset directories are added, extend the ignore list with the same narrow path-specific approach.

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
