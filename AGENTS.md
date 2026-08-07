# Agent Instructions

## Repository Scope

- `DSKit/`: reusable SwiftUI design-system package.
- `DSKitExplorer/`: component and screen catalog app.
- `DSKitTests/` and `DSKitExplorerTests/`: component and screen snapshots.
- `Content/`: hand-written guidance plus generated component/screen docs.
- `Scripts/`: documentation and consistency tooling.
- `../imodeveloperlab/Workspace.xcworkspace` consumes this repository.

## Branch Rules

- Work on `development`; fetch and fast-forward from
  `origin/development` before new work when safe.
- `main` is release-only.
- Coordinate cross-repo validation and release tags when DSKit changes ship with
  Monitor or the website.
- Preserve unrelated working-tree changes.

## Load Context Just In Time

Read only the nearest guide for the task:

- DSKit component/API: `DSKit/AGENTS.md`
- Explorer screen: `DSKitExplorer/AGENTS.md`
- component snapshots: `DSKitTests/AGENTS.md`
- screen snapshots: `DSKitExplorerTests/AGENTS.md`
- generator/tooling: `Scripts/AGENTS.md`
- hand-written/generated docs: `Content/AGENTS.md`

Then inspect the target source and matching generated page or snapshot. Do not
preload every design, workflow, quality, plan, or memory document.

Open `Agents Memory/README.md` only when the task needs durable architecture
background. Start with the single routed document it names.

## Durable Memory

- `Agents Memory/README.md` is the compact routing index.
- `Agents Memory/ARCHITECTURE.md` is supporting architecture context, not a
  required read for routine file-scoped work.
- The legacy `Agents Memory/CHANGELOG.md`, `Agents Memory/File Changes/`,
  and per-file helper are retired. Do not recreate them.
- Use Git history for file chronology and source comments for narrow,
  non-obvious invariants.
- Add or update memory only for a durable cross-file decision that is expensive
  to reconstruct. Update the canonical topic instead of adding task summaries.
- After changing memory or routing, run
  `Scripts/agent_memory_audit.sh`.

## Project Workflow

### Component work

1. Read `DSKit/AGENTS.md` and the target file.
2. Read `Content/Views/<Component>.md` for public examples and Explorer usage.
3. Inspect the exact component snapshot.
4. Change source/tests, regenerate docs, and validate the focused snapshot.

### Explorer screen work

1. Read `DSKitExplorer/AGENTS.md` and the target screen.
2. Read `Content/Screens/<Screen>.md`.
3. Inspect matching snapshots before changing visual output.
4. Update source/snapshots, then regenerate docs.

### Generated documentation

- Do not hand-edit generated pages or generated frame/strip images.
- Change Swift source comments, testable examples, snapshots, or the generator.
- Run:

```sh
cd Scripts
./documentation_generator.sh
```

- The generator requires an exact component snapshot for every DSKit view and
  at least one snapshot for every generated Explorer screen.
- Generated links must remain relative and contain no local absolute paths.

## Runtime And Design Guardrails

- Preserve `List` virtualization. A `DSSection` must not wrap many logical
  rows in a container that SwiftUI treats as one giant cell.
- `DSList` owns inter-section spacing; `DSSection.dsSpacing` owns row spacing.
  Header sections use `.dsSectionRole(.header)` when appropriate.
- `DSHScroll` uses `dsScrollableContentMarginKey` for its inner alignment;
  do not reapply host `dsContentMarginKey` compensation.
- Keep `DSCoverFlow` on the UIKit scroll bridge and preserve current binding
  semantics. Use `FoodHomeScreen1` as the preview canary.
- Keep snapshots deterministic and update goldens only for intentional output.
- `DSAppearance` is the source for theme, spacing, typography, and semantic
  color tokens.

Read `DSKit/AGENTS.md` for the exact current contracts before editing any of
these components.

## Validation

Build:

```sh
xcodebuild -project DSKitExplorer.xcodeproj -scheme DSKitExplorer \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2' build
```

Other checks:

- Run the focused component/screen snapshot test for visual changes.
- Run the documentation generator after view, screen, or snapshot changes.
- Lint with `swiftlint lint --config swiftlint.yml`.
- Validate downstream Monitor in `../imodeveloperlab/Workspace.xcworkspace`
  when a public API, layout, binary, or integration behavior changes.

## Source Conventions

- Add comments only for durable design-system contracts, snapshot determinism,
  integration constraints, or a prior regression that code cannot express.
- Do not narrate obvious behavior or mention an agent/person making a change.
- Never use `Created by Codex`; use `Created by Ivan Borinschi` when a
  created-by header is required.
