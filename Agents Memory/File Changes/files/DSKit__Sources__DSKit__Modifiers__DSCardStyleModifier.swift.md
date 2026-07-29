# DSKit/Sources/DSKit/Modifiers/DSCardStyleModifier.swift

- source_path: `DSKit/Sources/DSKit/Modifiers/DSCardStyleModifier.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-29 11:38:27 EEST (`pending`)

- task_or_issue: `ai-summary-card-surface`

#### Request
Support the nested AI disclosure surface without duplicating card geometry.

#### Change Summary
Added a semantic `DSSurfaceStyle` parameter to both card modifier initializers and view helpers, preserving `.secondary` as the default.

#### Rationale
The summary card contains a primary disclosure surface inside the normal secondary card while retaining the shared padding and corner treatment.

#### Invariants
Keep existing callers source-compatible and keep `.secondary` as the default card background.

#### Tests Or Evidence
The focused DSKit AI-summary snapshots and documentation coverage test pass on Capone.

#### Related Files
`DSAISummaryCard.swift` uses `dsCardStyle(background: .primary)`.

#### Follow-up Risks
New background styles must remain semantic appearance tokens rather than raw colors.
