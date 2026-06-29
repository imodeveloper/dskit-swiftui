# Content/CODE_OF_CONDUCT.md

- source_path: `Content/CODE_OF_CONDUCT.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:32:19 EEST (`pending`)

- task_or_issue: `move-governance-docs-into-content`

#### Request
Move root-level governance docs into `Content/` and update references.

#### Change Summary
Moved the Code of Conduct page from `CODE_OF_CONDUCT.md` to `Content/CODE_OF_CONDUCT.md` without changing the conduct text.

#### Rationale
The root repository listing should stay focused on core project entrypoints while hand-maintained documentation lives under `Content/`.

#### Invariants
Keep this page hand-maintained. Do not add personal contact information, secrets, or a private reporting address unless the repo explicitly publishes one.

#### Tests Or Evidence
Checked Markdown links for `README.md`, `Content/CONTRIBUTING.md`, and `Content/CODE_OF_CONDUCT.md`; no broken links were found.

#### Related Files
`Content/CONTRIBUTING.md`, `README.md`.

#### Follow-up Risks
GitHub may no longer treat this as the repository's automatic community-health Code of Conduct because it is no longer at the root.

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Review repo docs for stale or confusing content.

#### Change Summary
Replaced the blank Code of Conduct reporting placeholder with a usable repository-maintainer contact path through GitHub moderation or pull request channels.

#### Rationale
A blank enforcement contact is confusing and looks unfinished. The replacement avoids inventing a private contact address that is not present in the repo.

#### Invariants
Do not add personal contact information or secrets. If an official support address exists later, update this file explicitly.

#### Tests Or Evidence
Ran Markdown link/coverage validation and `git diff --check`.

#### Related Files
`CONTRIBUTING.md`, `README.md`.

#### Follow-up Risks
The repo still does not publish a dedicated conduct email address.
