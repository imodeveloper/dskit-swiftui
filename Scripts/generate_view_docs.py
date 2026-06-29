#!/usr/bin/env python3
"""Generate DSKit component reference docs from Swift source and Explorer usage."""

from __future__ import annotations

import re
import os
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional, Tuple


ROOT = Path(__file__).resolve().parents[1]
VIEW_SOURCE_DIR = ROOT / "DSKit" / "Sources" / "DSKit" / "Views"
EXPLORER_SCREENS_DIR = ROOT / "DSKitExplorer" / "Screens"
SNAPSHOT_DIR = ROOT / "DSKitTests" / "__Snapshots__" / "DSKitTests"
CONTENT_DIR = ROOT / "Content"
VIEW_DOCS_DIR = CONTENT_DIR / "Views"
INDEX_FILE = CONTENT_DIR / "Views.md"
USAGE_INDEX_FILE = VIEW_DOCS_DIR / "UsageIndex.md"

PRIORITY_COMPONENTS = [
    "DSVStack",
    "DSHStack",
    "DSGrid",
    "DSButton",
    "DSText",
    "DSHScroll",
    "DSCoverFlow",
    "DSImageView",
]

CATEGORY_ORDER = [
    "Layout and containers",
    "Text, forms, and controls",
    "Rows, cards, and content",
    "Visuals and affordances",
    "Other views",
]

CATEGORY_BY_COMPONENT = {
    "DSVStack": "Layout and containers",
    "DSHStack": "Layout and containers",
    "DSLazyVStack": "Layout and containers",
    "DSGrid": "Layout and containers",
    "DSHScroll": "Layout and containers",
    "DSCoverFlow": "Layout and containers",
    "DSTabPagingView": "Layout and containers",
    "DSList": "Layout and containers",
    "DSSection": "Layout and containers",
    "DSGroupedList": "Layout and containers",
    "DSBottomContainer": "Layout and containers",
    "DSCardSurface": "Layout and containers",
    "DSCardAccessory": "Layout and containers",
    "DSContentCard": "Layout and containers",
    "DSOffsetObservingScrollView": "Layout and containers",
    "DSText": "Text, forms, and controls",
    "DSTextField": "Text, forms, and controls",
    "DSButton": "Text, forms, and controls",
    "DSSFSymbolButton": "Text, forms, and controls",
    "DSToolbarSFSymbolButton": "Text, forms, and controls",
    "DSPickerView": "Text, forms, and controls",
    "DSRadioPickerView": "Text, forms, and controls",
    "DSQuantityPicker": "Text, forms, and controls",
    "DSTermsAndConditions": "Text, forms, and controls",
    "DSArticleRows": "Rows, cards, and content",
    "DSAuthorView": "Rows, cards, and content",
    "DSEntityRow": "Rows, cards, and content",
    "DSEntityCardRow": "Rows, cards, and content",
    "DSMetadataRow": "Rows, cards, and content",
    "DSThread": "Rows, cards, and content",
    "DSSectionHeaderView": "Rows, cards, and content",
    "DSInfoCallout": "Rows, cards, and content",
    "DSFloatingBannerView": "Rows, cards, and content",
    "DSImageView": "Visuals and affordances",
    "DSDivider": "Visuals and affordances",
    "DSChevronView": "Visuals and affordances",
    "DSChipsView": "Visuals and affordances",
    "DSIconBadgeView": "Visuals and affordances",
    "DSInlineTagView": "Visuals and affordances",
    "DSLetterBadgeView": "Visuals and affordances",
    "DSListSeparatorView": "Visuals and affordances",
    "DSPriceView": "Visuals and affordances",
    "DSRatingView": "Visuals and affordances",
    "DSRelativeTimeTag": "Visuals and affordances",
    "DSScrollAnchorAffordance": "Visuals and affordances",
}


@dataclass(frozen=True)
class ComponentDoc:
    name: str
    source_path: Path
    page_path: Path
    snapshot_path: Optional[Path]
    documentation_lines: List[str]
    example: Optional[str]
    explorer_usage: List[Path]
    related_components: List[str]


def rel_link(target: Path, from_dir: Path) -> str:
    return Path(os.path.relpath(target, from_dir)).as_posix()


def repo_path(target: Path) -> str:
    return target.relative_to(ROOT).as_posix()


def component_sort_key(path: Path) -> Tuple[int, object]:
    name = path.stem
    if name in PRIORITY_COMPONENTS:
        return (0, PRIORITY_COMPONENTS.index(name))
    return (1, name)


def word_pattern(name: str) -> re.Pattern[str]:
    return re.compile(rf"(?<![A-Za-z0-9_]){re.escape(name)}(?![A-Za-z0-9_])")


