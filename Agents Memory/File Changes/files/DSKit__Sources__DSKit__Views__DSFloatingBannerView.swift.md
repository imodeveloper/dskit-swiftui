# DSKit/Sources/DSKit/Views/DSFloatingBannerView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSFloatingBannerView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-16 23:11:14 EEST (`continuous-loading-animation-identity`)

- task_or_issue: `Keep the floating loading banner mounted across phase color changes`

#### Request
Prevent the production sync banner and loading pulse from visibly disappearing and reappearing when a loading phase changes its title or tint.

#### Change Summary
Loading content now drives banner-wide animation from a canonical identity made only from its stable `transitionID`. Title and tint updates therefore leave the liquid surface and `DSLoadingIndicator` branch mounted, while the indicator receives the new color value.

#### Rationale
Animating the entire `DSFloatingBannerContent` treated every loading phase value as a replacement presentation and restarted the transition, which made the pulse flicker.

#### Invariants
All phases of one continuous loading operation must reuse one `transitionID`. A genuine presentation change, such as loading to failure, must still receive a different identity and transition normally.

#### Tests Or Evidence
Focused interaction tests compare distinct orange, yellow, and brand loading content and prove they share one animation identity while loading and failure do not.

#### Related Files
`DSKitTests/DSFloatingBannerInteractionTests.swift`, `DSLoadingIndicator.swift`, and Monitor's floating-banner phase mapping.

#### Follow-up Risks
Do not add title, tint, or the full loading content value back into the loading animation identity; doing so will reintroduce the phase-change flicker.

### 2026-07-16 (`passive-floating-banner-gesture-throughput`)

- task_or_issue: `Let passive floating banners pass gestures through`

#### Request
Prevent a noninteractive loading banner from temporarily blocking the list and navigation gestures underneath it.

#### Change Summary
Root hit testing now requires both a presented banner and interactive content. Passive and hidden overlays pass gestures through; presented action banners remain tappable.

#### Rationale
The banner host fills the screen, so enabling root hit testing for passive status content intercepted scrolling and swipe-back input outside the capsule.

#### Invariants
Hidden and passive banners do not hit test. Presented interactive banners continue to hit test and invoke their action.

#### Tests Or Evidence
Focused interaction tests cover presented passive, presented interactive, and hidden banner states.

#### Related Files
`DSKitTests/DSFloatingBannerInteractionTests.swift` and Monitor's screen-local floating-banner hosts.

#### Follow-up Risks
New passive banner styles must keep `isInteractive` false; otherwise the full overlay intentionally becomes interactive again.

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
