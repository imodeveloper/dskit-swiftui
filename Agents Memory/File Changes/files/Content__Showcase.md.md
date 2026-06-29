# Content/Showcase.md

- source_path: `Content/Showcase.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:51:20 EEST (`pending`)

- task_or_issue: `agent-oriented-intro-copy`

#### Request
Rewrite the showcase introduction with AI and coding agents in mind.

#### Change Summary
Updated the showcase intro to describe DSKitExplorer as the visual entrypoint into complete SwiftUI flows and added explicit agent navigation guidance: start from the visual group, open the generated screen page, then use the linked source and component references.

#### Rationale
Agents need deterministic navigation cues from visual examples to source-backed implementation references. The showcase page should bridge visual scanning and generated screen documentation.

#### Invariants
Keep this page focused on visual overview and references into generated screen docs. Keep implementation details on generated screen and component pages.

#### Tests Or Evidence
Verified README and showcase relative links.

#### Related Files
`README.md`, `Content/Screens.md`, `Content/Screens/*.md`.

#### Follow-up Risks
If screen catalog links are renamed by generator changes, update this page in the same docs pass.

### 2026-06-29 14:48:48 EEST (`pending`)

- task_or_issue: `separate-readme-showcase`

#### Request
Move the large DSKitExplorer visual showcase out of the main README and into a separate page.

#### Change Summary
Created `Content/Showcase.md` as the dedicated page for the high-level DSKitExplorer visual examples. The page keeps the E-Commerce, Barbershop, and Food Delivery image groups and adds direct links into the generated screen catalog for the representative screens in each group.

#### Rationale
The README should stay compact and fast to scan. The showcase images are useful for visual orientation, but they are large enough to belong on a dedicated page that can also point agents and developers to source-linked screen documentation.

#### Invariants
Keep this page hand-written and concise. Use relative links only. Keep high-level screenshots here and detailed screen/source references in generated `Content/Screens/*.md` pages.

#### Tests Or Evidence
Verified the page links resolve locally with the Markdown link check.

#### Related Files
`README.md`, `Content/Screens.md`, `Content/Screens/*.md`, `Content/Images/e-commerce.png`, `Content/Images/barbershop.png`, `Content/Images/food.png`.

#### Follow-up Risks
If showcase images are renamed or regenerated, update this page and the README link together.
