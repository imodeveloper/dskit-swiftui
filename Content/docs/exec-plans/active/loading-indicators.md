# Loading Indicators

## Goal

Add the video-inspired loading indicator family as reusable DSKit components with live SwiftUI previews and snapshot-backed generated docs.

## Scope / Files

- Add a public DSKit loading indicator view and style enum.
- Add deterministic component snapshot coverage.
- Map the component into generated DSKit view documentation.

## Constraints

- Keep runtime previews animated, but snapshot examples deterministic.
- Keep colors theme-resolved and allow callers to pass custom tint/container colors.
- Regenerate generated docs from source and snapshots.

## Exit Criteria

- `DSLoadingIndicator` builds in the DSKit package.
- The component has an exact snapshot assertion and PNG golden.
- `Content/Views.md` and `Content/Views/DSLoadingIndicator.md` are generated from source.
- File-change memory is updated before commit.

## Validation Done

- Pending final build, snapshot recording, and docs generation. Paused before those steps per current instruction.
