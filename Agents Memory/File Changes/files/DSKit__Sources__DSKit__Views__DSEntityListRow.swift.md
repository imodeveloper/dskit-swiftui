# DSKit/Sources/DSKit/Views/DSEntityListRow.swift

- source_path: `DSKit/Sources/DSKit/Views/DSEntityListRow.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-08-03 (`compact-accessory-matches-source-badge`)

- Compact external-link accessories use the label token so their visual size matches source badges in Monitor person rows.


### 2026-07-30 (`larger-compact-person-accessory`)

- Increases opt-in compact accessory symbols from `bodySmall` (14 points) to `bodyLarge` (18 points).
- Monitor uses this opt-in presentation only for person Wikipedia/Google accessories, providing the requested four-point increase without changing standard entity accessories.

### 2026-07-29 (`compact-entity-accessory`)

- Added a default-disabled compact accessory presentation that renders trailing symbols at `bodySmall` instead of `title2`.

### 2026-07-08 23:55:00 EEST (`pending`)

- task_or_issue: `Entity rows should be shorter and stable after Focus polish`

#### Request
Reduce person image containers by 10 percent, reduce source letter badges, and make people/source row heights fit their content better.

#### Change Summary
Tightened entity row heights and vertical padding, reduced the previously enlarged people avatar/container scale to 0.99x, and kept source rows on compact static sizing.

#### Rationale
The previous row geometry left too much vertical space for both people and sources after visual review.

#### Invariants
Keep row height stable during metadata updates and keep title sizing fixed; do not reintroduce animated title growth.

#### Tests Or Evidence
Targeted DSKit component tests passed; Monitor focus snapshots, full Monitor iOS tests, and dev/prod observations passed.

#### Related Files
Monitor `EntityListRowView.swift` supplies app-specific source badge scale on top of these DSKit row tokens.

### 2026-07-08 15:17:30 EEST (`pending`)

- task_or_issue: `Article details source navigation and Focus people/source polish`

#### Request
Stabilize article-detail preview/data behavior, add source navigation from article details, refine Focus people/source card visuals, and commit the current development branch changes.

#### Change Summary
Set people avatar size to 1.1x the base token, made row height configurable with a compact source-row option, reserved subtitle height for metadata updates, limited subtitles to two scalable lines, and removed title minimum-scale behavior.

#### Rationale
People rows needed larger but not oversized images, stable title and row size during metadata updates, and source rows needed a way to avoid inheriting the taller people-card height.

#### Invariants
Keep entity row title font fixed; do not reintroduce title scaling that changes apparent size during layout updates. Keep source rows on the compact height while people rows keep the default taller height.

#### Tests Or Evidence
`git diff --check` passed in `dskit-swiftui`; no build was run because the user explicitly requested not to build.

#### Related Files
`DSEntityCardListView.swift`, Monitor `PeopleCardsView.swift`.

#### Follow-up Risks
Snapshot/previews were not regenerated because the user asked not to build; update visual baselines if this ships through DSKit docs/tests.
