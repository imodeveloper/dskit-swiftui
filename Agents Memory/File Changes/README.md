# File Change Memory

This folder stores agent-oriented rationale memory for meaningful file changes.

It is the primary required commit memory. `CHANGELOG.md` is legacy chronological memory and should not be used for normal file-scoped work.

## When To Read

Before editing a tracked source, config, test, script, or documentation file, search for its repo-relative path:

```sh
rg '<repo-relative-path>' 'Agents Memory/File Changes/files'
```

Read the newest matching entry first. Each source path has one bounded memory file under `files/`, with newest entries at the top.

## When To Write

Before commit + push, create or update per-file memory for meaningful changed tracked files:

```sh
Agents\ Memory/tools/agent_memory_file_changes.sh --check
Agents\ Memory/tools/agent_memory_file_changes.sh
```

Skip generated documentation, snapshots, build outputs, vendor checkouts, `.DS_Store`, and pure formatting-only churn unless the change intentionally documents behavior.

## Memory Limits

- One source path maps to one memory file in `files/`.
- Each memory file is capped at 300 lines.
- New entries are prepended at the top under `## Changes`.
- Older entries beyond the line cap are trimmed.

## Entry Schema

Each entry should be short and specific:

```md
# <repo-relative path>

- source_path: `<repo-relative path>`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### <YYYY-MM-DD HH:MM:SS TZ> (`<pending or short sha>`)

- task_or_issue: `<ticket, PR, or request label>`

#### Request
What was asked.

#### Change Summary
What changed in this file.

#### Rationale
Why this file needed that shape.

#### Invariants
What the next agent must preserve.

#### Tests Or Evidence
How the change was validated.

#### Related Files
Other files whose behavior is coupled to this one.

#### Follow-up Risks
Known risks, deferred work, or assumptions.
```

There is no global index. Search `files/` directly by repo-relative source path.
