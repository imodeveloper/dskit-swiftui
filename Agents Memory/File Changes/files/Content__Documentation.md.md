# Content/Documentation.md

- source_path: `Content/Documentation.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 20:48:40 EEST (`pending`)

- task_or_issue: `showcase-style-screen-catalog`

#### Request
Keep documentation workflow guidance aligned with generated Showcase-style screen catalog strips.

#### Change Summary
Added `Screens/Groups/` to generated outputs and added validation language for generated screen catalog strips rebuilt from frame PNGs.

#### Rationale
The workflow page should identify all generated documentation assets, including the new responsive strip images used by `Screens.md`.

#### Invariants
Keep this page hand-maintained. Generated strips are refreshed through `Scripts/documentation_generator.sh`, not edited directly.

#### Tests Or Evidence
Ran the documentation generator, local Markdown link/image validation, and `git diff --check`.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Screens/Groups/*.strip.png`, `Content/docs/WORKFLOWS.md`.

#### Follow-up Risks
If generated strip output changes, update this workflow page in the same change.

### 2026-06-29 20:25:34 EEST (`pending`)

- task_or_issue: `flatten-screen-frame-previews`

#### Request
Keep the documentation workflow aligned with self-contained screen preview frames.

#### Change Summary
Updated validation wording to describe screen preview frames as rebuilt from snapshot PNGs and documented the Pillow dependency used to compose flattened frame PNGs.

#### Rationale
The workflow page should describe generated frame output accurately so agents do not assume frames are pointers or SVG wrappers.

#### Invariants
Keep this page hand-maintained. Generated frames remain refreshed through `Scripts/documentation_generator.sh`, not edited directly.

#### Tests Or Evidence
Ran the documentation generator, local Markdown link/image validation, and `git diff --check` after updating the workflow language.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Screens/Frames/*.framed.png`, `Content/docs/WORKFLOWS.md`.

#### Follow-up Risks
If the generator output format changes again, update this workflow page in the same change.

### 2026-06-29 17:25:51 EEST (`pending`)

- task_or_issue: `iphone-framed-screen-previews`

#### Request
Keep generated documentation workflow guidance aligned with generated iPhone-framed screen previews.

#### Change Summary
Expanded generated output guidance to include `Content/Screens/Frames/` and added validation language for generated screen preview frames pointing back to existing screen snapshots.

#### Rationale
The documentation workflow page should name every generated docs surface so contributors and agents do not hand-edit frame assets.

#### Invariants
Keep this page hand-maintained. Generated screen frames are refreshed through `Scripts/documentation_generator.sh`, not edited directly.

#### Tests Or Evidence
Ran the documentation generator, local generated Markdown/SVG link validation, and whitespace validation after updating the workflow page.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Screens/Frames/*.framed.svg`, `Content/docs/WORKFLOWS.md`, `Content/docs/QUALITY.md`.

#### Follow-up Risks
If generated frame output changes format or location, update this workflow page in the same change.

### 2026-06-29 15:40:29 EEST (`pending`)

- task_or_issue: `separate-generated-docs-workflow`

#### Request
Move the generated documentation maintenance paragraph out of the README and into a separate documentation page.

#### Change Summary
Created a hand-maintained generated-docs workflow page covering source-of-truth inputs, generated outputs, the refresh command, and validation expectations.

#### Rationale
The README should stay concise while agents and contributors still need one canonical place to understand how generated docs are refreshed and what not to edit by hand.

#### Invariants
Keep this page hand-maintained. Generated docs remain under `Content/Views*` and `Content/Screens*`; changes to those pages should come from source comments, examples, snapshots, Explorer source, or the generator.

#### Tests Or Evidence
Validated Markdown links for README, Content docs, and the new workflow page; ran staged whitespace validation and file-change memory check.

#### Related Files
`README.md`, `Content/AGENTS.md`, `Content/CONTRIBUTING.md`, `Scripts/documentation_generator.sh`, `Scripts/generate_view_docs.py`.

#### Follow-up Risks
If the generator output surface changes, update this page and `Content/AGENTS.md` together.
