# DSKit/Sources/DSKit/Modifiers/DSCornerRadiusModifier.swift

- source_path: `DSKit/Sources/DSKit/Modifiers/DSCornerRadiusModifier.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-07-16 19:00:05 EEST (`nested-card-corner-floor`)

- task_or_issue: `Nested surfaces must not collapse to an excessively sharp radius`

#### Request
Preserve the current requested nested-corner adjustment while delivering and validating the UI changes.

#### Change Summary
Raised the nested radius floor from a fixed 2 points to `min(6, appearance.cornerRadius)`.

#### Rationale
Subtracting parent padding can otherwise make nested cards visually inconsistent with the active appearance.

#### Invariants
Continue deriving nested radius from parent radius and padding; keep the floor capped by the appearance radius.

#### Tests Or Evidence
The full DSKit component suite and full Monitor test suite passed; the affected DSKeyValueRow snapshot was visually reviewed.

#### Related Files
`DSCardStyle`, `DSKeyValueRow.snapshot.png`, and any nested DS surface.

#### Follow-up Risks
Global corner behavior can affect snapshots even when the component source itself is unchanged.
