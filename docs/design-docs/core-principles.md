# DSKit Core Principles

- Keep DSKit APIs stable in intent and naming across releases.
- Treat appearances, spacings, and typography as shared infrastructure, not per-screen hacks.
- Prefer reusable helpers in `Designable`, `Helpers`, and `Modifiers` over copy/paste in app code.
- Keep deterministic rendering as a first-class constraint for both components and screens.
- Keep visual docs aligned to implementation:
  - code in `DSKit/Sources/DSKit`
  - snapshots in `DSKitTests/__Snapshots__/DSKitTests`
  - generated docs in `Content/Views.md`
- For wrapper/token reasoning and styling systems, use `ds-wrapper-principles.md`.
