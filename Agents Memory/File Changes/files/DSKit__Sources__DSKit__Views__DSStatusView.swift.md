# DSKit/Sources/DSKit/Views/DSStatusView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSStatusView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-30 13:11:34 EEST (`pending`)

- task_or_issue: `reusable-screen-pattern-components`

#### Request
Extract repeated success and empty/status state compositions from Explorer screens into a reusable DSKit component.

#### Change Summary
Added `DSStatusView` and `DSStatusViewStyle` with optional icon, title, message, action, plain centered style, and balanced-padding card style.

#### Rationale
Order confirmation screens duplicated the same success state, and simple no-content cards need equal vertical and horizontal padding when they only contain a message.

#### Invariants
Keep `style: .card` using balanced padding for message-only cards. Keep screen-specific button placement and domain copy controlled by callers.

#### Tests Or Evidence
Recorded and verified `DSStatusView.snapshot.png`; focused component and affected order screen snapshot tests passed on iPhone 17 Pro OS 26.5.

#### Related Files
`DSKitExplorer/Screens/Order3.swift`, `DSKitExplorer/Screens/Order4.swift`, `DSKitTests/DSKitTests.swift`.

#### Follow-up Risks
If future status views need custom media or multiple actions, add explicit slots while preserving the simple empty-card padding behavior.
