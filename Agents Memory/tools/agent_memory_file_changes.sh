#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: agent_memory_file_changes.sh [--unstaged] [--commit <sha>] [--check]

Creates or checks bounded per-file agent memory for meaningful changed files.

Default input is staged changes:
  git diff --name-only --cached

Options:
  --unstaged      Use unstaged changes instead of staged changes.
  --commit <sha>  Use files changed by a commit.
  --check         Fail if a meaningful changed file has no per-file memory file.
USAGE
}

mode="staged"
commit_sha=""
check_only=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --unstaged)
      mode="unstaged"
      shift
      ;;
    --commit)
      if [[ $# -lt 2 ]]; then
        echo "error: --commit requires a sha" >&2
        exit 2
      fi
      mode="commit"
      commit_sha="$2"
      shift 2
      ;;
    --check)
      check_only=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

memory_root="Agents Memory/File Changes"
files_dir="$memory_root/files"
timestamp="$(date '+%Y-%m-%d %H:%M:%S %Z')"
max_lines=300

changed_files=()
collect_changed_files() {
  while IFS= read -r file; do
    [[ -n "$file" ]] && changed_files+=("$file")
  done
}

case "$mode" in
  staged)
    collect_changed_files < <(git diff --name-only --cached --diff-filter=ACMR)
    commit_label="pending"
    ;;
  unstaged)
    collect_changed_files < <(git diff --name-only --diff-filter=ACMR)
    commit_label="pending"
    ;;
  commit)
    collect_changed_files < <(git diff-tree --no-commit-id --name-only -r --diff-filter=ACMR "$commit_sha")
    commit_label="$(git rev-parse --short "$commit_sha")"
    ;;
esac

is_meaningful_file() {
  local path="$1"

  case "$path" in
    "Agents Memory/File Changes/"*) return 1 ;;
    "Agents Memory/CHANGELOG.md") return 1 ;;
    ".DS_Store"|*/.DS_Store) return 1 ;;
    DerivedData/*|build/*|.build/*|Build/*|dist/*|tmp/*|.tmp/*) return 1 ;;
    Carthage/*|Pods/*|vendor/*|node_modules/*) return 1 ;;
    Worktrees/*|*/SourcePackages/checkouts/*) return 1 ;;
    Content/Views.md) return 1 ;;
    DSKitTests/__Snapshots__/*|DSKitExplorerTests/__Snapshots__/*) return 1 ;;
    *.xcresult|*.xcarchive|*.ipa|*.app|*.dSYM|*.log) return 1 ;;
    *.png|*.jpg|*.jpeg|*.gif|*.webp|*.heic|*.pdf) return 1 ;;
  esac

  return 0
}

slug_for_path() {
  local path="$1"
  local slug="${path//\//__}"
  slug="$(printf '%s' "$slug" | tr -c 'A-Za-z0-9._-' '-')"
  printf '%s.md' "$slug"
}

record_path_for() {
  local path="$1"
  printf '%s/%s' "$files_dir" "$(slug_for_path "$path")"
}

existing_record_for() {
  local path="$1"
  local record_path
  record_path="$(record_path_for "$path")"
  [[ -f "$record_path" ]] && grep -Fqx -- "- source_path: \`$path\`" "$record_path"
}

trim_record() {
  local record_path="$1"
  local line_count
  line_count="$(wc -l < "$record_path" | tr -d ' ')"
  if [[ "$line_count" -le "$max_lines" ]]; then
    return 0
  fi

  tmp_record="$(mktemp)"
  head -n "$max_lines" "$record_path" > "$tmp_record"
  mv "$tmp_record" "$record_path"
}

latest_entry_has_commit() {
  local record_path="$1"
  local commit="$2"
  head -n 40 "$record_path" | grep -Eq -- "^### .+ \\(\`$commit\`\\)$" && return 0
  head -n 40 "$record_path" | grep -Fq -- "- commit: \`$commit\`"
}

create_record() {
  local path="$1"
  local record_path="$2"

  cat > "$record_path" <<EOF
# $path

- source_path: \`$path\`
- memory_limit: \`300 lines\`
- ordering: \`newest entries first\`

## Changes

### $timestamp (\`$commit_label\`)

- task_or_issue: \`TODO: ticket, PR, or request label\`

#### Request
TODO: what was asked.

#### Change Summary
TODO: what changed in this file.

#### Rationale
TODO: why this file needed that shape.

#### Invariants
TODO: what the next agent must preserve.

#### Tests Or Evidence
TODO: how the change was validated.

#### Related Files
TODO: other files whose behavior is coupled to this one.

#### Follow-up Risks
TODO: known risks, deferred work, or assumptions.
EOF
}

prepend_entry() {
  local path="$1"
  local record_path="$2"

  if latest_entry_has_commit "$record_path" "$commit_label"; then
    echo "Memory already has latest $commit_label entry for $path"
    return 0
  fi

  tmp_record="$(mktemp)"
  awk -v timestamp="$timestamp" -v commit_label="$commit_label" '
    {
      print
      if (!inserted && $0 == "## Changes") {
        print ""
        print "### " timestamp " (`" commit_label "`)"
        print ""
        print "- task_or_issue: `TODO: ticket, PR, or request label`"
        print ""
        print "#### Request"
        print "TODO: what was asked."
        print ""
        print "#### Change Summary"
        print "TODO: what changed in this file."
        print ""
        print "#### Rationale"
        print "TODO: why this file needed that shape."
        print ""
        print "#### Invariants"
        print "TODO: what the next agent must preserve."
        print ""
        print "#### Tests Or Evidence"
        print "TODO: how the change was validated."
        print ""
        print "#### Related Files"
        print "TODO: other files whose behavior is coupled to this one."
        print ""
        print "#### Follow-up Risks"
        print "TODO: known risks, deferred work, or assumptions."
        inserted=1
      }
    }
  ' "$record_path" > "$tmp_record"
  mv "$tmp_record" "$record_path"
  trim_record "$record_path"
  echo "Prepended $commit_label entry to $record_path"
}

missing=()
meaningful=()

if [[ ${#changed_files[@]} -gt 0 ]]; then
  for file in "${changed_files[@]}"; do
    if is_meaningful_file "$file"; then
      meaningful+=("$file")
      if ! existing_record_for "$file"; then
        missing+=("$file")
      fi
    fi
  done
fi

if [[ ${#meaningful[@]} -eq 0 ]]; then
  echo "No meaningful changed files need file-change memory."
  exit 0
fi

if [[ $check_only -eq 1 ]]; then
  if [[ ${#missing[@]} -gt 0 ]]; then
    echo "Missing file-change memory for:" >&2
    printf '  %s\n' "${missing[@]}" >&2
    exit 1
  fi
  echo "File-change memory exists for all meaningful changed files."
  exit 0
fi

mkdir -p "$files_dir"

for file in "${meaningful[@]}"; do
  record_path="$(record_path_for "$file")"
  if [[ -f "$record_path" ]]; then
    prepend_entry "$file" "$record_path"
  else
    create_record "$file" "$record_path"
    echo "Created $record_path"
  fi
  trim_record "$record_path"
done

if [[ ${#missing[@]} -eq 0 ]]; then
  echo "File-change memory already exists for all meaningful changed files."
fi
