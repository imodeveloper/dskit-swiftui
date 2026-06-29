# Content/Appearance-in-DSKit.md

- source_path: `Content/Appearance-in-DSKit.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:03:37 EEST (`pending`)

- task_or_issue: `link-built-in-appearance-sources`

#### Request
Add links for the built-in appearances listed in the appearance guide.

#### Change Summary
Converted `LightBlueAppearance`, `DarkAppearance`, `RetroAppearance`, `BlueAppearance`, and `PeachAppearance` from plain code-formatted names into relative links to their Swift source files under `DSKit/Sources/DSKit/Appearances`.

#### Rationale
Developers and agents should be able to jump directly from the appearance guide to the source implementation for each built-in theme.

#### Invariants
Keep hand-maintained docs source-linked with relative repo paths. `LightBlueAppearance` currently lives in `DSKitAppearance.swift`; do not assume every appearance has a one-class-per-file mapping.

#### Tests Or Evidence
Verified the appearance guide links resolve locally.

#### Related Files
`DSKit/Sources/DSKit/Appearances/DSKitAppearance.swift`, `DSKit/Sources/DSKit/Appearances/DarkAppearance.swift`, `DSKit/Sources/DSKit/Appearances/RetroAppearance.swift`, `DSKit/Sources/DSKit/Appearances/BlueAppearance.swift`, `DSKit/Sources/DSKit/Appearances/PeachAppearance.swift`.

#### Follow-up Risks
If appearance files move or built-in appearances are renamed, update these links in the same source change.

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
