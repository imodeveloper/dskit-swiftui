# Scripts/AGENTS.md

- source_path: `Scripts/AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 20:48:40 EEST (`pending`)

- task_or_issue: `showcase-style-screen-catalog`

#### Request
Update script guidance after adding generated screen catalog strip PNGs.

#### Change Summary
Added `Content/Screens/Groups/*.strip.png` to the documentation generator output list and documented that strip PNGs are generated from frame PNGs.

#### Rationale
Script-area guidance should name every generated output produced by the generator.

#### Invariants
Keep strip PNGs generated and deterministic. Do not hand-edit files under `Content/Screens/Groups`.

#### Tests Or Evidence
Ran the documentation generator, local Markdown link/image validation, and `git diff --check`.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Screens/Groups/*.strip.png`.

#### Follow-up Risks
If strip generation is removed, update this script guide and workflow docs in the same change.

### 2026-06-29 20:25:34 EEST (`pending`)

- task_or_issue: `flatten-screen-frame-previews`

#### Request
Update script-area guidance after replacing generated screen frame SVGs with flattened PNGs.

#### Change Summary
Changed the documented generator output from `*.framed.svg` to `*.framed.png` and added the Pillow requirement for frame composition.

#### Rationale
Agents editing scripts need accurate output names and dependency expectations before changing or rerunning the documentation generator.

#### Invariants
Keep `Content/Screens/Frames` generated from source snapshot PNGs. Do not hand-edit frame assets.

#### Tests Or Evidence
Ran the documentation generator, local Markdown link/image validation, and `git diff --check`.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Screens/Frames/*.framed.png`.

#### Follow-up Risks
If frame generation moves to another tool, update this guide with the new dependency or command.

### 2026-06-29 17:04:12 EEST (`pending`)

- task_or_issue: `iphone-framed-screen-previews`

#### Request
Update script-area guidance for generated screen frame SVGs.

#### Change Summary
Expanded the documentation generator output list to include `Content/Screens/Frames/*.framed.svg` and clarified that these frames are generated from source snapshot PNGs.

#### Rationale
Agents changing scripts should know the generator now owns both Markdown and frame assets, and should not hand-edit the frame SVGs.

#### Invariants
Keep script behavior deterministic and repo-relative. Generated frames must continue to derive from existing screen snapshots.

#### Tests Or Evidence
Ran the documentation generator and local generated-link/image validation after updating the script guide.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Screens/Frames/*.framed.svg`.

#### Follow-up Risks
If a future renderer cannot display SVG frames reliably, update this guide when the output format changes.

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
