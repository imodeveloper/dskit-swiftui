# Content/docs/WORKFLOWS.md

- source_path: `Content/docs/WORKFLOWS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 20:48:40 EEST (`pending`)

- task_or_issue: `showcase-style-screen-catalog`

#### Request
Keep workflow guidance current after adding generated screen catalog strip previews.

#### Change Summary
Updated the snapshot documentation generation workflow to include screen catalog strips, no-hand-edit guidance for `Content/Screens/Groups`, and validation language for strip assets.

#### Rationale
Agents refreshing docs need to understand that `Screens.md` now depends on generated strip images as well as individual frame images.

#### Invariants
Generated docs, frame assets, and strip assets remain derived from source and snapshots. Do not hand-edit `Content/Screens/Groups`.

#### Tests Or Evidence
Ran `cd Scripts && ./documentation_generator.sh`, local Markdown link/image validation, and `git diff --check`.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Documentation.md`, `Content/Screens/Groups/*.strip.png`.

#### Follow-up Risks
If strip generation changes density or output path, update this workflow guide alongside the generator.

### 2026-06-29 20:25:34 EEST (`pending`)

- task_or_issue: `flatten-screen-frame-previews`

#### Request
Keep workflow guidance current after replacing generated SVG screen frames with flattened PNG frames.

#### Change Summary
Updated the snapshot documentation generation section to say screen frames are rebuilt from snapshot PNGs and noted that Pillow is required for flattened frame generation.

#### Rationale
Workflow docs should make the generator dependency and output model obvious before agents regenerate documentation.

#### Invariants
Generated docs and frame assets remain derived from Swift source and snapshots. Do not hand-edit `Content/Screens/Frames`.

#### Tests Or Evidence
Ran `cd Scripts && ./documentation_generator.sh`, local Markdown link/image validation, and `git diff --check`.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Documentation.md`, `Content/Screens/Frames/*.framed.png`.

#### Follow-up Risks
If the generator moves away from Pillow or frame output changes location, update this workflow guide alongside the generator.

### 2026-06-29 17:25:51 EEST (`pending`)

- task_or_issue: `iphone-framed-screen-previews`

#### Request
Update the workflow guide for generated iPhone-framed screen previews.

#### Change Summary
Added framed screen previews to the documentation generation output list, extended the no-hand-edit rule to `Content/Screens/Frames/`, and added validation that frame SVGs point to existing snapshot PNGs.

#### Rationale
The workflow guide is the command reference agents use before refreshing docs, so it needs to include the new generated frame output surface.

#### Invariants
Keep `Scripts/documentation_generator.sh` as the canonical refresh command. Do not imply generated frame SVGs are hand-maintained assets.

#### Tests Or Evidence
Ran the documentation generator, local generated Markdown/SVG link validation, and whitespace validation after updating the workflow guide.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Documentation.md`, `Content/Screens/Frames/*.framed.svg`.

#### Follow-up Risks
If frame output becomes PNG or another asset type later, update this guide with the generator change.

### 2026-06-29 15:49:34 EEST (`pending`)

- task_or_issue: `move-root-docs-under-content`

#### Request
Move the root `docs/` folder into `Content/` and update references.

#### Change Summary
Moved the workflow guide from `docs/WORKFLOWS.md` to `Content/docs/WORKFLOWS.md`.

#### Rationale
`Content/` is now the repository documentation home, so workflow documentation should live there instead of keeping a second root docs folder.

#### Invariants
Keep this as the canonical build, test, snapshot, and documentation refresh command reference.

#### Tests Or Evidence
Validated local Markdown links, ran staged whitespace validation, and ran the file-change memory check.

#### Related Files
`AGENTS.md`, `README.md`, `Content/CONTRIBUTING.md`, `Content/docs/PLANS.md`.

#### Follow-up Risks
If workflow commands drift, update this guide and the README/contributor links together.

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Refresh workflow documentation for the generated component and screen documentation structure.

#### Change Summary
Updated build commands, simulator guidance, docs generation outputs, component/screen snapshot requirements, and generated-doc validation expectations.

#### Rationale
The workflow previously described stale simulator commands and only part of the generated docs surface. Agents need a reliable docs refresh and validation path.

#### Invariants
Keep docs refresh instructions tied to the existing generator command. Do not imply Layout or Appearance docs are generated by this workflow.

#### Tests Or Evidence
Ran the generator and Markdown coverage/link validation after the workflow update.

#### Related Files
`Scripts/documentation_generator.sh`, `Content/Views.md`, `Content/Screens.md`, `DSKitTests/__Snapshots__/DSKitTests`, `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`.

#### Follow-up Risks
Simulator OS availability is local-machine dependent; record the actual OS used when it differs from the documented target.
