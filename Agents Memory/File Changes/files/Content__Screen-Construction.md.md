# Content/Screen-Construction.md

- source_path: `Content/Screen-Construction.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 16:09:19 EEST (`pending`)

- task_or_issue: `screen-construction-deep-dive`

#### Request
Deep dive into DSKitExplorer and Monitor, analyze how screens are built with DSKit, and make a dedicated page for that analysis.

#### Change Summary
Created a hand-maintained guide that explains DSKitExplorer screen structure, Monitor production screen structure, shared DSKit construction recipes, Explorer-to-Monitor translation steps, and an agent inspection checklist.

#### Rationale
Generated component and screen docs expose source and snapshots, but agents also need a concise bridge explaining how demo catalog patterns should be adapted for Monitor's production data flow, list virtualization, and interaction rules.

#### Invariants
Keep this page hand-maintained. Use relative links for DSKit repo docs. Keep Monitor references as sibling repo-relative paths unless a stable cross-repo link policy is added.

#### Tests Or Evidence
Read representative DSKitExplorer screens, Monitor screens, DSKit list/section wrappers, and Monitor AGENTS guidance. Validated Markdown links and whitespace for the changed documentation files.

#### Related Files
`README.md`, `AGENTS.md`, `Content/AGENTS.md`, `Content/Screens.md`, `Content/Views.md`, `DSKit/Sources/DSKit/Views/DSList.swift`, `DSKit/Sources/DSKit/Views/DSSection.swift`.

#### Follow-up Risks
Monitor currently has unrelated local changes. If production screen architecture changes before this page is committed, re-check Monitor references before relying on the page.
