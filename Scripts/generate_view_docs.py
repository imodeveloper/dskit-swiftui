#!/usr/bin/env python3
"""Generate DSKit component reference docs from Swift source and Explorer usage."""

from __future__ import annotations

import re
import os
import struct
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional, Tuple

try:
    from PIL import Image, ImageDraw, PngImagePlugin
except ModuleNotFoundError as error:
    raise SystemExit(
        "Scripts/generate_view_docs.py requires Pillow to build screen preview PNGs. "
        "Install it with `python3 -m pip install Pillow`, then rerun `cd Scripts && ./documentation_generator.sh`."
    ) from error


ROOT = Path(__file__).resolve().parents[1]
VIEW_SOURCE_DIR = ROOT / "DSKit" / "Sources" / "DSKit" / "Views"
EXPLORER_SCREENS_DIR = ROOT / "DSKitExplorer" / "Screens"
SNAPSHOT_DIR = ROOT / "DSKitTests" / "__Snapshots__" / "DSKitTests"
EXPLORER_SNAPSHOT_DIR = ROOT / "DSKitExplorerTests" / "__Snapshots__" / "DSKitExplorerTests"
CONTENT_DIR = ROOT / "Content"
VIEW_DOCS_DIR = CONTENT_DIR / "Views"
SCREEN_DOCS_DIR = CONTENT_DIR / "Screens"
SCREEN_FRAME_DIR = SCREEN_DOCS_DIR / "Frames"
SCREEN_GROUP_DIR = SCREEN_DOCS_DIR / "Groups"
INDEX_FILE = CONTENT_DIR / "Views.md"
USAGE_INDEX_FILE = VIEW_DOCS_DIR / "UsageIndex.md"
SCREEN_INDEX_FILE = CONTENT_DIR / "Screens.md"
PAGE_PREVIEW_WIDTH = "60%"
INDEX_PREVIEW_WIDTH = "240"
SCREEN_GROUP_ROW_SIZE = 5
SCREEN_GROUP_PHONE_HEIGHT = 1224
SCREEN_GROUP_GAP = 64
SCREEN_GROUP_MARGIN = 48
SCREEN_FRAME_SUFFIX = ".framed.png"
SCREEN_GROUP_SUFFIX = ".strip.png"
IPHONE_FRAME_DEVICE_NAME = "iPhone 15 Pro"
IPHONE_FRAME_MODEL_IDENTIFIER = "iPhone16,1"
IPHONE_FRAME_CHROME_IDENTIFIER = "screen-only"
IPHONE_FRAME_SENSOR_BAR = "sensor_bar_class_04"
IPHONE_FRAME_SCALE = 3
IPHONE_FRAME_SCREEN_SIZE = (1179, 2556)
IPHONE_FRAME_SCREEN_POINTS = (393, 852)
IPHONE_FRAME_SCREEN_CORNER_RADIUS_POINTS = 55
IPHONE_FRAME_SENSOR_BAR_POINTS = (393, 47)

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

DOC_KIND_ORDER = [
    "Primitives",
    "Components",
]

PRIMITIVE_COMPONENTS = {
    "DSVStack",
    "DSHStack",
    "DSLazyVStack",
    "DSGrid",
    "DSHScroll",
    "DSList",
    "DSSection",
    "DSGroupedList",
    "DSOffsetObservingScrollView",
    "DSText",
    "DSTextField",
    "DSButton",
    "DSSFSymbolButton",
    "DSToolbarSFSymbolButton",
    "DSImageView",
    "DSDivider",
    "DSChevronView",
    "DSChipsView",
    "DSCardSurface",
    "DSCardAccessory",
    "DSIconBadgeView",
    "DSInlineTagView",
    "DSLetterBadgeView",
    "DSListSeparatorView",
    "DSMetadataRow",
    "DSRelativeTimeTag",
    "DSScrollAnchorAffordance",
}

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

