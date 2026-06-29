# Content/Appearance-in-DSKit.md

- source_path: `Content/Appearance-in-DSKit.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Review hand-maintained docs and update stale appearance guidance.

#### Change Summary
Rewrote the appearance guide around current `DSAppearance`, `.dsAppearance(...)`, built-in appearances, `DSColorTheme`, `DSSpatialToken`, `DSTypographyToken`, and semantic color/surface usage.

#### Rationale
The previous page used older appearance fields and examples that no longer matched the current token system.

#### Invariants
Keep this file hand-maintained and current with the source appearance protocol. Link to generated catalogs for rendered examples instead of duplicating generated reference data.

#### Tests Or Evidence
Checked current source APIs, ran Markdown validation, and confirmed links resolve locally.

#### Related Files
`DSKit/Sources/DSKit/Designable/DSAppearance.swift`, `DSKit/Sources/DSKit/Appearances`, `Content/Views.md`, `Content/Screens.md`.

#### Follow-up Risks
If the appearance protocol changes, update this page in the same change.
