# DSKit Quality & Guardrails

## Snapshot integrity

- Treat snapshot tests as a contract for public UI behavior.
- Keep renders deterministic:
  - avoid frame-rate, clock, network, and locale-driven instability in tested paths
  - prefer local fixtures over live network data in snapshot setup
  - avoid random ordering for any collection that is snapshot-covered
- Keep golden references under version control and pair visual updates with explicit intent notes.

## Golden principles for agent-friendly edits

1. Favor shared helpers over ad-hoc logic.
   - Central utilities in `DSKit/Sources/DSKit/Helpers` and `Designable` should be used before creating local alternatives.
2. Validate boundaries instead of guessing external data shapes.
   - If a component consumes external-like structures, type-check and sanitize at boundaries.
3. Keep style and sizing systems centralized.
4. Keep generated content (e.g., `Content/Views.md`) regenerated from source, not manually rewritten.

## Stability checks before broad refactors

- Confirm package boundaries (`DSKit`, `DSKitExplorer`, tests) still compile together.
- Confirm snapshot paths and fixture names remain valid.
- Confirm `Testable_*` screens/components continue to run in deterministic mode.

## Recurring cleanup

- If a recurring pattern causes repeated review churn (AI or human), convert it into a guardrail:
  - update docs
  - add/adjust tests
  - adjust generation scripts or shared helpers
- Prioritize small, frequent cleanup commits over large deferred refactors.