SCREEN_FAMILY_ORDER = [
    "Food",
    "Booking",
    "Home",
    "Gallery",
    "Authentication",
    "Profile",
    "Commerce",
    "News",
    "About",
    "Playgrounds",
    "Other screens",
]

PLAYGROUND_SCREENS = [
    "DesignTokensPlaygroundScreen",
    "DynamicTypePlaygroundScreen",
]


@dataclass(frozen=True)
class ComponentDoc:
    name: str
    source_path: Path
    page_path: Path
    preview_path: Path
    doc_kind: str
    documentation_lines: List[str]
    example: Optional[str]
    explorer_usage: List[Path]
    related_components: List[str]


@dataclass(frozen=True)
class ScreenDoc:
    name: str
    source_path: Path
    page_path: Path
    snapshot_paths: List[Path]
    family: str
    example: Optional[str]
    used_components: List[str]


def rel_link(target: Path, from_dir: Path) -> str:
    return Path(os.path.relpath(target, from_dir)).as_posix()


def repo_path(target: Path) -> str:
    return target.relative_to(ROOT).as_posix()


def component_sort_key(path: Path) -> Tuple[int, object]:
    name = path.stem
    if name in PRIORITY_COMPONENTS:
        return (0, PRIORITY_COMPONENTS.index(name))
    return (1, name)


def natural_key(value: str) -> Tuple[object, ...]:
    return tuple(int(part) if part.isdigit() else part for part in re.split(r"(\d+)", value))


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


def extract_named_struct(source: str, struct_name: str) -> Optional[str]:
    match = re.search(rf"(?:private\s+)?struct\s+{re.escape(struct_name)}\b[^\{{]*\{{", source)
    if not match:
        return None

    start = match.start()
    opening_brace = source.find("{", match.start())
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


def screen_family_for(screen_name: str) -> str:
    if screen_name.startswith("Food"):
        return "Food"
    if screen_name.startswith("Booking"):
        return "Booking"
    if screen_name.startswith("Home"):
        return "Home"
    if screen_name.startswith("ImageGallery"):
        return "Gallery"
    if screen_name.startswith("LogIn") or screen_name.startswith("SignUp"):
        return "Authentication"
    if screen_name.startswith("Profile"):
        return "Profile"
    if screen_name.startswith("News") or screen_name.startswith("Notifications"):
        return "News"
    if screen_name.startswith("About"):
        return "About"
    if screen_name in PLAYGROUND_SCREENS:
        return "Playgrounds"
    if screen_name.startswith((
        "Cart",
        "Categories",
        "Filters",
        "ItemDetails",
        "Items",
        "Order",
        "Payment",
        "Shipping",
    )):
        return "Commerce"
    return "Other screens"


def screen_sort_key(doc: ScreenDoc) -> Tuple[int, Tuple[object, ...]]:
    try:
        family_index = SCREEN_FAMILY_ORDER.index(doc.family)
    except ValueError:
        family_index = len(SCREEN_FAMILY_ORDER)
    return (family_index, natural_key(doc.name))


def find_screen_snapshots(screen_name: str) -> List[Path]:
    exact = EXPLORER_SNAPSHOT_DIR / f"{screen_name}.snapshot.png"
    prefixed = sorted(EXPLORER_SNAPSHOT_DIR.glob(f"{screen_name}_*.snapshot.png"))
    snapshots: List[Path] = []
    if exact.exists():
        snapshots.append(exact)
    snapshots.extend(path for path in prefixed if path != exact)
    return snapshots


def png_dimensions(path: Path) -> Tuple[int, int]:
    header = path.read_bytes()[:24]
    png_signature = b"\x89PNG\r\n\x1a\n"
    if len(header) < 24 or header[:8] != png_signature or header[12:16] != b"IHDR":
        raise SystemExit(f"Expected a PNG snapshot image: {repo_path(path)}")
    return struct.unpack(">II", header[16:24])


