# Content/Documentation.md

- source_path: `Content/Documentation.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

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
