# DSKitExplorer/Screens/Order3.swift

- source_path: `DSKitExplorer/Screens/Order3.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-30 13:11:34 EEST (`pending`)

- task_or_issue: `reusable-screen-pattern-components`

#### Request
Replace repeated order success-state composition with a reusable DSKit component.

#### Change Summary
Replaced the overlay's manual icon/title/message stack with `DSStatusView`, preserving the success icon, green tint, title style, and message copy.

#### Rationale
Order confirmation screens duplicated the same centered success presentation and should share the design-system status component.

#### Invariants
Keep screen-owned bottom actions and suggestions outside `DSStatusView`; the reusable view only owns the status content.

#### Tests Or Evidence
Focused `testOrder3` snapshot passed on iPhone 17 Pro OS 26.5.

#### Related Files
`DSKit/Sources/DSKit/Views/DSStatusView.swift`, `DSKitExplorer/Screens/Order4.swift`, `DSKitTests/DSKitTests.swift`.

#### Follow-up Risks
If the overlay layout changes, keep the vertical placement controlled by the screen rather than adding layout-specific behavior to `DSStatusView`.
