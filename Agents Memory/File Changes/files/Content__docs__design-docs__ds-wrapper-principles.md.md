# Content/docs/design-docs/ds-wrapper-principles.md

- source_path: `Content/docs/design-docs/ds-wrapper-principles.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 15:49:34 EEST (`pending`)

- task_or_issue: `move-root-docs-under-content`

#### Request
Move the root `docs/` folder into `Content/` and update references.

#### Change Summary
Moved the DS wrapper principles guide from `docs/design-docs/ds-wrapper-principles.md` to `Content/docs/design-docs/ds-wrapper-principles.md`.

#### Rationale
Wrapper/token rationale should live under the unified `Content/` documentation tree.

#### Invariants
Keep wrapper guidance aligned with source types and semantic token APIs.

#### Tests Or Evidence
Validated local Markdown links, ran staged whitespace validation, and ran the file-change memory check.

#### Related Files
`Content/docs/design-docs/core-principles.md`, `Content/Appearance-in-DSKit.md`, `Content/Layout-in-DSKit.md`.

#### Follow-up Risks
Compatibility APIs still exist; call that out when legacy paths are intentionally used.

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
