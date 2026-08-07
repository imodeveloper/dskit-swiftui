# Agents Memory

This directory contains optional durable DSKit context. Routine component,
screen, snapshot, and documentation work should start from the nearest
`AGENTS.md`, target source, matching generated page, and focused snapshot.

## Routing

- Cross-project structure, package/app/test/doc ownership, or integration with
  Monitor: read `ARCHITECTURE.md`.
- Component-specific behavior: read `DSKit/AGENTS.md` and the target source.
- Documentation generation: read `Scripts/AGENTS.md` and `Content/AGENTS.md`.
- Workflow, quality, or active plans: use the matching document under
  `Content/docs/`; these are source documentation, not agent memory.

## Retention

- Add memory only for a durable cross-file decision that current code, tests,
  source comments, public docs, and Git cannot explain cheaply.
- Update the canonical topic in place and remove superseded instructions.
- Do not store task summaries, per-file journals, changelogs, raw test output,
  generated docs, screenshots, or completed handoffs.
- Use path-limited Git history for implementation chronology.

The former `CHANGELOG.md`, `File Changes/`, and per-file memory helper are
retired and must not be recreated.

Validate memory and routing changes with `Scripts/agent_memory_audit.sh`.