def framed_screen_path(snapshot_path: Path) -> Path:
    if snapshot_path.name.endswith(".snapshot.png"):
        frame_name = snapshot_path.name.removesuffix(".snapshot.png") + SCREEN_FRAME_SUFFIX
    else:
        frame_name = snapshot_path.stem + SCREEN_FRAME_SUFFIX
    return SCREEN_FRAME_DIR / frame_name


def screen_group_slug(family: str) -> str:
    slug = re.sub(r"[^a-z0-9]+", "-", family.lower()).strip("-")
    return slug or "screens"


def screen_group_path(family: str, row_index: int) -> Path:
    return SCREEN_GROUP_DIR / f"{screen_group_slug(family)}-{row_index + 1}{SCREEN_GROUP_SUFFIX}"


def scaled_point(value: float) -> float:
    return value * IPHONE_FRAME_SCALE


def screen_frame_output_size() -> Tuple[int, int]:
    return IPHONE_FRAME_SCREEN_SIZE


def screen_frame_content_origin() -> Tuple[int, int]:
    return (0, 0)


def screen_frame_metadata() -> str:
    return (
        f"{IPHONE_FRAME_DEVICE_NAME}; model={IPHONE_FRAME_MODEL_IDENTIFIER}; "
        f"chrome={IPHONE_FRAME_CHROME_IDENTIFIER}; screen={IPHONE_FRAME_SCREEN_SIZE[0]}x{IPHONE_FRAME_SCREEN_SIZE[1]}px; "
        f"points={IPHONE_FRAME_SCREEN_POINTS[0]}x{IPHONE_FRAME_SCREEN_POINTS[1]}pt; scale={IPHONE_FRAME_SCALE}; "
        f"screenCornerRadius={IPHONE_FRAME_SCREEN_CORNER_RADIUS_POINTS}pt; "
        f"sensorBar={IPHONE_FRAME_SENSOR_BAR} ({IPHONE_FRAME_SENSOR_BAR_POINTS[0]}x{IPHONE_FRAME_SENSOR_BAR_POINTS[1]}pt)"
    )


def write_screen_frame(snapshot_path: Path) -> Path:
    screen_width, screen_height = png_dimensions(snapshot_path)
    if (screen_width, screen_height) != IPHONE_FRAME_SCREEN_SIZE:
        raise SystemExit(
            f"Screen snapshot {repo_path(snapshot_path)} is {screen_width}x{screen_height}, "
            f"but generated {IPHONE_FRAME_DEVICE_NAME} frames require "
            f"{IPHONE_FRAME_SCREEN_SIZE[0]}x{IPHONE_FRAME_SCREEN_SIZE[1]} snapshots. "
            "Update `SnapshotLayout.screen` or add a matching frame profile."
        )

    frame_path = framed_screen_path(snapshot_path)
    view_width, view_height = screen_frame_output_size()
    screen_x, screen_y = screen_frame_content_origin()
    screen_radius = scaled_point(IPHONE_FRAME_SCREEN_CORNER_RADIUS_POINTS)
    canvas = Image.new("RGBA", (view_width, view_height), (0, 0, 0, 0))

    snapshot_image = Image.open(snapshot_path).convert("RGBA")
    screen_mask = Image.new("L", (screen_width, screen_height), 0)
    screen_mask_draw = ImageDraw.Draw(screen_mask)
    screen_mask_draw.rounded_rectangle(
        (0, 0, screen_width, screen_height),
        radius=screen_radius,
        fill=255,
    )
    canvas.paste(snapshot_image, (screen_x, screen_y), screen_mask)

    png_info = PngImagePlugin.PngInfo()
    png_info.add_text("Description", screen_frame_metadata())
    canvas.save(frame_path, pnginfo=png_info, optimize=True)
    return frame_path


