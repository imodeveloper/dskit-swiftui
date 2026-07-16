# DSKit/Sources/DSKit/Views/DSFloatingBannerView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSFloatingBannerView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-16 19:00:05 EEST (`monitor-sync-pulse-and-compact-banner`)

- task_or_issue: `Support continuous production sync pulses and a smaller scroll-to-top banner`

#### Request
Show production sync work with a continuous color-coded loading pulse and make the Monitor scroll-to-top banner smaller.

#### Change Summary
Added generic orange/yellow/brand loading tints, `.loading(tint:)`, regular/compact content sizes, a pulsing-dots `DSLoadingIndicator`, compact font/padding/height metrics, and a tint-independent loading transition identity.

#### Rationale
The loading accessory belongs in DSKit so Monitor only maps domain phases to generic presentation values. A stable identity prevents the liquid surface and timeline-driven pulse from restarting when the phase tint changes.

#### Invariants
Keep `DSFloatingBanner.loading` independent of tint, keep the indicator container transparent, and preserve regular metrics as the default for API compatibility.

#### Tests Or Evidence
Focused loading/identity/compact-size tests and the full DSKit component suite passed; generated component documentation was refreshed.

#### Related Files
`DSLoadingIndicator.swift`, `Monitor/UI/Shared/Views/FloatingBannerView.swift`, `DSKitTests.swift`, and `Content/Views/DSFloatingBannerView.md`.

#### Follow-up Risks
Adding future loading tints must not encode tint into `defaultTransitionID`, or phase changes will restart the banner surface.
