# Content/CONTRIBUTING.md

- source_path: `Content/CONTRIBUTING.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

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
