# DSKit/Sources/DSKit/Views/DSKeyValueRow.swift

- source_path: `DSKit/Sources/DSKit/Views/DSKeyValueRow.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-30 13:11:34 EEST (`pending`)

- task_or_issue: `reusable-screen-pattern-components`

#### Request
Extract repeated label/value and cart total rows from Explorer screens into a reusable DSKit component.

#### Change Summary
Added `DSKeyValueRow`, a price-row convenience initializer, `DSCountPriceValue`, and a cart-total convenience initializer with a deterministic preview.

#### Rationale
Cart screens and order summaries repeated the same leading label, spacer, and trailing value alignment; the reusable row keeps that composition consistent.

#### Invariants
Keep the row display-only. Calculations, localization choices, and domain-specific labels belong in callers before they pass values into this view.

#### Tests Or Evidence
Recorded and verified `DSKeyValueRow.snapshot.png`; focused component and affected screen snapshot tests passed on iPhone 17 Pro OS 26.5.

#### Related Files
`DSKit/Sources/DSKit/Views/DSPriceSummaryList.swift`, `DSKitExplorer/Screens/CartScreen1.swift` through `CartScreen5.swift`, `DSKitTests/DSKitTests.swift`.

#### Follow-up Risks
If rows need leading icons or disclosure controls, prefer adding explicit initializer variants instead of making this generic row infer domain behavior.
