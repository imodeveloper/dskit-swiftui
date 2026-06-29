# CONTRIBUTING.md

- source_path: `CONTRIBUTING.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

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