def clean_comment_lines(source: str, component_name: str) -> List[str]:
    match = re.search(r"/\*(.*?)\*/", source, flags=re.DOTALL)
    if not match:
        return []

    lines: List[str] = []
    for raw_line in match.group(1).splitlines():
        line = raw_line.strip()
        if line.startswith("*"):
            line = line[1:].strip()
        lines.append(line.rstrip())

    while lines and not lines[0]:
        lines.pop(0)
    while lines and not lines[-1]:
        lines.pop()

    if lines and re.match(rf"^#+\s+`?{re.escape(component_name)}`?\s*$", lines[0].strip()):
        lines.pop(0)
        while lines and not lines[0]:
            lines.pop(0)

    return lines


def extract_testable_example(source: str, component_name: str) -> Optional[str]:
    matches = list(re.finditer(r"(?:private\s+)?struct\s+Testable_[A-Za-z0-9_]*\s*:\s*View\s*\{", source))
    if not matches:
        return None

    preferred = next((match for match in matches if component_name in match.group(0)), matches[0])
    start = preferred.start()
    opening_brace = source.find("{", preferred.start())
    if opening_brace == -1:
        return None

    depth = 0
    for index in range(opening_brace, len(source)):
        char = source[index]
        if char == "{":
            depth += 1
        elif char == "}":
            depth -= 1
            if depth == 0:
                return source[start : index + 1].strip()

    return None


def purpose_line(lines: List[str], component_name: str) -> str:
    for line in lines:
        stripped = line.strip()
        if not stripped or stripped.startswith("#") or stripped.startswith("-"):
            continue
        stripped = re.sub(r"\s+", " ", stripped)
        return stripped
    return f"`{component_name}` is a DSKit SwiftUI view. Add source documentation to expand this generated reference."


def table_cell(value: str) -> str:
    return value.replace("|", "\\|").replace("\n", " ")


def find_explorer_usage(component_name: str) -> List[Path]:
    pattern = word_pattern(component_name)
    usage: List[Path] = []
    for path in sorted(EXPLORER_SCREENS_DIR.glob("*.swift")):
        if pattern.search(path.read_text(encoding="utf-8")):
            usage.append(path)
    return usage


def find_related_components(
    source: str,
    example: Optional[str],
    component_name: str,
    all_names: List[str],
) -> List[str]:
    haystack = source
    if example:
        haystack += "\n" + example
    related = [
        name
        for name in all_names
        if name != component_name and word_pattern(name).search(haystack)
    ]
    return sorted(related)


def build_component_docs() -> List[ComponentDoc]:
    source_paths = sorted(VIEW_SOURCE_DIR.glob("*.swift"), key=component_sort_key)
    all_names = sorted(path.stem for path in source_paths)
    docs: List[ComponentDoc] = []

    for source_path in source_paths:
        source = source_path.read_text(encoding="utf-8")
        component_name = source_path.stem
        snapshot_path = SNAPSHOT_DIR / f"{component_name}.snapshot.png"
        example = extract_testable_example(source, component_name)
        docs.append(
            ComponentDoc(
                name=component_name,
                source_path=source_path,
                page_path=VIEW_DOCS_DIR / f"{component_name}.md",
                snapshot_path=snapshot_path if snapshot_path.exists() else None,
                documentation_lines=clean_comment_lines(source, component_name),
                example=example,
                explorer_usage=find_explorer_usage(component_name),
                related_components=find_related_components(source, example, component_name, all_names),
            )
        )

    return docs


