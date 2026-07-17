# DSKit/Sources/DSKit/Views/DSArticleRows.swift

- source_path: `DSKit/Sources/DSKit/Views/DSArticleRows.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-17 18:21:20 EEST (`article-summary-default-image-48`)

- task_or_issue: `Article summary thumbnails needed the authored smaller default`
- change_id: `article-summary-default-image-48`

#### Request
Preserve the current authored article-summary image-size change exactly as it is.

#### Change Summary
Changed `DSArticleSummaryRow`'s default image size from the 64-point token to the 48-point token.

#### Rationale
The smaller default gives article text more horizontal room and establishes the final shared thumbnail scale without preventing caller overrides.

#### Invariants
Keep `imageSize` publicly overridable and preserve the existing title/image horizontal layout plus full-width metadata footer.

#### Tests Or Evidence
`git diff --check` passes. Component and consuming Monitor snapshot reconciliation is intentionally deferred until after the requested Dev and Prod deliveries.

#### Related Files
`Monitor/UI/Shared/Views/ArticleRegularRowView.swift`, DSKit article-row snapshots, and Monitor screen snapshots.

#### Follow-up Risks
Callers relying on the previous implicit 64-point default will render smaller images and may need intentional baseline updates.

### 2026-07-16 19:00:05 EEST (`article-metadata-below-content-row`)

- task_or_issue: `Article metadata must span beneath the title and optional image`

#### Request
Preserve the current article-row layout adjustment while validating and delivering the Monitor presentation work.

#### Change Summary
Moved `metadata` outside the title/image `DSHStack` so the footer spans the full row beneath both columns.

#### Rationale
Metadata belongs to the complete article card and should not be constrained to the text column when a trailing image exists.

#### Invariants
Keep the title and optional image in the same horizontal content row; keep metadata in the outer vertical stack.

#### Tests Or Evidence
The full DSKit component suite and full Monitor test suite passed; requested Monitor screen baselines were visually reviewed.

#### Related Files
`ArticleRegularRowView.swift`, `MonitorScreenSnapshotTests.swift`, and generated DSArticleRows consumers.

#### Follow-up Risks
Changing this nesting can affect component height and existing snapshots with trailing images.

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
