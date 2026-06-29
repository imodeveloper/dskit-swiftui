# README.md

- source_path: `README.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:19:37 EEST (`pending`)

- task_or_issue: `trim-running-explorer-workflows-link`

#### Request
Remove the `docs/WORKFLOWS.md` sentence from the README `Running DSKitExplorer` section.

#### Change Summary
Shortened `Running DSKitExplorer` to only tell readers to open `DSKitExplorer.xcodeproj`, select the `DSKitExplorer` scheme, and run it on an iPhone simulator.

#### Rationale
The README section should stay focused on launching the demo app without sending readers into workflow automation docs from this paragraph.

#### Invariants
Keep the `Running DSKitExplorer` section concise. Link workflow docs only where command-line maintenance or agent workflow context is explicitly needed.

#### Tests Or Evidence
Verified README relative links and staged whitespace.

#### Related Files
`README.md`.

#### Follow-up Risks
If CLI workflow discoverability becomes a problem, add a separate concise command-line section instead of expanding this run paragraph.

### 2026-06-29 15:17:43 EEST (`pending`)

- task_or_issue: `trim-readme-documentation-links`

#### Request
Remove the DSKitExplorer Screens, DSKitExplorer Usage Index, and Showcase bullets from the README documentation section.

#### Change Summary
Trimmed the README documentation entrypoint list to keep `Views / Components`, `Layout`, and `Appearance` only.

#### Rationale
The top-level documentation section should stay focused on the primary documentation paths and avoid overloading the first README list.

#### Invariants
Keep README documentation links concise. Secondary docs can stay discoverable from generated docs and contextual links outside the main documentation list.

#### Tests Or Evidence
Verified README relative links and staged whitespace.

#### Related Files
`README.md`.

#### Follow-up Risks
If screen or showcase docs need top-level promotion again, add them deliberately with shorter labels.

### 2026-06-29 15:05:54 EEST (`pending`)

- task_or_issue: `move-start-here-after-documentation`

#### Request
Move the README `Start Here` section after the `Documentation` section.

#### Change Summary
Moved the full `Start Here` setup and example block below the documentation entrypoints and `Running DSKitExplorer` guidance.

#### Rationale
Readers and agents should first see the repo-native documentation entrypoints, then continue into install and first-use steps.

#### Invariants
Keep the `Start Here` block intact unless setup instructions change. Preserve the generated documentation links before setup details.

#### Tests Or Evidence
Verified README relative links and staged whitespace.

#### Related Files
`README.md`.

#### Follow-up Risks
If the documentation section is split later, revisit whether `Start Here` should sit after just the entrypoint list or after all documentation-related subsections.

### 2026-06-29 15:01:35 EEST (`pending`)

- task_or_issue: `remove-platform-support-sentence`

#### Request
Remove the README sentence that listed Swift Package and target deployment support versions.

#### Change Summary
Removed the platform-support sentence from the README intro so the top section moves directly from the DSKit description to the preview image.

#### Rationale
The package-support wording was distracting in the public intro and may drift separately from project settings.

#### Invariants
Keep the README intro concise. If platform support needs documentation later, put it in a focused compatibility section or workflow doc where it can be kept aligned with project settings.

#### Tests Or Evidence
Verified the removed sentence no longer appears in `README.md`.

#### Related Files
`README.md`.

#### Follow-up Risks
If public compatibility promises are needed, add them back as an intentional compatibility section backed by project settings.

### 2026-06-29 14:54:15 EEST (`pending`)

- task_or_issue: `simplify-agent-readme-copy`

#### Request
Rethink, simplify, and improve the README copy with developers and AI agents in mind.

#### Change Summary
Shortened the intro, Explorer summary, setup flow, documentation section, and contribution guidance. The README now emphasizes a direct path from installation to examples, generated catalogs, source links, snapshots, and usage references without long marketing-style paragraphs.

#### Rationale
The README should be quick for humans and agents to scan. It should identify what DSKit is, how to install it, how to start using it, and where to inspect source-backed examples.

#### Invariants
Keep README copy concise. Preserve repo-native links to generated docs and avoid reintroducing legacy website or UIKit routing in the main path.

#### Tests Or Evidence
Verified README and showcase relative links.

#### Related Files
`Content/Showcase.md`, `Content/Screens.md`, `Content/Views.md`, `Content/Views/UsageIndex.md`.

#### Follow-up Risks
If the generated docs move or change shape, update these README links and descriptions together.

### 2026-06-29 14:51:20 EEST (`pending`)

- task_or_issue: `agent-oriented-intro-copy`

#### Request
Rewrite the DSKit intro and Explorer summary with AI and coding agents in mind.

#### Change Summary
Reworded the README opening copy to describe DSKit as a repo-native SwiftUI design system that is easy for developers and agents to inspect, compose, and reuse. The Explorer summary now points to visual, screen, and component catalogs with source files, snapshots, and usage references.

#### Rationale
The top-level README should explain not just what DSKit is, but how an agent should navigate from a UI need to generated docs, source-backed examples, and reusable SwiftUI patterns.

#### Invariants
Keep the README truthful to current platform support and repo-native docs. Do not imply generated docs are hand-authored or that agents should scrape the old website path.

#### Tests Or Evidence
Verified README and showcase relative links.

#### Related Files
`Content/Showcase.md`, `Content/Screens.md`, `Content/Views.md`.

#### Follow-up Risks
If generated docs change shape, keep this intro aligned with the actual navigation path.

### 2026-06-29 14:48:58 EEST (`pending`)

- task_or_issue: `separate-readme-showcase`

#### Request
Move the large DSKitExplorer showcase section out of the README and into a separate page.

#### Change Summary
Replaced the inline E-Commerce, Barbershop, and Food Delivery showcase images with a compact link to `Content/Showcase.md` and retained the generated `Content/Screens.md` reference for source-linked implementation details.

#### Rationale
The README should remain a concise package entrypoint. Large visual examples are still discoverable, but no longer dominate the top of the README before setup and docs links.

#### Invariants
Keep the README top section compact. Link to dedicated repo-local docs for expanded visual and generated reference content.

#### Tests Or Evidence
Verified the removed image block moved to `Content/Showcase.md` and local Markdown links resolve.

#### Related Files
`Content/Showcase.md`, `Content/Screens.md`, `Content/Images/e-commerce.png`, `Content/Images/barbershop.png`, `Content/Images/food.png`.

#### Follow-up Risks
If the showcase page moves, update the README link in the same change.

### 2026-06-29 14:46:49 EEST (`pending`)

- task_or_issue: `remove-uikit-version-note`

#### Request
Remove the rendered README note that points readers to the old UIKit DSKit repository.

#### Change Summary
Removed the `[!Note]` block under `Get Started` that linked to the UIKit version. The README now flows directly from `Get Started` into Swift Package Manager setup.

#### Rationale
The SwiftUI package README should keep attention on the current DSKit SwiftUI installation path and avoid sending readers to the retired UIKit repo.

#### Invariants
Keep README links focused on current repo-native SwiftUI documentation and local generated docs. Do not reintroduce website or legacy UIKit repository routing unless the README explicitly needs migration context.

#### Tests Or Evidence
Verified the only targeted `UIKit Version` text was in `README.md`.

#### Related Files
`README.md`.

#### Follow-up Risks
If migration guidance is needed later, put it in a dedicated migration note rather than the main getting-started path.

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Update the main README so repo-native Markdown is the canonical entrypoint for DSKit docs.

#### Change Summary
Updated platform/support copy, SPM URL, setup guidance, generated component and screen documentation links, DSKitExplorer run guidance, and contribution notes. The README now points readers at `Content/Views.md`, `Content/Screens.md`, `UsageIndex.md`, Layout, Appearance, and workflow docs.

#### Rationale
The retired website should no longer be the documentation path. Developers and agents need the README to lead directly to generated repo docs and current local workflows.

#### Invariants
Keep README documentation links relative and local. Keep platform wording aligned with `Package.swift` and Xcode project deployment targets.

#### Tests Or Evidence
Validated local relative links across 155 Markdown files, ran generated docs coverage checks, and reran the focused component preview snapshot test.

#### Related Files
`Content/Views.md`, `Content/Screens.md`, `Content/Views/UsageIndex.md`, `Content/Layout-in-DSKit.md`, `Content/Appearance-in-DSKit.md`, `docs/WORKFLOWS.md`.

#### Follow-up Risks
If package deployment targets change, update the README, architecture memory, and workflow docs together.
