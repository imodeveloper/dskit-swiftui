# Content/docs/QUALITY.md

- source_path: `Content/docs/QUALITY.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 17:25:51 EEST (`pending`)

- task_or_issue: `iphone-framed-screen-previews`

#### Request
Keep quality guardrails current after adding generated screen frame SVGs.

#### Change Summary
Expanded the generated-docs quality rule to include `Content/Screens/Frames/*.framed.svg`.

#### Rationale
Generated frame SVGs are documentation assets and should follow the same regenerated-from-source rule as generated Markdown pages.

#### Invariants
Generated docs and frame assets are refreshed from source, snapshots, and the generator, not manually rewritten.

#### Tests Or Evidence
Ran the documentation generator, local generated Markdown/SVG link validation, and whitespace validation after updating the quality guide.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Documentation.md`, `Content/docs/WORKFLOWS.md`.

#### Follow-up Risks
Keep this list synchronized if generated output paths change again.

### 2026-06-29 15:49:34 EEST (`pending`)

- task_or_issue: `move-root-docs-under-content`

#### Request
Move the root `docs/` folder into `Content/` and update references.

#### Change Summary
Moved the quality guide from `docs/QUALITY.md` to `Content/docs/QUALITY.md`.

#### Rationale
Quality and guardrail documentation belongs with the rest of the repo documentation under `Content/`.

#### Invariants
Keep snapshot and generated-doc guardrails current when test surfaces or generated outputs change.

#### Tests Or Evidence
Validated local Markdown links, ran staged whitespace validation, and ran the file-change memory check.

#### Related Files
`AGENTS.md`, `Agents Memory/ARCHITECTURE.md`, `Content/docs/WORKFLOWS.md`.

#### Follow-up Risks
None beyond keeping quality guidance aligned with the test suite.

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Update quality guidance for the new generated component and screen docs.

#### Change Summary
Expanded generated-doc quality rules to include per-component pages, the usage index, screen index, and per-screen pages.

#### Rationale
The quality guide previously named only `Content/Views.md`, which hid the broader generated documentation surface.

#### Invariants
Generated docs must be regenerated from source and snapshots, not manually rewritten.

#### Tests Or Evidence
Ran generator and Markdown coverage/link validation across 155 Markdown files.

#### Related Files
`docs/WORKFLOWS.md`, `Scripts/generate_view_docs.py`, `Content/Views.md`, `Content/Screens.md`.

#### Follow-up Risks
If generated docs expand again, update this quality rule.
