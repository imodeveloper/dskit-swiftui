# Screen Construction With DSKit

DSKit screens are built by combining a small set of layout containers, semantic sections, reusable rows, appearance tokens, and snapshot-backed examples. Use this page as the high-level article for understanding how DSKit screens are assembled before opening individual source files.

The goal is not to copy a screen blindly. The goal is to recognize the DSKit structure behind a screen, choose the right primitives, and keep application-specific state outside the visual composition layer.

## Read First

- [Showcase](Showcase.md): visual overview of complete DSKitExplorer flows.
- [Screen catalog](Screens.md): generated full-screen catalog with iPhone-framed previews and source links.
- [Views / Components](Views.md): generated component catalog with per-component pages, previews, examples, and usage references.
- [Layout](Layout-in-DSKit.md): layout, spacing, section, and list behavior.
- [Appearance](Appearance-in-DSKit.md): theme, typography, color, and token behavior.

## DSKitExplorer As A Cookbook

DSKitExplorer is the best place to inspect complete DSKit screens in context. Each screen is intentionally small enough to read, has local demo data, and is backed by a snapshot test so visual changes are explicit.

Common Explorer structure:

1. [ScreensView](../DSKitExplorer/ScreensView.swift) lists the available demo screens from `ScreenKey`.
2. [ScreenView](../DSKitExplorer/ScreenView.swift) applies the active `DSAppearance`, navigation behavior, and the selected demo screen.
3. Screens under [DSKitExplorer/Screens](../DSKitExplorer/Screens) compose DSKit views directly from local example data.
4. Generated pages under [Content/Screens](Screens) connect each screen to its source file, preview image, and DSKit views used.

Use DSKitExplorer to find a visual pattern, then extract the DSKit structure from that example. Replace local demo data with your app's data at the boundary of the screen, not inside DSKit primitives.

## Construction Model

A DSKit screen usually has four layers:

1. **Screen shell**
   - Applies `dsScreen()`, `dsAppearance(...)`, navigation behavior, or the host container.
   - Owns high-level spacing and safe-area expectations.
2. **Content container**
   - Uses `DSList` for feeds, grouped rows, forms, and screen content that should keep native list behavior.
   - Uses `DSVStack` or `DSHStack` for compact static layouts.
   - Uses `DSGrid`, `DSHScroll`, or `DSCoverFlow` when the content is naturally visual or horizontally browsable.
3. **Semantic sections**
   - Uses `DSSection` to group related rows.
   - Uses `DSSectionHeaderView` when a section needs a visible title/action area.
   - Uses `DSBottomContainer` for persistent bottom actions.
4. **Reusable rows and cards**
   - Uses components such as `DSEntityRow`, `DSContentCard`, `DSCardSurface`, `DSImageView`, `DSText`, `DSPriceView`, `DSRatingView`, and `DSButton`.
   - Keeps each row focused on display-ready values and user action forwarding.

## Choosing Containers

Use `DSList` when:

- the screen is a feed, grouped list, form, settings list, checkout flow, or search result list
- rows need native list sizing, scrolling, accessibility, and virtualization behavior
- sections need consistent DSKit spacing and separators

Use `DSVStack` with `.dsScreen()` when:

- the screen is compact and mostly static
- the layout does not benefit from list row behavior
- content should be centered, stacked, or presented as a small tool surface

Use `DSHScroll`, `DSGrid`, or `DSCoverFlow` when:

- the screen has rails, product collections, galleries, categories, or hero media
- users need to scan visual choices quickly
- the layout should expose multiple items without turning every group into a vertical list

Use `DSBottomContainer` when:

- an action must stay visually anchored at the bottom of a flow
- checkout, booking, detail, or confirmation screens need persistent calls to action
- the content should scroll behind or above a fixed action area without losing the action

## Example Patterns

Representative DSKitExplorer screens:

