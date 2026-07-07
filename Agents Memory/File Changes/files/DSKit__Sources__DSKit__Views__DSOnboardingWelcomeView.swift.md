# DSKit/Sources/DSKit/Views/DSOnboardingWelcomeView.swift

- source_path: `DSKit/Sources/DSKit/Views/DSOnboardingWelcomeView.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-07 17:15:00 EEST (`welcome-headline-brand-legal-link`)

- task_or_issue: `Welcome title and legal link should follow requested styling`
- change_id: `welcome-headline-brand-legal-link`

#### Request
Make the welcome screen title bold and make the terms link use the current appearance main/brand color.

#### Change Summary
The headline now uses a bold custom large-title style, and the terms link underline/foreground resolve `DSColorToken.text(.brand)` from the active appearance and surface style.

#### Rationale
Using `.tint`/accent color can diverge from DSKit appearance branding, while the welcome headline needed explicit bold weight.

#### Invariants
Keep legal-link color driven by DSKit appearance tokens, not global SwiftUI tint. Keep the component generic over its hero view.

#### Tests Or Evidence
Focused DSKit snapshot test `testDSOnboardingWelcomeViewUsesAppearanceBrandForLegalLinkAndBoldHeadline` passed and records `DSOnboardingWelcomeView_BrandLegalLink`.

#### Related Files
`DSKitTests/DSKitTests.swift`, `Content/Views/DSOnboardingWelcomeView.md`.

#### Follow-up Risks
If DSKit token names change, preserve the semantic brand-color behavior rather than reverting to accent/tint.

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
