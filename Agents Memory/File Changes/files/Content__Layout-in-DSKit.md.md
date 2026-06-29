# Content/Layout-in-DSKit.md

- source_path: `Content/Layout-in-DSKit.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Review hand-maintained docs and update stale layout guidance.

#### Change Summary
Rewrote the layout guide around current DSKit containers, `DSSpatialToken`, list/section spacing responsibilities, horizontal scroll margin behavior, and generated docs maintenance.

#### Rationale
The old page described older spacing names and did not point readers toward the generated component and screen catalogs.

#### Invariants
Keep this page conceptual and hand-maintained. Use generated component pages for exact APIs, examples, previews, and source links.

#### Tests Or Evidence
Checked current source APIs, ran Markdown validation, and confirmed links resolve locally.

#### Related Files
`Content/Views.md`, `Content/Screens.md`, `DSKit/Sources/DSKit/Views/DSList.swift`, `DSKit/Sources/DSKit/Views/DSSection.swift`, `DSKit/Sources/DSKit/Views/DSHScroll.swift`.

#### Follow-up Risks
If list spacing semantics change, update this page and the top-level AGENTS spacing notes together.
