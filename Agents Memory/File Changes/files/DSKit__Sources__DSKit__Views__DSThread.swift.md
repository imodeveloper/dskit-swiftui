# DSKit/Sources/DSKit/Views/DSThread.swift

- source_path: `DSKit/Sources/DSKit/Views/DSThread.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-17 15:14:00 EEST (`thread-terminal-connector-fade`)

- task_or_issue: `A thread screen needed one final connector that remains attached to its badge and fades at the bottom`
- change_id: `thread-terminal-connector-fade`

#### Request
Remove the separate overlapping end line, use the existing final connector for the opacity transition, and keep zero spacing between the final badge and line.

#### Change Summary
Added an opt-in `terminalLineFadeLength` to both `DSThreadSection` initializers. On the last item only, DSKit masks the existing content connector with deterministic opacity steps; the mask is applied before the connector's negative top padding so the line still meets the badge with zero gap.

#### Rationale
Fading a separate footer connector creates a second overlapping line. Masking only the existing connector preserves one timeline, keeps article content fully opaque, and makes the requested ending reusable without changing default callers.

#### Invariants
The option defaults to `nil`; existing callers and footer behavior remain unchanged. Never add a second connector for the terminal fade. Keep the mask on the connector, before overlap padding, and not on the full row.

#### Tests Or Evidence
The exact full-screen snapshot failed against the old geometry after the zero-gap modifier-order change, was deliberately refreshed, and passed twice on Capone together with the existing `DSThreadSection` snapshot. The golden was visually inspected for one connector, zero badge gap, and a 32-point bottom fade.

#### Related Files
`DSKitTests/DSKitTests.swift`, `DSKitTests/__Snapshots__/DSKitTests/DSThreadSectionTerminalFade.snapshot.png`, and `Content/Views/DSThread.md`.

#### Follow-up Risks
Applying a mask after negative padding clips the connector's overlap and recreates the badge gap. Relaxed full-screen snapshot precision can also miss this small geometry change, so the focused golden uses exact, zero-retry comparison.
