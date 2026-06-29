# Layout In DSKit

DSKit layout primitives wrap common SwiftUI containers so spacing, margins, surfaces, and snapshot behavior stay consistent across screens.

Use this page for layout intent. Use the generated [component catalog](Views.md) when you need exact source links, examples, previews, and DSKitExplorer usage references.

## Start Here

- [DSVStack](Views/DSVStack.md): vertical layout with DSKit spacing defaults.
- [DSHStack](Views/DSHStack.md): horizontal layout with DSKit spacing defaults.
- [DSLazyVStack](Views/DSLazyVStack.md): lazy vertical layout for scrollable content.
- [DSGrid](Views/DSGrid.md): token-spaced grid layout.
- [DSHScroll](Views/DSHScroll.md): horizontal scrolling content aligned to DSKit margins.
- [DSList](Views/DSList.md): list wrapper for sectioned content.
- [DSSection](Views/DSSection.md): section wrapper for grouped rows and headers.
- [DSCardSurface](Views/DSCardSurface.md): reusable padded surface for card-like content.

For full-screen examples, start from the generated [screen catalog](Screens.md).

## Spacing Model

DSKit spacing is expressed through `DSSpatialToken`:

- `.space0`, `.space1`, `.space2`, `.space4`, `.space8`, `.space12`, `.space16`, `.space24`, `.space32`, `.space40`, `.space48`, `.space64`
- `.custom(CGFloat)` for one-off values that cannot be represented by the standard scale

Components resolve spacing through the active `DSAppearance.spacing` and `DSAppearance.padding` systems. Prefer tokens over raw numbers when building reusable DSKit views.

```swift
DSVStack(spacing: .space16) {
    DSText("Welcome to DSKit")
        .dsTextStyle(.title1)

    DSText("Token spacing keeps screens consistent.")
        .dsTextStyle(.body)

    DSButton(title: "Continue") {
        print("Continue")
    }
}
.dsPadding(.space16)
.dsBackground(.secondary)
.dsCornerRadius()
```

## Lists And Sections

`DSList` owns spacing between logical sections. `DSSection` owns spacing between rows inside a section.

Use `DSList(sectionSpacing:)` for the gap between sections:

```swift
DSList(sectionSpacing: .space16) {
    DSSection {
        DSText("First row")
        DSText("Second row")
    }

    DSSection {
        DSText("Another section")
    }
}
```

Use `.dsSpacing(...)` on `DSSection` only for row spacing inside that section:

```swift
DSSection {
    DSText("Title")
    DSText("Subtitle")
}
.dsSpacing(.space4)
```

Do not wrap a large `ForEach` inside an extra `VStack` when the rows are meant to be virtualized by `List`; that turns many rows into one large cell. Keep row-producing content directly inside `DSSection`.

## Horizontal Scrolling

`DSHScroll` applies DSKit horizontal content margins while preserving first and last item alignment. Use it for horizontally scrolling rows of cards, chips, categories, or images.

```swift
DSHScroll {
    DSCardSurface {
        DSText("Featured")
    }

    DSCardSurface {
        DSText("Popular")
    }
}
```

## Choosing A Container

- Use `DSVStack` or `DSHStack` for compact component composition.
- Use `DSLazyVStack` when scrollable vertical content can grow.
- Use `DSList` and `DSSection` for native list behavior and row virtualization.
- Use `DSHScroll` for horizontal collections that must align to screen margins.
- Use `DSGrid` when the layout is naturally multi-column.
- Use `DSCardSurface` when the content needs a reusable surface treatment rather than ad-hoc padding/background modifiers.

## Documentation Maintenance

When layout behavior changes:

1. Update the Swift source comments and `Testable_*` examples in `DSKit/Sources/DSKit/Views`.
2. Update or record the relevant component snapshots under `DSKitTests/__Snapshots__/DSKitTests`.
3. Regenerate docs with `cd Scripts && ./documentation_generator.sh`.
4. Check the generated component page and any affected screen pages.
