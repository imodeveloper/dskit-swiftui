# docs/design-docs/ds-wrapper-principles.md

- source_path: `docs/design-docs/ds-wrapper-principles.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Update wrapper/token design docs for current DSKit APIs.

#### Change Summary
Replaced stale token names with current `DSSpatialToken`, `DSColorToken`, `DSSurfaceStyle`, `DSTypographyProtocol`, and `DSTypographyToken` guidance. Added generated screen catalog references.

#### Rationale
The old doc referenced older spacing, color, and typography APIs that no longer describe the current code.

#### Invariants
Keep wrapper guidance aligned with source types. Prefer semantic tokens for new wrapper work.

#### Tests Or Evidence
Checked current source APIs and ran Markdown validation.

#### Related Files
`Content/Appearance-in-DSKit.md`, `Content/Layout-in-DSKit.md`, `DSKit/Sources/DSKit/Designable`.

#### Follow-up Risks
Compatibility APIs still exist; call that out when legacy paths are intentionally used.
