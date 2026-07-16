# DSKitTests/DSFloatingBannerInteractionTests.swift

- source_path: `DSKitTests/DSFloatingBannerInteractionTests.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

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
