# Scripts/documentation_generator.sh

- source_path: `Scripts/documentation_generator.sh`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 13:40:34 EEST (`pending`)

- task_or_issue: `agent-friendly-component-docs`

#### Request
Replace the old monolithic `Views.md` generator with a deterministic generator that writes an index, component pages, and usage index.

#### Change Summary
Reduced the shell script to a strict zsh wrapper that resolves its script directory and invokes `python3 Scripts/generate_view_docs.py`.

#### Rationale
Keeping parsing and Markdown generation in Python makes the generator easier to test and extend while preserving the existing `Scripts/documentation_generator.sh` command used by repo workflows.

#### Invariants
Keep the shell entrypoint executable. Do not reintroduce complex Markdown generation logic in the wrapper.

#### Tests Or Evidence
Ran `cd Scripts && ./documentation_generator.sh` and confirmed it generated 45 component pages, `Content/Views.md`, and `Content/Views/UsageIndex.md`.

#### Related Files
`Scripts/generate_view_docs.py`, `Content/Views.md`, `Content/Views/*.md`, `Content/Views/UsageIndex.md`.

#### Follow-up Risks
Generator failures now surface through Python, so Python 3 availability remains a requirement for docs generation.
