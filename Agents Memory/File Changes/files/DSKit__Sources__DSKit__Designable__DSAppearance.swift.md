# DSKit/Sources/DSKit/Designable/DSAppearance.swift

- source_path: `DSKit/Sources/DSKit/Designable/DSAppearance.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-16 19:00:05 EEST (`appearance-brand-token-resolution`)

- task_or_issue: `Semantic brand tokens must resolve from the configured color theme`

#### Request
Ensure appearance brand colors remain consistent across background, text, icon, and border tokens.

#### Change Summary
Resolved brand, hover, pressed, focused, text, icon, and border cases through the appearance color theme instead of unrelated button accent fields.

#### Rationale
Components such as the production sync pulse need the configured appearance brand color regardless of which semantic token family they use.

#### Invariants
Brand semantic tokens must remain sourced from `colors`; non-brand success, warning, danger, and surface behavior stays unchanged.

#### Tests Or Evidence
`DSKitTests.testBrandColorTokensUseAppearanceBrandColor` and the full DSKit component suite passed.

#### Related Files
`DSColorToken.swift`, `DSFloatingBannerView.swift`, and `DSKitTests.swift`.

#### Follow-up Risks
Custom appearances must initialize their color theme consistently with their intended brand color.
