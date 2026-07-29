# DSKit/Sources/DSKit/Views/DSAISummaryCard.swift

- source_path: `DSKit/Sources/DSKit/Views/DSAISummaryCard.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-29 14:25:00 EEST (`pending`)

- task_or_issue: `gold-periodic-ai-sparkle`

#### Change Summary
The disclosure sparkle uses the semantic warning/gold icon color and receives a brief highlight-and-scale shimmer once every three seconds.

#### Invariants
Reduce Motion and snapshot test mode keep the icon static.

### 2026-07-29 14:15:00 EEST (`pending`)

- task_or_issue: `clip-and-fade-expanded-ai-sources`

#### Change Summary
The expanded source-article container is clipped to its animated bounds and now transitions using opacity.

#### Rationale
Article rows must not draw outside the inner card while its height animates during expansion or collapse.

### 2026-07-29 12:44:00 EEST (`pending`)

- task_or_issue: `compact-ai-disclosure-padding`

#### Request
Reduce the padding inside the AI disclosure container on thread details.

#### Change Summary
Changed the inner primary card padding from the default 16-point spatial token to `space8`, with 6-point icon-to-disclosure and disclosure-to-sources gaps. The summary description now uses the smaller `caption1` style with the same primary text color as the title. The overflow source-count badge uses the semantic main brand background.
When sources exist, the entire inner disclosure card is the animated expand/collapse button rather than only the badges or expanded list.

#### Rationale
The disclosure should remain visually distinct without appearing oversized inside the outer summary card.

#### Invariants
Keep the outer card padding, disclosure alignment, source expansion behavior, and semantic surface colors unchanged.

#### Tests Or Evidence
Focused component snapshots cover the collapsed, no-sources, expanded, and many-sources variations.

#### Related Files
`DSKitTests/__Snapshots__/DSKitTests/DSAISummaryCard*.snapshot.png`.

#### Follow-up Risks
Monitor detail-screen snapshots may need regeneration because DSKit is consumed as a local package.

### 2026-07-29 11:38:27 EEST (`pending`)

- task_or_issue: `reusable-ai-summary-card`

#### Request
Add a reusable DSKit presentation for an AI-generated article summary and its contributing sources.

#### Change Summary
Added `DSAISummaryCard`, its source model, collapsed source badges, animated expanded source details, accessibility labels, previews, and deterministic fixtures.

#### Rationale
Monitor needs one consistent summary treatment for individual articles and grouped article threads while keeping navigation outside DSKit.

#### Invariants
Keep inputs display-ready, keep source-opening/navigation behavior in consumers, and preserve the no-sources presentation.

#### Tests Or Evidence
Four focused component snapshots and the component documentation coverage guard pass on Capone; collapsed and expanded goldens were visually reviewed.

#### Related Files
`DSCardStyleModifier.swift`, `DSKitTests.swift`, generated component documentation, and Monitor article-detail snapshots.

#### Follow-up Risks
Source identity assumes each contributing source/article-title pair is unique within a card.
