#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$repo_root"
memory_dir="$repo_root/Agents Memory"
max_index_lines=80
max_topic_lines=250
max_total_lines=2000
max_agents_lines=220
errors=0

fail() {
  echo "error: $*" >&2
  errors=$((errors + 1))
}

if [[ ! -d "$memory_dir" ]]; then
  echo "No Agents Memory directory; nothing to audit."
  exit 0
fi

[[ -f "$memory_dir/README.md" ]] || fail "Agents Memory/README.md is missing"
[[ ! -f "$memory_dir/CHANGELOG.md" ]] || fail "retired Agents Memory/CHANGELOG.md exists"

if [[ -d "$memory_dir/File Changes" ]] &&
   [[ -n "$(find "$memory_dir/File Changes" -type f ! -name '.DS_Store' -print -quit)" ]]; then
  fail "retired Agents Memory/File Changes contains files"
fi

if [[ -f "$memory_dir/README.md" ]]; then
  index_lines="$(wc -l < "$memory_dir/README.md" | tr -d ' ')"
  (( index_lines <= max_index_lines )) ||
    fail "memory index has $index_lines lines; limit is $max_index_lines"
fi

total_lines=0
for file in "$memory_dir"/*.md; do
  [[ -e "$file" ]] || continue
  lines="$(wc -l < "$file" | tr -d ' ')"
  total_lines=$((total_lines + lines))
  if [[ "$(basename "$file")" != "README.md" ]]; then
    (( lines <= max_topic_lines )) ||
      fail "$(basename "$file") has $lines lines; limit is $max_topic_lines"
    grep -q '^- Status:' "$file" || fail "$(basename "$file") lacks Status metadata"
    grep -q '^- Read when:' "$file" || fail "$(basename "$file") lacks Read when metadata"
    grep -q '^- Last reviewed:' "$file" || fail "$(basename "$file") lacks Last reviewed metadata"
  fi
done

(( total_lines <= max_total_lines )) ||
  fail "top-level memory has $total_lines lines; limit is $max_total_lines"

agents_lines="$(wc -l < "$repo_root/AGENTS.md" | tr -d ' ')"
(( agents_lines <= max_agents_lines )) ||
  fail "AGENTS.md has $agents_lines lines; limit is $max_agents_lines"

if rg -n '/Users/[^/]+/' "$repo_root/AGENTS.md" "$memory_dir" \
  -g '*.md' >/dev/null; then
  fail "personal absolute path found in AGENTS.md or memory"
fi

check_markdown_paths() {
  local source="$1"
  local source_dir
  local path
  source_dir="$(dirname "$source")"

  while IFS= read -r path; do
    [[ -n "$path" ]] || continue
    [[ "$path" != *'<'* && "$path" != *'>'* && "$path" != *'*'* ]] || continue
    [[ "$path" != "CHANGELOG.md" && "$path" != "Agents Memory/CHANGELOG.md" ]] || continue
    [[ "$path" != com.* ]] || continue
    [[ -e "$repo_root/$path" || -e "$source_dir/$path" ]] ||
      fail "${source#"$repo_root/"} routes to missing $path"
  done < <(rg -o '`[^`]+\.md`' "$source" | tr -d '`' | sort -u)
}

check_markdown_paths "$repo_root/AGENTS.md"
check_markdown_paths "$memory_dir/README.md"

if rg -n 'update Agents Memory/CHANGELOG|add .*Agents Memory/CHANGELOG|agent_memory_file_changes\.sh' \
  "$repo_root" -g '!Build/reports/**' -g '!**/agent_memory_audit.sh' >/dev/null; then
  fail "active source still requires a retired memory journal"
fi

if find "$memory_dir" -type f \( -name '*.p8' -o -name '*.pem' -o \
  -name '*.p12' -o -name '*.mobileprovision' \) -print -quit | grep -q .; then
  fail "credential-like file found in memory"
fi

if (( errors > 0 )); then
  echo "Agent memory audit failed with $errors issue(s)." >&2
  exit 1
fi

topic_count="$(find "$memory_dir" -maxdepth 1 -type f -name '*.md' | wc -l | tr -d ' ')"
echo "Agent memory audit passed: $topic_count documents, $total_lines lines."
