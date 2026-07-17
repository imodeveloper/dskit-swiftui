# DSThread Terminal Connector Fade

## Goal
Support an opt-in thread ending that uses one existing final connector, touches the final badge with zero spacing, and fades only its last 32 points to transparency.

## Scope / Files
- Extend `DSThreadSection` in `DSKit/Sources/DSKit/Views/DSThread.swift` with an optional terminal fade length.
- Add a deterministic terminal-fade fixture and exact rendered snapshot in `DSKitTests`.
- Regenerate the `DSThread` component documentation and update bounded file-change memory.

## Constraints
- Preserve all existing callers by defaulting the new option to `nil`.
- Do not create a footer connector or a second overlapping line.
- Apply the mask only to the connector, never to row text or content.
- Preserve the existing negative top overlap so the connector begins at the badge with zero gap.
- Keep the opacity transition deterministic for exact snapshot comparison.

## Exit Criteria
- The final item renders one connector with no gap beneath its badge.
- The last 32 points of that connector fade from ordinary relative opacity to zero.
- Footer and non-fading `DSThreadSection` callers remain unchanged.
- A visually meaningful exact snapshot fails for obsolete geometry and passes for the intended result.

## Validation Done
- The old golden failed after moving the fade mask before the existing top-overlap padding, establishing the red snapshot step.
- The refreshed full-screen golden was inspected for a single connector, zero badge gap, and a bottom-only 32-point fade.
- `testDSThreadSectionTerminalFade` and the existing `testDSThreadSection` passed twice on Capone with recording disabled.
- Monitor's Article Thread layout, preview, navigation, and screen snapshot contracts passed twice against the local DSKit source.
