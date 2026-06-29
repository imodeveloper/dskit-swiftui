# Agents Memory/ARCHITECTURE.md

- source_path: `Agents Memory/ARCHITECTURE.md`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 14:27:48 EEST (`pending`)

- task_or_issue: `documentation-system-audit`

#### Request
Review all repo documentation and make sure the architecture memory matches the current generated docs, platforms, and dependencies.

#### Change Summary
Updated the Content map to include generated component pages, usage index, screen index, and per-screen pages. Corrected platform notes to distinguish Package.swift support from Xcode project deployment targets, and corrected remote image dependencies from SDWebImage to Nuke/NukeUI.

#### Rationale
The architecture memory is a first-stop context file for agents. It must match the current documentation generator and package dependency reality or future agents will make stale assumptions.

#### Invariants
Keep this file as a high-level map. Preserve the distinction between package platforms and Xcode deployment targets. Keep generated documentation surfaces listed together.

#### Tests Or Evidence
Ran the documentation generator and a Markdown coverage/link validator over 155 Markdown files with zero broken checked relative links.

#### Related Files
`README.md`, `AGENTS.md`, `Scripts/generate_view_docs.py`, `Content/Views.md`, `Content/Screens.md`, `Package.swift`.

#### Follow-up Risks
If package platforms or dependencies change again, update this memory alongside README and workflow docs.
