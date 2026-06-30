# DSKitExplorer/Screens/Shipping2.swift

- source_path: `DSKitExplorer/Screens/Shipping2.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-30 13:11:34 EEST (`pending`)

- task_or_issue: `reusable-screen-pattern-components`

#### Request
Replace repeated shipping/order price summary composition with a reusable DSKit component.

#### Change Summary
Removed the local `OrderInfo` grouped list and mapped totals to `DSPriceSummaryItem` for `DSPriceSummaryList`.

#### Rationale
Shipping totals shared the same label/price row pattern as the order screens and no longer need a screen-local duplicate.

#### Invariants
Keep shipping method selection and checkout button behavior screen-owned; `DSPriceSummaryList` should remain display-only.

#### Tests Or Evidence
Focused `testShipping2` snapshot passed on iPhone 17 Pro OS 26.5.

#### Related Files
`DSKit/Sources/DSKit/Views/DSPriceSummaryList.swift`, `DSKit/Sources/DSKit/Views/DSKeyValueRow.swift`, `DSKitExplorer/Screens/Order1.swift`, `Order2.swift`.

#### Follow-up Risks
If totals become dynamic, keep stable ids for repeated row titles.
