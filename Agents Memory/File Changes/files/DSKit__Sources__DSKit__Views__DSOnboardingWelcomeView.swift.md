# DSKit/Sources/DSKit/Views/DSOnboardingWelcomeView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSOnboardingWelcomeView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-07 00:25:17 EEST (`pending`)

- task_or_issue: `monitor-reusable-components-dskit-docs`

#### Request
Finish moving reusable Monitor onboarding surfaces into DSKit with generated docs, previews, and snapshots.

#### Change Summary
Changed the deterministic `Testable_DSOnboardingWelcomeView` example to use the explicit `hero:` closure argument instead of trailing closure syntax after multiple closure parameters.

#### Rationale
SwiftLint flags trailing closure syntax when a call passes more than one closure argument. The testable wrapper feeds generated docs and snapshots, so it needs to stay lint-clean without changing the rendered DSKit component.

#### Invariants
Keep the testable onboarding example deterministic and aligned with the public initializer. Do not move acceptance terms, actions, or hero-specific app behavior into DSKit.

#### Tests Or Evidence
Ran SwiftLint, `git diff --check`, `Scripts/documentation_generator.sh`, and focused DSKit snapshot/docs coverage tests on iPhone 17 Pro iOS 26.5.

#### Related Files
`DSKitTests/DSKitTests.swift`, `DSKitTests/__Snapshots__/DSKitTests/DSOnboardingWelcomeView.snapshot.png`, `Content/Views/DSOnboardingWelcomeView.md`.

#### Follow-up Risks
If the public initializer changes, update the testable wrapper and regenerate the component docs and snapshot together.
