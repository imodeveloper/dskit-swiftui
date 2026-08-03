# DSKit/Sources/DSKit/Views/DSLetterBadgeView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSLetterBadgeView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-08-03 (`diagonal-source-badge-gradients`)

- Letter and source badges now use a lower-left to upper-right gradient from the assigned source color at 80% opacity to the same color at full opacity.
- This preserves deterministic source-color assignment while applying the shared visual treatment in article rows, author headers, and AI-summary source badges.


### 2026-07-17 18:21:20 EEST (`letter-badge-compact-balance`)

- task_or_issue: `Letter badges needed the authored smaller circle and larger initial balance`
- change_id: `letter-badge-compact-balance`

#### Request
Preserve the current authored letter-badge sizing changes exactly as they are.

#### Change Summary
Raised the glyph cap-height multiplier from `1.05` to `1.15` while reducing badge height from a 16-point, `1.08 × lineHeight` minimum to a 15-point, `0.9 × lineHeight` minimum.

#### Rationale
The final badge treatment keeps initials legible while making source badges more compact and visually aligned with thread connectors and article typography.

#### Invariants
Keep badge size derived from the caller's typography token, retain circular single-letter and capsule multi-letter behavior, and preserve dynamic-type scaling.

#### Tests Or Evidence
`git diff --check` passes. DSKit and Monitor snapshot reconciliation is intentionally deferred until after the requested Dev and Prod deliveries.

#### Related Files
`DSKit/Sources/DSKit/Views/DSAuthorView.swift`, thread/article row snapshots, and Monitor source badges.

#### Follow-up Risks
The shared badge geometry affects every `DSLetterBadgeView` consumer and will likely change multiple visual baselines.
