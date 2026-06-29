# Content/CONTRIBUTING.md

- source_path: `Content/CONTRIBUTING.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:49:34 EEST (`pending`)

- task_or_issue: `move-root-docs-under-content`

#### Request
Move the root `docs/` folder into `Content/` and update references.

#### Change Summary
Updated the contributor guide workflow link from the removed root docs path to `docs/WORKFLOWS.md`, relative to `Content/`.

#### Rationale
The contributor guide lives in `Content/`, so it should link to the moved workflow guide through the local `docs/` subfolder.

#### Invariants
Keep links in this file relative to `Content/`. Keep generated-doc maintenance guidance visible.

#### Tests Or Evidence
Validated local Markdown links, ran staged whitespace validation, and ran the file-change memory check.

#### Related Files
`Content/docs/WORKFLOWS.md`, `Content/Documentation.md`.

#### Follow-up Risks
If `Content/docs/WORKFLOWS.md` is renamed, update this link and README together.

### 2026-06-29 15:40:29 EEST (`pending`)

- task_or_issue: `separate-generated-docs-workflow`

#### Request
Move generated documentation maintenance guidance into a separate documentation page.

#### Change Summary
Added a link to `Documentation.md` from the contributor guide and replaced the inline generator command block with a shorter pointer to the documented workflow.

#### Rationale
Contributor guidance should point to the canonical docs workflow instead of duplicating the generated-doc maintenance details.

#### Invariants
Keep generated-doc rules visible to contributors. Links in this file are relative to `Content/`.

#### Tests Or Evidence
Validated Markdown links for README, Content docs, and the new workflow page; ran staged whitespace validation and file-change memory check.

#### Related Files
`Content/Documentation.md`, `README.md`, `Content/AGENTS.md`.

#### Follow-up Risks
If `Content/Documentation.md` changes scope, keep this contributor pointer accurate.

### 2026-06-29 15:32:19 EEST (`pending`)

- task_or_issue: `move-governance-docs-into-content`

#### Request
Move root-level governance docs into `Content/` and update references.

#### Change Summary
Moved the contribution guide from `CONTRIBUTING.md` to `Content/CONTRIBUTING.md` and rewrote its relative links for the new folder location.

#### Rationale
The contribution guide belongs with the rest of the hand-maintained repo documentation, but its links must remain useful when opened from `Content/`.

#### Invariants
Keep generated-doc guidance visible. Links in this file are relative to `Content/`, so root docs use `../` and generated Content docs use local filenames.

#### Tests Or Evidence
Checked Markdown links for `README.md`, `Content/CONTRIBUTING.md`, and `Content/CODE_OF_CONDUCT.md`; no broken links were found.

#### Related Files
`README.md`, `Content/CODE_OF_CONDUCT.md`, `docs/WORKFLOWS.md`, `Content/Views.md`, `Content/Screens.md`.

#### Follow-up Risks
GitHub may no longer surface this as the repository's automatic contribution guide because it is no longer at the root.

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Make repo documentation current and easier to follow.

#### Change Summary
Replaced generic contribution prose with concrete repo-native entry points, generated documentation rules, and the documentation generator command.

#### Rationale
Contributors need to know that component and screen docs are generated and should not be edited by hand.

#### Invariants
Keep links relative. Keep generated docs workflow tied to `cd Scripts && ./documentation_generator.sh`.

#### Tests Or Evidence
Ran the generator, Markdown link/coverage validation, and `git diff --check`.

#### Related Files
`README.md`, `docs/WORKFLOWS.md`, `Content/Views.md`, `Content/Screens.md`.

#### Follow-up Risks
If a richer contribution process is introduced, keep the generated-doc rule visible.