def write_screen_frames(docs: List["ScreenDoc"]) -> int:
    SCREEN_FRAME_DIR.mkdir(parents=True, exist_ok=True)
    for old_frame in list(SCREEN_FRAME_DIR.glob("*.framed.svg")) + list(SCREEN_FRAME_DIR.glob("*.framed.png")):
        old_frame.unlink()

    written = 0
    seen: set[Path] = set()
    for doc in docs:
        for snapshot_path in doc.snapshot_paths:
            if snapshot_path in seen:
                continue
            write_screen_frame(snapshot_path)
            seen.add(snapshot_path)
            written += 1
    return written


def write_screen_group_preview(family: str, row_index: int, row_docs: List["ScreenDoc"]) -> Path:
    SCREEN_GROUP_DIR.mkdir(parents=True, exist_ok=True)
    source_width, source_height = screen_frame_output_size()
    phone_width = round(source_width * (SCREEN_GROUP_PHONE_HEIGHT / source_height))
    canvas_width = (
        (SCREEN_GROUP_ROW_SIZE * phone_width)
        + ((SCREEN_GROUP_ROW_SIZE - 1) * SCREEN_GROUP_GAP)
        + (SCREEN_GROUP_MARGIN * 2)
    )
    canvas_height = SCREEN_GROUP_PHONE_HEIGHT + (SCREEN_GROUP_MARGIN * 2)
    canvas = Image.new("RGBA", (canvas_width, canvas_height), (0, 0, 0, 0))

    for slot, doc in enumerate(row_docs):
        frame = Image.open(framed_screen_path(doc.snapshot_paths[0])).convert("RGBA")
        resized = frame.resize((phone_width, SCREEN_GROUP_PHONE_HEIGHT), Image.Resampling.LANCZOS)
        x = SCREEN_GROUP_MARGIN + (slot * (phone_width + SCREEN_GROUP_GAP))
        canvas.alpha_composite(resized, (x, SCREEN_GROUP_MARGIN))

    png_info = PngImagePlugin.PngInfo()
    screen_names = ", ".join(doc.name for doc in row_docs)
    png_info.add_text("Description", f"{family} DSKitExplorer screen previews: {screen_names}")
    group_path = screen_group_path(family, row_index)
    canvas.save(group_path, pnginfo=png_info, optimize=True)
    return group_path


