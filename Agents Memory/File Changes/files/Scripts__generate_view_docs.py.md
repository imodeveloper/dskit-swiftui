# Scripts/generate_view_docs.py

- source_path: `Scripts/generate_view_docs.py`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Create generated, agent-friendly DSKit component documentation from Swift source, snapshots, and Explorer usage.

#### Change Summary
Added a Python generator that scans `DSKit/Sources/DSKit/Views/*.swift`, writes `Content/Views.md`, writes one `Content/Views/<Component>.md` page per Swift file, and writes `Content/Views/UsageIndex.md` from word-boundary matches in `DSKitExplorer/Screens/*.swift`.

#### Rationale
DSKit has many views, so generated docs keep source comments, examples, snapshots, source links, related components, and Explorer usage references synchronized without relying on the retired website.

#### Invariants
Component identity is the Swift filename basename. Usage scanning stays limited to `DSKitExplorer/Screens/*.swift`. Keep output stable, sorted, repo-relative, and free of website/domain or absolute local path references.

#### Tests Or Evidence
Ran the generator, a generated docs coverage/link validation script, and DSKitExplorer build validation.

#### Related Files
`Scripts/documentation_generator.sh`, `Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`, `DSKit/Sources/DSKit/Views/*.swift`, `DSKitExplorer/Screens/*.swift`.

#### Follow-up Risks
Swift parsing is intentionally lightweight. If source examples become more complex, update brace/comment extraction conservatively and keep deterministic output tests/checks.
