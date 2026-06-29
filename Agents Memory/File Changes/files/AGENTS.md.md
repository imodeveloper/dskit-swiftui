# AGENTS.md

- source_path: `AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 17:04:12 EEST (`pending`)

- task_or_issue: `iphone-framed-screen-previews`

#### Request
Document that screen preview frame SVGs are generated alongside screen docs.

#### Change Summary
Added `Content/Screens/Frames/*.framed.svg` to generated documentation outputs and noted that screen preview frames are generated wrappers around source screen snapshots.

#### Rationale
Top-level agent routing should make generated frame assets discoverable without implying they are hand-maintained documentation.

#### Invariants
Keep this file concise and directive. Generated docs/assets should be listed here only as routing information, not as implementation detail.

#### Tests Or Evidence
Ran the documentation generator and local generated-link/image validation after updating the guide.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/AGENTS.md`, `Scripts/AGENTS.md`.

#### Follow-up Risks
If frame output moves, update the generated output list in the same change as the generator path change.

### 2026-06-29 16:09:19 EEST (`pending`)

- task_or_issue: `screen-construction-deep-dive`

#### Request
Deep dive into DSKitExplorer and Monitor screen construction, then add the result to the agent guide and README.

#### Change Summary
Added `Content/Screen-Construction.md` to the read-first list and the repo reading flow for agents translating DSKitExplorer examples into production Monitor screens.

#### Rationale
The top-level guide should route future agents to the new hand-maintained screen-construction analysis before they compare this repo with `../imodeveloperlab`.

#### Invariants
Keep this file concise and directive. Do not duplicate the full screen-construction guidance here; link to the dedicated Content page.

#### Tests Or Evidence
Validated Markdown links for the changed docs and ran whitespace validation on the changed documentation files.

#### Related Files
`Content/Screen-Construction.md`, `README.md`, `Content/AGENTS.md`.

#### Follow-up Risks
If the screen-construction page is renamed, update this routing entry and the README in the same change.

### 2026-06-29 15:49:34 EEST (`pending`)

- task_or_issue: `move-root-docs-under-content`

#### Request
Move the root `docs/` folder into `Content/` and update references.

#### Change Summary
Updated the top-level agent read path and workflow references from root `docs/...` to `Content/docs/...`.

#### Rationale
Agents should no longer look for a root `docs/` folder after the documentation tree is consolidated under `Content/`.

#### Invariants
Keep this file as the top-level routing guide. Any moved documentation entrypoint must be updated here in the same change.

#### Tests Or Evidence
Validated local Markdown links, ran staged whitespace validation, and ran the file-change memory check.

#### Related Files
`Content/docs/WORKFLOWS.md`, `Content/docs/QUALITY.md`, `Content/docs/PLANS.md`, `Content/docs/design-docs/ds-wrapper-principles.md`.

#### Follow-up Risks
If `Content/docs/` is renamed, update both this guide and `Agents Memory/ARCHITECTURE.md`.

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