- [FoodHomeScreen1](../DSKitExplorer/Screens/FoodHomeScreen1.swift)
  - Uses `DSList` as the vertical screen container.
  - Uses `DSCoverFlow` for a hero carousel.
  - Uses `DSHScroll` for horizontal product and category rails.
  - Keeps small row/card views near the screen so the example is easy to inspect.
- [NewsScreen1](../DSKitExplorer/Screens/NewsScreen1.swift)
  - Uses `DSList` and `DSSection` for a feed.
  - Emits rows directly from `ForEach`, preserving list row behavior.
  - Switches row presentation with screen-local state.
- [ItemDetails1](../DSKitExplorer/Screens/ItemDetails1.swift)
  - Uses `DSList` for detail content.
  - Uses `DSBottomContainer` for fixed bottom actions.
  - Combines media, price, quantity, selectors, and toolbar actions.
- [BookingScreen3](../DSKitExplorer/Screens/BookingScreen3.swift)
  - Shows a multi-step form/detail composition.
  - Combines `DSCardSurface`, `DSEntityRow`, `DSContentCard`, `DSPriceView`, and `DSBottomContainer`.

Open the generated page for any of these screens from [Screens.md](Screens.md) to see the preview, source link, and component references in one place.

## Data And State Boundaries

DSKit components should receive values that are already prepared for display. Keep fetching, sorting, filtering, persistence, pagination, and business decisions outside the DSKit row or card whenever possible.

Good boundaries:

- screen or view model owns loading and domain state
- adapter code maps domain values into titles, subtitles, images, badges, and actions
- DSKit rows render those values and forward user intent through closures

Avoid:

- putting network or persistence work inside a DSKit row
- making a reusable DSKit view depend on one app's domain model
- hiding business rules inside a visual modifier
- wrapping many logical list rows into one large list row

## Virtualization And Identity

High-volume screens should keep each item as its own list row. This matters because SwiftUI `List` virtualization depends on row boundaries.

Use stable identity:

```swift
DSSection(data: products, id: \.id) { product in
    ProductRow(product: product)
}
```

Or keep row-producing content directly inside `DSSection`:

```swift
DSSection {
    ForEach(products) { product in
        ProductRow(product: product)
    }
}
```

Avoid this for large feeds:

```swift
DSSection {
    DSVStack {
        ForEach(products) { product in
            ProductRow(product: product)
        }
    }
}
```

That shape can turn many logical rows into one large row and remove the list's ability to virtualize the content.

## Interaction Guidelines

- Keep tappable surfaces visually clear.
- Attach actions to the DSKit surface that users perceive as interactive.
- Prefer small closures such as `onTap`, `onSelect`, `onFavorite`, or `onPrimaryAction`.
- Keep navigation decisions at the screen boundary.
- Use `DSBottomContainer` for persistent primary actions instead of burying the only important action deep in scrolling content.

## Agent Inspection Workflow

When an agent needs to build or modify a DSKit screen:

1. Start from [Showcase](Showcase.md) or [Screens.md](Screens.md) and pick the closest visual pattern.
2. Open the generated screen page and inspect the preview plus component references.
3. Open the source file under `DSKitExplorer/Screens`.
4. Open each unfamiliar component page from [Views.md](Views.md).
5. Identify the screen shell, content container, sections, and row/card components.
6. Reuse the DSKit structure that creates the desired layout.
7. Replace demo data with display-ready values from the target app.
8. Keep loading, filtering, persistence, and navigation outside reusable DSKit rows.
9. Preserve stable row identity and list virtualization for large collections.
10. Add or update snapshots when the visual behavior intentionally changes.

## Maintenance

This page is hand-maintained. Update it when:

- DSKitExplorer adds a new screen construction pattern.
- `DSList`, `DSSection`, `DSBottomContainer`, `DSHScroll`, `DSGrid`, or `DSCoverFlow` behavior changes.
- The generated screen or component docs change their inspection workflow.

Generated component and screen pages are maintained by `Scripts/documentation_generator.sh`; do not hand-edit `Content/Views/*`, `Content/Screens/*`, `Content/Views.md`, or `Content/Screens.md`.
