# Content/AGENTS.md

- source_path: `Content/AGENTS.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 20:25:34 EEST (`pending`)

- task_or_issue: `flatten-screen-frame-previews`

#### Request
Keep Content-area guidance aligned with flattened PNG screen frames.

#### Change Summary
Updated `Screens/Frames` guidance from generated SVG frame assets to generated PNG frame assets.

#### Rationale
Content agents need accurate generated-output guidance before editing documentation surfaces or rerunning the generator.

#### Invariants
Do not hand-edit generated component pages, screen pages, or frame PNGs; update source, snapshots, or the generator instead.

#### Tests Or Evidence
Ran the documentation generator, local Markdown link/image validation, and `git diff --check`.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Screens.md`, `Content/Screens/*.md`, `Content/Screens/Frames/*.framed.png`.

#### Follow-up Risks
If frame assets change type or location, update `AGENTS.md`, `Content/AGENTS.md`, and `Scripts/AGENTS.md` together.

### 2026-06-29 17:54:45 EEST (`pending`)

- task_or_issue: `dskit-only-screen-construction`

#### Request
Update Content-area guidance so `Screen-Construction.md` is described as DSKit documentation, not a Monitor comparison page.

#### Change Summary
Changed the `Screen-Construction.md` description to identify it as the hand-maintained guide for building full DSKit screens from DSKitExplorer patterns.

#### Rationale
Content guidance should clearly separate DSKit documentation from external app-specific architecture.

#### Invariants
Keep generated docs and hand-maintained docs clearly separated. Keep `Screen-Construction.md` classified as hand-maintained.

#### Tests Or Evidence
Validated local links for changed docs and ran whitespace validation.

#### Related Files
`Content/Screen-Construction.md`, `README.md`, `AGENTS.md`.

#### Follow-up Risks
None.

### 2026-06-29 17:04:12 EEST (`pending`)

- task_or_issue: `iphone-framed-screen-previews`

#### Request
Document generated screen frame SVGs inside Content guidance.

#### Change Summary
Listed `Screens/Frames/*.framed.svg` as generated output from screen snapshot PNGs and extended the no-hand-edit rule to generated frame SVGs.

#### Rationale
Content-area agents need a clear distinction between hand-maintained pages and generated screen preview assets.

#### Invariants
Generated screen pages and frame SVGs are refreshed through `Scripts/documentation_generator.sh`; do not edit them directly.

#### Tests Or Evidence
Ran the documentation generator and local generated-link/image validation after updating Content guidance.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Screens.md`, `Content/Screens/*.md`, `Content/Screens/Frames/*.framed.svg`.

#### Follow-up Risks
If generated frame assets move outside `Content/Screens`, update this Content guide in the same change.

### 2026-06-29 16:09:19 EEST (`pending`)

- task_or_issue: `screen-construction-deep-dive`

#### Request
Deep dive into DSKitExplorer and Monitor screen construction, then add the result to the agent guide and README.

#### Change Summary
Listed `Screen-Construction.md` as a hand-maintained Content guide that compares DSKitExplorer screen patterns with production Monitor screen patterns.

#### Rationale
Agents working inside `Content/` need to know that the new page is not generated and should be maintained alongside other human-authored documentation.

#### Invariants
Keep generated docs clearly separated from hand-maintained pages. Do not classify `Screen-Construction.md` as generator output.

#### Tests Or Evidence
Validated Markdown links for the changed docs and ran whitespace validation on the changed documentation files.

#### Related Files
`Content/Screen-Construction.md`, `AGENTS.md`, `README.md`.

#### Follow-up Risks
If future generated docs include similar analysis, clarify which source is canonical.

### 2026-06-29 15:49:34 EEST (`pending`)

- task_or_issue: `move-root-docs-under-content`

#### Request
Move the root `docs/` folder into `Content/` and update references.

#### Change Summary
Documented that `Content/docs/` contains the hand-maintained workflow, quality, planning, design-principle, and execution-plan docs.

#### Rationale
Agents working inside `Content/` need to distinguish generated docs from the hand-maintained guide tree now nested under `Content/docs/`.

#### Invariants
Keep generated docs and hand-maintained docs clearly separated in this guide.

#### Tests Or Evidence
Validated local Markdown links, ran staged whitespace validation, and ran the file-change memory check.

#### Related Files
`Content/docs/WORKFLOWS.md`, `Content/docs/QUALITY.md`, `Content/docs/PLANS.md`.

#### Follow-up Risks
If more docs move under `Content/docs/`, keep this routing note current.

### 2026-06-29 15:40:29 EEST (`pending`)

- task_or_issue: `separate-generated-docs-workflow`

#### Request
Move the generated documentation maintenance paragraph out of the README and into a separate documentation page.

#### Change Summary
Added `Content/Documentation.md` to the Content guide as a hand-maintained generated-docs workflow guide referenced by README.

#### Rationale
Agents editing Content need to know that the new workflow page is not generated, while the Views and Screens documentation surfaces remain generated outputs.

#### Invariants
Keep generated-doc output rules explicit. Do not hand-edit generated `Content/Views*` or `Content/Screens*` pages.

#### Tests Or Evidence
Validated Markdown links for README, Content docs, and the new workflow page; ran staged whitespace validation and file-change memory check.

#### Related Files
`Content/Documentation.md`, `README.md`, `Content/CONTRIBUTING.md`.

#### Follow-up Risks
If more hand-maintained Content pages are added, keep this routing guide current.

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Make DSKit component and screen documentation repo-native, generated, and easy for agents to inspect.

#### Change Summary
Documented generated `Views.md`, per-component pages, usage index, `Screens.md`, per-screen pages, and required snapshot locations.

#### Rationale
Agents working in `Content/` need to know which docs are canonical hand-maintained guides and which files are generated outputs.

#### Invariants
Do not hand-edit generated component pages, screen pages, or usage indexes. Change Swift source, Explorer usage, snapshots, or the generator instead.

#### Tests Or Evidence
Ran the generator and Markdown coverage/link validation.

#### Related Files
`Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `Content/Screens.md`, `Content/Screens/*.md`, `Scripts/generate_view_docs.py`.

#### Follow-up Risks
`Layout-in-DSKit.md` and `Appearance-in-DSKit.md` remain hand-maintained and must be audited separately when token APIs change.
