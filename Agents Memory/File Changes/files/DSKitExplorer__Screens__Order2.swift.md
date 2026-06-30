# DSKitExplorer/Screens/Order2.swift

- source_path: `DSKitExplorer/Screens/Order2.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-30 13:11:34 EEST (`pending`)

- task_or_issue: `reusable-screen-pattern-components`

#### Request
Replace repeated screen-local price summary composition with a reusable DSKit component.

#### Change Summary
Removed the local order summary row/list implementation and mapped totals to `DSPriceSummaryItem` for `DSPriceSummaryList`.

#### Rationale
This screen used the same checkout totals pattern as other order and shipping screens, so it should exercise the shared design-system component.

#### Invariants
Keep order totals as display data in the view model and keep business calculations out of `DSPriceSummaryList`.

#### Tests Or Evidence
Focused `testOrder2` snapshot passed on iPhone 17 Pro OS 26.5.

#### Related Files
`DSKit/Sources/DSKit/Views/DSPriceSummaryList.swift`, `DSKit/Sources/DSKit/Views/DSKeyValueRow.swift`, `DSKitExplorer/Screens/Order1.swift`, `Shipping2.swift`.

#### Follow-up Risks
Future duplicate row titles should use explicit `DSPriceSummaryItem` ids.
