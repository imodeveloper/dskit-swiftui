# DSKit/Sources/DSKit/Designable/DSTypographyToken.swift

- source_path: `DSKit/Sources/DSKit/Designable/DSTypographyToken.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-16 19:00:05 EEST (`article-density-typography`)

- task_or_issue: `Use the intended compact label size across DSKit`

#### Request
Preserve the current requested typography adjustment while delivering the Monitor article presentation work.

#### Change Summary
Changed the `.label` token from a 16-point to a 14-point headline-derived font.

#### Rationale
The label token is intended for denser source and settings labels and should remain visually subordinate to body/article titles.

#### Invariants
Treat `.label` as a shared design token; do not compensate for snapshot changes by adding local font overrides to unrelated components.

#### Tests Or Evidence
The full DSKit component suite and full Monitor test suite passed; the affected DSKeyValueRow baseline was reviewed and updated intentionally.

#### Related Files
`DSArticleRows.swift`, `DSKeyValueRow.snapshot.png`, and Monitor detailed article rows.

#### Follow-up Risks
This is a global typography token change and can alter existing component snapshots that use `.label`.
