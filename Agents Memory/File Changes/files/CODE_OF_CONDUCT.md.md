# CODE_OF_CONDUCT.md

- source_path: `CODE_OF_CONDUCT.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

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