def write_component_page(doc: ComponentDoc) -> None:
    lines: List[str] = [
        f"# {doc.name}",
        "",
        "> Generated by `Scripts/documentation_generator.sh`. Edit the Swift source comment or generator instead of this file.",
        "",
        "## Reference",
        "",
        f"- Source: [{repo_path(doc.source_path)}]({rel_link(doc.source_path, doc.page_path.parent)})",
        f"- Full usage map: [UsageIndex.md#{doc.name.lower()}](UsageIndex.md#{doc.name.lower()})",
        f"- Explorer usage: {len(doc.explorer_usage)} screen file{'s' if len(doc.explorer_usage) != 1 else ''}",
    ]

    if doc.snapshot_path:
        snapshot_link = rel_link(doc.snapshot_path, doc.page_path.parent)
        lines.append(f"- Snapshot: [{doc.snapshot_path.name}]({snapshot_link})")
    else:
        lines.append("- Snapshot: not available")

    lines.extend(["", "## Overview", ""])
    if doc.documentation_lines:
        lines.extend(doc.documentation_lines)
    else:
        lines.append(purpose_line(doc.documentation_lines, doc.name))

    lines.extend(["", "## Example", ""])
    if doc.example:
        lines.extend(["```swift", doc.example, "```"])
    else:
        lines.append("No `Testable_*` example is available in the source file yet.")

    lines.extend(["", "## Snapshot", ""])
    if doc.snapshot_path:
        snapshot_link = rel_link(doc.snapshot_path, doc.page_path.parent)
        lines.append(f'<img src="{snapshot_link}" width="35%" alt="{doc.name} snapshot" />')
    else:
        lines.append("No component snapshot image is available yet.")

    lines.extend(["", "## DSKitExplorer Usage", ""])
    if doc.explorer_usage:
        for usage_path in doc.explorer_usage[:10]:
            usage_link = rel_link(usage_path, doc.page_path.parent)
            lines.append(f"- [{repo_path(usage_path)}]({usage_link})")
        if len(doc.explorer_usage) > 10:
            lines.append(f"- See [UsageIndex.md#{doc.name.lower()}](UsageIndex.md#{doc.name.lower()}) for {len(doc.explorer_usage) - 10} more references.")
    else:
        lines.append("No direct `DSKitExplorer/Screens` usage was found.")

    lines.extend(["", "## Related Components", ""])
    if doc.related_components:
        related_links = [f"[{name}]({name}.md)" for name in doc.related_components[:12]]
        lines.append(", ".join(related_links))
    else:
        lines.append("No related DSKit view references were detected in the source file.")

    doc.page_path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def write_usage_index(docs: List[ComponentDoc]) -> None:
    lines: List[str] = [
        "# DSKitExplorer Usage Index",
        "",
        "> Generated by `Scripts/documentation_generator.sh`. This file is exhaustive for direct references in `DSKitExplorer/Screens/*.swift`.",
        "",
        "## Component Summary",
        "",
        "| Component | Explorer screen files |",
        "| --- | ---: |",
    ]

    for doc in docs:
        lines.append(f"| [{doc.name}]({doc.name}.md) | {len(doc.explorer_usage)} |")

    for doc in docs:
        lines.extend(["", f"## {doc.name}", ""])
        if doc.explorer_usage:
            for usage_path in doc.explorer_usage:
                usage_link = rel_link(usage_path, USAGE_INDEX_FILE.parent)
                lines.append(f"- [{repo_path(usage_path)}]({usage_link})")
        else:
            lines.append("No direct `DSKitExplorer/Screens` usage was found.")

    USAGE_INDEX_FILE.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def category_for(component_name: str) -> str:
    return CATEGORY_BY_COMPONENT.get(component_name, "Other views")


def write_main_index(docs: List[ComponentDoc]) -> None:
    lines: List[str] = [
        "# DSKit Views and Components",
        "",
        "> Generated by `Scripts/documentation_generator.sh`. Use this page as the table of contents for DSKit view docs.",
        "",
        "## Agent Quick Start",
        "",
        "- Start here to find the DSKit view you need, then open its dedicated page.",
        "- Use [Views/UsageIndex.md](Views/UsageIndex.md) for exhaustive `DSKitExplorer/Screens` references.",
        "- Component pages include source links, examples, snapshots when available, curated Explorer usage, and related components.",
        "- Generated files should be refreshed from source comments and snapshots, not edited by hand.",
        "",
        "## Quick Links",
        "",
    ]

    for doc in docs:
        lines.append(f"- [{doc.name}](Views/{doc.name}.md)")

    lines.extend(["", "## Component Catalog", ""])

    docs_by_category: Dict[str, List[ComponentDoc]] = {category: [] for category in CATEGORY_ORDER}
    for doc in docs:
        docs_by_category.setdefault(category_for(doc.name), []).append(doc)

    for category in CATEGORY_ORDER:
        category_docs = docs_by_category.get(category, [])
        if not category_docs:
            continue
        lines.extend([
            f"### {category}",
            "",
            "| Component | Purpose | Source | Snapshot | Explorer usage |",
            "| --- | --- | --- | --- | ---: |",
        ])
        for doc in category_docs:
            source_link = rel_link(doc.source_path, INDEX_FILE.parent)
            snapshot_value = "Yes" if doc.snapshot_path else "No"
            lines.append(
                "| "
                f"[{doc.name}](Views/{doc.name}.md) | "
                f"{table_cell(purpose_line(doc.documentation_lines, doc.name))} | "
                f"[source]({source_link}) | "
                f"{snapshot_value} | "
                f"{len(doc.explorer_usage)} |"
            )
        lines.append("")

    lines.extend([
        "## Maintenance",
        "",
        "- Refresh these docs with `cd Scripts && ./documentation_generator.sh`.",
        "- Update source comments and `Testable_*` examples in `DSKit/Sources/DSKit/Views` to improve generated pages.",
        "- Snapshot image links resolve to `DSKitTests/__Snapshots__/DSKitTests`.",
        "- Explorer usage references are direct word-boundary matches in `DSKitExplorer/Screens/*.swift`.",
    ])

    INDEX_FILE.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def main() -> None:
    VIEW_DOCS_DIR.mkdir(parents=True, exist_ok=True)
    for old_markdown in VIEW_DOCS_DIR.glob("*.md"):
        old_markdown.unlink()

    docs = build_component_docs()
    for doc in docs:
        write_component_page(doc)
    write_usage_index(docs)
    write_main_index(docs)

    print(f"Generated {len(docs)} component pages")
    print(f"Wrote {INDEX_FILE.relative_to(ROOT)}")
    print(f"Wrote {USAGE_INDEX_FILE.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
