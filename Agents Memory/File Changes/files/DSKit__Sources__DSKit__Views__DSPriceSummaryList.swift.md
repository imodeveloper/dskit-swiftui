# DSKit/Sources/DSKit/Views/DSPriceSummaryList.swift

- source_path: `DSKit/Sources/DSKit/Views/DSPriceSummaryList.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-30 13:11:34 EEST (`pending`)

- task_or_issue: `reusable-screen-pattern-components`

#### Request
Extract repeated checkout, order, and shipping total lists from Explorer screens into a reusable DSKit component.

#### Change Summary
Added `DSPriceSummaryItem` and `DSPriceSummaryList`, backed by `DSGroupedList` and `DSKeyValueRow`, with optional row height and emphasized total rows.

#### Rationale
Order and shipping screens duplicated the same grouped price list with label/price rows and a bold total row.

#### Invariants
Keep price summary items display-ready and keep tax, discount, shipping, and total calculations outside this component.

#### Tests Or Evidence
Recorded and verified `DSPriceSummaryList.snapshot.png`; focused component and affected order/shipping screen snapshot tests passed on iPhone 17 Pro OS 26.5.

#### Related Files
`DSKit/Sources/DSKit/Views/DSKeyValueRow.swift`, `DSKitExplorer/Screens/Order1.swift`, `Order2.swift`, `Shipping2.swift`, `DSKitTests/DSKitTests.swift`.

#### Follow-up Risks
Callers with duplicate row titles should pass stable custom ids to `DSPriceSummaryItem`.
