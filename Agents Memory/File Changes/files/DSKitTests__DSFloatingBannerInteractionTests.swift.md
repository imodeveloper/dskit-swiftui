# DSKitTests/DSFloatingBannerInteractionTests.swift

- source_path: `DSKitTests/DSFloatingBannerInteractionTests.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-17 13:15:22 EEST (`compact-loading-capsule-padding`)

- task_or_issue: `Protect loading-only compact surface metrics`

#### Request
Add regression coverage for the smaller compact loading capsule without permitting unrelated banner dimensions to change.

#### Change Summary
Added a focused metric matrix asserting compact loading at 8/4/32, compact label and progress at 10/7/32, and regular loading at 14/10/40.

#### Rationale
The requested difference is style-specific and too small for the existing regular-label snapshot to prove; direct metric coverage makes the boundary deterministic.

#### Invariants
Only compact `.loading` receives the tighter padding. Compact `.label`, compact `.progress`, and every regular style remain unchanged.

#### Tests Or Evidence
The new test failed against the previous shared compact 10/7 metrics and passes after the production loading branch was tightened.

#### Related Files
`DSKit/Sources/DSKit/Views/DSFloatingBannerView.swift` and generated `Content/Views/DSFloatingBannerView.md`.

#### Follow-up Risks
If surface metrics move into a token or modifier, retain the same four-way control matrix at the new boundary.

### 2026-07-16 23:11:14 EEST (`continuous-loading-animation-identity`)

- task_or_issue: `Lock continuous loading identity behavior with focused tests`

#### Request
Add regression coverage proving loading phase color/title changes do not replace the banner or restart its pulse.

#### Change Summary
Added a phase matrix with distinct orange, yellow, and brand loading content that must resolve to one animation identity, plus a control assertion that loading and failure remain distinct presentations.

#### Rationale
The continuity requirement is structural and time-based, so a static snapshot cannot reliably detect an unwanted identity replacement or pulse restart.

#### Invariants
Same-operation loading phases share an identity through their `transitionID`; changes between loading and nonloading presentation styles remain distinguishable.

#### Tests Or Evidence
`DSFloatingBannerInteractionTests` passes both new animation-identity cases together with the existing gesture-throughput matrix.

#### Related Files
`DSKit/Sources/DSKit/Views/DSFloatingBannerView.swift`.

#### Follow-up Risks
If the animation boundary moves, keep these identity assertions at the boundary that drives the banner-wide transition.

### 2026-07-16 (`passive-floating-banner-gesture-throughput`)

- task_or_issue: `Protect passive-banner gesture passthrough`

#### Request
Add deterministic coverage for the floating-banner interaction policy that prevents loading UI from blocking underlying lists.

#### Change Summary
Added focused tests proving presented passive content does not hit test, presented interactive content remains tappable, and hidden content does not hit test.

#### Rationale
The behavior is invisible to snapshots but directly controls whether a full-screen overlay intercepts scrolling and navigation gestures.

#### Invariants
The test matrix must keep passive, interactive, and hidden states distinct.

#### Tests Or Evidence
`DSFloatingBannerInteractionTests` passes all three interaction-policy cases.

#### Related Files
`DSKit/Sources/DSKit/Views/DSFloatingBannerView.swift`.

#### Follow-up Risks
If hit-testing policy moves to a modifier or host, retain equivalent state-matrix coverage at the new boundary.
