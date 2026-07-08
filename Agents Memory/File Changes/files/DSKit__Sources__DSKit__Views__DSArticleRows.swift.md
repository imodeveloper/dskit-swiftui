# DSKit/Sources/DSKit/Views/DSArticleRows.swift

- source_path: `DSKit/Sources/DSKit/Views/DSArticleRows.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-08 23:55:00 EEST (`pending`)

- task_or_issue: `Article rows need full-row hit testing without visual changes`

#### Request
Make article rows tappable across the visible row area while keeping UI layout pixel-stable.

#### Change Summary
Added rectangular content shapes to DSKit article row surfaces so existing tap gestures receive hits in empty row space.

#### Rationale
Rows visually read as single tappable items, but tap behavior previously only hit text/image subviews.

#### Invariants
Do not add visible padding/backgrounds or replace these rows with button wrappers for hit testing.

#### Tests Or Evidence
Targeted DSKit component tests passed; full Monitor iOS tests and dev/prod 5-minute observations passed.
