# DSKit/Sources/DSKit/Views/DSAISummaryCard.swift

- source_path: `DSKit/Sources/DSKit/Views/DSAISummaryCard.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

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