def write_screen_group_previews(docs_by_family: Dict[str, List["ScreenDoc"]]) -> int:
    SCREEN_GROUP_DIR.mkdir(parents=True, exist_ok=True)
    for old_preview in SCREEN_GROUP_DIR.glob(f"*{SCREEN_GROUP_SUFFIX}"):
        old_preview.unlink()

    written = 0
    for family in SCREEN_FAMILY_ORDER:
        family_docs = docs_by_family.get(family, [])
        if not family_docs:
            continue
        for index in range(0, len(family_docs), SCREEN_GROUP_ROW_SIZE):
            row_docs = family_docs[index:index + SCREEN_GROUP_ROW_SIZE]
            write_screen_group_preview(family, index // SCREEN_GROUP_ROW_SIZE, row_docs)
            written += 1
    return written


def screen_source_entries() -> List[Tuple[str, Path, str]]:
    entries = [
        (path.stem, path, path.read_text(encoding="utf-8"))
        for path in sorted(EXPLORER_SCREENS_DIR.glob("*.swift"), key=lambda item: natural_key(item.stem))
    ]

    screen_view_path = ROOT / "DSKitExplorer" / "ScreenView.swift"
    if screen_view_path.exists():
        screen_view_source = screen_view_path.read_text(encoding="utf-8")
        for screen_name in PLAYGROUND_SCREENS:
            if word_pattern(screen_name).search(screen_view_source):
                focused_source = extract_named_struct(screen_view_source, screen_name) or screen_view_source
                entries.append((screen_name, screen_view_path, focused_source))

    return entries


def build_screen_docs(component_names: List[str]) -> List[ScreenDoc]:
    docs: List[ScreenDoc] = []
    missing_snapshots: List[str] = []

    for screen_name, source_path, source in screen_source_entries():
        snapshot_paths = find_screen_snapshots(screen_name)
        if not snapshot_paths:
            missing_snapshots.append(screen_name)
        used_components = [
            name
            for name in component_names
            if word_pattern(name).search(source)
        ]
        docs.append(
            ScreenDoc(
                name=screen_name,
                source_path=source_path,
                page_path=SCREEN_DOCS_DIR / f"{screen_name}.md",
                snapshot_paths=snapshot_paths,
                family=screen_family_for(screen_name),
                example=extract_testable_example(source, screen_name),
                used_components=sorted(used_components),
            )
        )

    if missing_snapshots:
        missing = "\n".join(f"- {name}" for name in missing_snapshots)
        raise SystemExit(
            "Every DSKitExplorer screen doc must have at least one snapshot image under "
            "`DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`.\n"
            f"Missing screen snapshots:\n{missing}"
        )

    return sorted(docs, key=screen_sort_key)


def build_component_docs() -> List[ComponentDoc]:
    source_paths = sorted(VIEW_SOURCE_DIR.glob("*.swift"), key=component_sort_key)
    all_names = sorted(path.stem for path in source_paths)
    docs: List[ComponentDoc] = []
    missing_previews: List[str] = []

    for source_path in source_paths:
        source = source_path.read_text(encoding="utf-8")
        component_name = source_path.stem
        preview_path = SNAPSHOT_DIR / f"{component_name}.snapshot.png"
        if not preview_path.exists():
            missing_previews.append(component_name)
        example = extract_testable_example(source, component_name)
        docs.append(
            ComponentDoc(
                name=component_name,
                source_path=source_path,
                page_path=VIEW_DOCS_DIR / f"{component_name}.md",
                preview_path=preview_path,
                doc_kind=doc_kind_for(component_name),
                documentation_lines=clean_comment_lines(source, component_name),
                example=example,
                explorer_usage=find_explorer_usage(component_name),
                related_components=find_related_components(source, example, component_name, all_names),
            )
        )

    if missing_previews:
        missing = "\n".join(f"- {name}" for name in missing_previews)
        raise SystemExit(
            "Every DSKit view must have an exact preview image at "
            "`DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png`.\n"
            f"Missing preview images:\n{missing}"
        )

    return docs


def screen_doc_path_for_source(source_path: Path) -> Path:
    return SCREEN_DOCS_DIR / f"{source_path.stem}.md"


def screen_usage_link(source_path: Path, from_dir: Path) -> str:
    screen_page = screen_doc_path_for_source(source_path)
    source_link = rel_link(source_path, from_dir)
    if screen_page.exists() or source_path.parent == EXPLORER_SCREENS_DIR:
        screen_link = rel_link(screen_page, from_dir)
        return f"[{source_path.stem}]({screen_link}) ([source]({source_link}))"
    return f"[{repo_path(source_path)}]({source_link})"


def write_component_page(doc: ComponentDoc) -> None:
    lines: List[str] = [
        f"# {doc.name}",
    ]

    preview_link = rel_link(doc.preview_path, doc.page_path.parent)

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

    lines.extend(["", "## Preview", ""])
    lines.append(f'<img src="{preview_link}" width="{PAGE_PREVIEW_WIDTH}" alt="{doc.name} preview" />')

    lines.extend(["", "## DSKitExplorer Usage", ""])
    if doc.explorer_usage:
        for usage_path in doc.explorer_usage[:10]:
            lines.append(f"- {screen_usage_link(usage_path, doc.page_path.parent)}")
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

    lines.extend([
        "",
        "## Reference",
        "",
        "> Generated by `Scripts/documentation_generator.sh`. Edit the Swift source comment or generator instead of this file.",
        "",
        f"- Source: [{repo_path(doc.source_path)}]({rel_link(doc.source_path, doc.page_path.parent)})",
        f"- Full usage map: [UsageIndex.md#{doc.name.lower()}](UsageIndex.md#{doc.name.lower()})",
        f"- Explorer usage: {len(doc.explorer_usage)} screen file{'s' if len(doc.explorer_usage) != 1 else ''}",
        f"- Type: {doc.doc_kind[:-1] if doc.doc_kind.endswith('s') else doc.doc_kind}",
        f"- Snapshot: [{doc.preview_path.name}]({preview_link})",
    ])

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
                lines.append(f"- {screen_usage_link(usage_path, USAGE_INDEX_FILE.parent)}")
        else:
            lines.append("No direct `DSKitExplorer/Screens` usage was found.")

    USAGE_INDEX_FILE.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def category_for(component_name: str) -> str:
    return CATEGORY_BY_COMPONENT.get(component_name, "Other views")


def doc_kind_for(component_name: str) -> str:
    if component_name in PRIMITIVE_COMPONENTS:
        return "Primitives"
    return "Components"


def preview_thumbnail(doc: ComponentDoc, from_dir: Path) -> str:
    preview_link = rel_link(doc.preview_path, from_dir)
    return f'<img src="{preview_link}" width="{INDEX_PREVIEW_WIDTH}" alt="{doc.name} preview" />'


def write_screen_page(doc: ScreenDoc) -> None:
    lines: List[str] = [
        f"# {doc.name}",
        "",
        "## Preview",
        "",
    ]

    for snapshot_path in doc.snapshot_paths:
        snapshot_link = rel_link(framed_screen_path(snapshot_path), doc.page_path.parent)
        lines.append(f"### {snapshot_path.stem.removesuffix('.snapshot')}")
        lines.append("")
        lines.append(f'<img src="{snapshot_link}" width="{PAGE_PREVIEW_WIDTH}" alt="{doc.name} snapshot preview" />')
        lines.append("")

    lines.extend(["## DSKit Views Used", ""])
    if doc.used_components:
        for component_name in doc.used_components:
            component_link = rel_link(VIEW_DOCS_DIR / f"{component_name}.md", doc.page_path.parent)
            lines.append(f"- [{component_name}]({component_link})")
    else:
        lines.append("No direct `DSKit/Sources/DSKit/Views` component references were detected.")

    lines.extend([
        "",
        "## Reference",
        "",
        "> Generated by `Scripts/documentation_generator.sh`. Edit the screen source, snapshots, or generator instead of this file.",
        "",
        f"- Source: [{repo_path(doc.source_path)}]({rel_link(doc.source_path, doc.page_path.parent)})",
        f"- Family: {doc.family}",
        f"- Snapshot preview{'s' if len(doc.snapshot_paths) != 1 else ''}: {len(doc.snapshot_paths)}",
        f"- DSKit views used: {len(doc.used_components)}",
    ])

    doc.page_path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def write_screen_index(docs: List[ScreenDoc]) -> None:
    lines: List[str] = [
        "# DSKitExplorer Screens",
        "",
        "## Screen Examples",
        "",
        "Start here when you need a concrete screen example instead of a component API reference.",
        "",
        "Browse the preview strips to find the screen pattern you need, then open the related reference page below it. Each screen page includes source links, snapshot previews, and detected DSKit view references.",
        "",
        "## Screen Catalog",
        "",
    ]

    docs_by_family: Dict[str, List[ScreenDoc]] = {family: [] for family in SCREEN_FAMILY_ORDER}
    for doc in docs:
        docs_by_family.setdefault(doc.family, []).append(doc)

    write_screen_group_previews(docs_by_family)

    for family in SCREEN_FAMILY_ORDER:
        family_docs = docs_by_family.get(family, [])
        if not family_docs:
            continue
        lines.extend([
            f"### {family}",
            "",
        ])
        for index in range(0, len(family_docs), SCREEN_GROUP_ROW_SIZE):
            row_index = index // SCREEN_GROUP_ROW_SIZE
            group_link = rel_link(screen_group_path(family, row_index), SCREEN_INDEX_FILE.parent)
            lines.append(f'<img src="{group_link}" alt="{family} screen previews {row_index + 1}" />')
            lines.append("")

        screen_links = ", ".join(
            f"[{doc.name}]({rel_link(doc.page_path, SCREEN_INDEX_FILE.parent)})"
            for doc in family_docs
        )
        lines.append(f"Related screen references: {screen_links}.")
        lines.append("")

    lines.extend([
        "## Maintenance",
        "",
        "- Refresh these docs with `cd Scripts && ./documentation_generator.sh`.",
        "- Every screen page must have at least one matching snapshot image in `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests`.",
        "- A screen named `ExampleScreen` uses `ExampleScreen.snapshot.png` and may also include variants such as `ExampleScreen_0.snapshot.png`.",
        "- Screen preview PNG files are generated under `Content/Screens/Frames` from the source snapshot PNGs.",
        "- Screen catalog strip previews are generated PNG files under `Content/Screens/Groups` from the screen previews.",
        "",
        "> Generated by `Scripts/documentation_generator.sh`. Use this page as the table of contents for snapshot-backed DSKitExplorer screens.",
    ])

    SCREEN_INDEX_FILE.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def write_main_index(docs: List[ComponentDoc]) -> None:
    lines: List[str] = [
        "# DSKit Views and Components",
        "",
        "## Component Catalog",
        "",
        "| Preview | Component |",
        "| --- | --- |",
    ]

    for doc in docs:
        lines.append(
            "| "
            f"{preview_thumbnail(doc, INDEX_FILE.parent)} | "
            f"[{doc.name}](Views/{doc.name}.md) |"
        )

    lines.append("")

    lines.extend([
        "## Maintenance",
        "",
        "- Refresh these docs with `cd Scripts && ./documentation_generator.sh`.",
        "- Update source comments and `Testable_*` examples in `DSKit/Sources/DSKit/Views` to improve generated pages.",
        "- Every `DSKit/Sources/DSKit/Views/*.swift` file must have a matching preview image at `DSKitTests/__Snapshots__/DSKitTests/<Component>.snapshot.png`.",
        "",
        "> Generated by `Scripts/documentation_generator.sh`. Use this page as the table of contents for DSKit view docs.",
        "",
        "## Agent Quick Start",
        "",
        "- Scan the preview column to find the DSKit view you need, then open its dedicated page.",
        "- Each preview comes from the required snapshot image in `DSKitTests/__Snapshots__/DSKitTests`.",
        "- Generated files should be refreshed from source comments and snapshots, not edited by hand.",
    ])

    INDEX_FILE.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def main() -> None:
    VIEW_DOCS_DIR.mkdir(parents=True, exist_ok=True)
    SCREEN_DOCS_DIR.mkdir(parents=True, exist_ok=True)
    for old_markdown in VIEW_DOCS_DIR.glob("*.md"):
        old_markdown.unlink()
    for old_markdown in SCREEN_DOCS_DIR.glob("*.md"):
        old_markdown.unlink()

    docs = build_component_docs()
    screen_docs = build_screen_docs([doc.name for doc in docs])
    screen_frame_count = write_screen_frames(screen_docs)
    for doc in docs:
        write_component_page(doc)
    write_usage_index(docs)
    write_main_index(docs)
    for doc in screen_docs:
        write_screen_page(doc)
    write_screen_index(screen_docs)
    screen_group_count = len(list(SCREEN_GROUP_DIR.glob(f"*{SCREEN_GROUP_SUFFIX}")))

    print(f"Generated {len(docs)} component pages")
    print(f"Generated {len(screen_docs)} screen pages")
    print(f"Generated {screen_frame_count} screen previews")
    print(f"Generated {screen_group_count} screen catalog strip previews")
    print(f"Wrote {INDEX_FILE.relative_to(ROOT)}")
    print(f"Wrote {USAGE_INDEX_FILE.relative_to(ROOT)}")
    print(f"Wrote {SCREEN_INDEX_FILE.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
