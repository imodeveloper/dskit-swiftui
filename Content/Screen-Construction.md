# Screen Construction With DSKit

Use this page when you need to understand how full screens are assembled with DSKit, especially when translating a DSKitExplorer example into a production Monitor screen.

DSKitExplorer and Monitor use the same design-system vocabulary, but they use it for different jobs:

- DSKitExplorer is the visual catalog. It favors small, readable, snapshot-backed examples with local demo models.
- Monitor is production UI. It keeps DSKit as the visual layer while app state, refresh logic, navigation, and data projection stay outside DSKit views.

## Read First

- [Views / Components](Views.md): component previews and per-component source pages.
- [DSKitExplorer Screens](Screens.md): snapshot-backed screen catalog.
- [Layout](Layout-in-DSKit.md): layout, section, spacing, and list behavior.
- [Appearance](Appearance-in-DSKit.md): theme and token behavior.

For Monitor references, use the sibling workspace repo paths shown below. They are intentionally listed as repo-relative paths instead of links because this page lives in the DSKit repo.

## DSKitExplorer Screen Shape

DSKitExplorer screens are designed to be copied, inspected, and snapshot tested.

Common structure:

1. [ScreensView](../DSKitExplorer/ScreensView.swift) lists every demo screen from `ScreenKey`.
2. [ScreenView](../DSKitExplorer/ScreenView.swift) injects the active `DSAppearance`, applies navigation title behavior, and chooses either the production screen or a `Testable_*` wrapper.
3. Each screen under [DSKitExplorer/Screens](../DSKitExplorer/Screens) composes DSKit views directly from local demo data.
4. Each generated page under [Content/Screens](Screens) links to the source screen, snapshot preview, DSKit views used, and any `Testable_*` wrapper.

Representative Explorer patterns:

- [FoodHomeScreen1](../DSKitExplorer/Screens/FoodHomeScreen1.swift)
  - Uses `DSList` with multiple `DSSection` groups.
  - Uses `DSCoverFlow` for a hero carousel.
  - Uses `DSHScroll` for horizontal product and category rails.
  - Builds small nested row/card views close to the screen.
- [NewsScreen1](../DSKitExplorer/Screens/NewsScreen1.swift)
  - Uses `DSList` and `DSSection` for a feed.
  - Uses `ForEach` directly inside the section, preserving list row behavior.
  - Switches between regular and compact row layouts with screen-local state.
- [ItemDetails1](../DSKitExplorer/Screens/ItemDetails1.swift)
  - Uses `DSList` for detail content and `DSBottomContainer` for fixed bottom actions.
  - Combines media, price, quantity, selectors, and toolbar actions.
- [BookingScreen3](../DSKitExplorer/Screens/BookingScreen3.swift)
  - Shows a form/detail flow made from `DSCardSurface`, `DSEntityRow`, `DSContentCard`, `DSPriceView`, and `DSBottomContainer`.

Explorer screens optimize for inspectability. They often keep demo data, local nested view types, and simple `dismiss()` or print actions inside the same file. That is correct for examples, but production screens should move data loading and business decisions out of the DSKit composition layer.

## Monitor Screen Shape

Monitor uses DSKit as the shared visual system for real app screens. It keeps the same layout primitives but adds production ownership around data, refresh, navigation, and performance.

Representative Monitor patterns:

- `imodeveloperlab/Monitor/UI/Screens/News/NewsScreen.swift`
  - Uses `ScrollViewReader` around a `DSList` feed.
  - Uses `NewsScreenStore` and environment view models for refresh, scene phase, pending article updates, and pagination.
  - Delegates rows into `ArticleListRowsSection` and `ArticleRegularRowView`.
- `imodeveloperlab/Monitor/UI/Shared/Views/ArticleListRowsSection.swift`
  - Wraps repeated rows in the data-driven `DSSection(data:id:content:separator:)` initializer.
  - Keeps each article as its own list row and adds DSKit separators without collapsing the feed into one cell.
- `imodeveloperlab/Monitor/UI/Shared/Views/ArticleRegularRowView.swift`
  - Adapts a Monitor `Article` into `DSArticleSummaryRow`.
  - Attaches interaction with `.onTap` on the DSKit surface.
- `imodeveloperlab/Monitor/UI/Screens/Today/TodayScreen.swift`
  - Uses `MonitorSectionArticlesStore.todayShared` as a UI projection-backed store.
  - Uses `DSList` for loaded content and placeholder rows.
  - Coordinates scroll-to-top and pending projection updates outside DSKit row views.
- `imodeveloperlab/Monitor/UI/Screens/Focus/FocusScreen.swift`
  - Uses `DSList(sectionSpacing:sectionHeaderSpacing:exactSectionHeaderRowHeight:)` for dashboard sections.
  - Uses `DSSectionHeaderView` plus reusable section views for people, categories, and sources.
- `imodeveloperlab/Monitor/UI/Screens/Search/GlobalSearchScreen.swift`
  - Uses native search/navigation state around a DSKit results list.
  - Uses data-driven `DSSection` for mixed result rows.
- `imodeveloperlab/Monitor/UI/Screens/Settings/SettingsScreen.swift`
  - Uses a `DSVStack` wrapped with `.dsScreen()` instead of `DSList` because the page is compact and not a high-volume feed.
  - Uses DSKit cards, text, images, and tap gestures for settings rows.

Monitor production constraints:

- UI screens read UI-ready data from `MonitorUIDataLayer` services and stores, not from Firestore or heavy processed storage.
- `MonitorSectionArticlesStore` is the dashboard-facing store for Today and Focus section content.
- Large feeds must preserve list virtualization. Do not wrap a full row-producing `ForEach` in one `VStack` inside `DSSection`.
- For tappable DSKit cards, prefer styling the DSKit content directly and attaching `.onTap` to that surface instead of wrapping the whole surface in `Button` plus `.buttonStyle(.plain)`.
- Keep view models and stores responsible for loading, sorting, grouping, pagination, refresh, and stale-content policy.
- Keep DSKit row views responsible for layout, typography, imagery, semantic colors, and local tap forwarding.

## Shared Construction Recipe

Use this recipe when creating or refactoring a screen:

1. Pick the container.
   - Use `DSList` for feeds, grouped lists, forms, and rows that should retain native list behavior.
   - Use a `DSVStack` wrapped with `.dsScreen()` for compact settings or static composition screens.
   - Use `ScrollViewReader` outside `DSList` when the screen needs scroll restoration or a scroll-to-top affordance.
2. Split content into semantic sections.
   - Use `DSSection` for list sections.
   - Use `DSSectionHeaderView` for titled dashboard sections.
   - Use `DSBottomContainer` for persistent bottom actions.
3. Compose rows from small DSKit-backed views.
   - Use `DSText`, `DSImageView`, `DSVStack`, `DSHStack`, `DSCardSurface`, and domain rows such as `DSArticleSummaryRow`.
   - Keep row inputs small and already prepared for display.
4. Preserve row identity and virtualization.
   - Use stable IDs in `ForEach` and `DSSection(data:id:)`.
   - Emit row-producing content directly inside `DSSection` for large feeds.
   - Do not make one huge row by wrapping many list rows in one vertical container.
5. Keep production state outside DSKit composition.
   - Explorer can use local demo models.
   - Monitor should use screen stores, UI projection services, and coordinators.

## Explorer To Monitor Translation

When an agent starts from an Explorer screen and needs a Monitor-grade version:

1. Open [Screens.md](Screens.md), choose the closest visual example, and open its dedicated screen page.
2. Inspect the Explorer source file and list the DSKit views that define the layout.
3. Keep the DSKit structure that creates the desired visual hierarchy.
4. Replace demo arrays and nested demo models with Monitor UI projection data.
5. Move async loading, filtering, grouping, sorting, and refresh behavior into a store or service.
6. Keep row views thin: map display-ready values into DSKit rows and forward user actions.
7. Verify high-volume feeds still use `DSList` plus row-level `DSSection` output.
8. Add or update snapshots only when the visual behavior intentionally changes.

## Agent Inspection Checklist

Before changing a screen:

- Read the generated page in `Content/Screens/<Screen>.md` if the pattern exists in DSKitExplorer.
- Read every component page for unfamiliar DSKit views from [Views.md](Views.md).
- Read [Layout](Layout-in-DSKit.md) before changing `DSList`, `DSSection`, spacing, or horizontal scroll behavior.
- In Monitor, identify the store or service that owns display data before touching the view.
- In Monitor feed work, verify that each article remains an individual list row.
- In Monitor interaction work, prefer `.onTap` on DSKit surfaces for styled cards and chips.

## Maintenance

This page is hand-maintained. Update it when:

- DSKitExplorer screen routing or generated screen docs change.
- Monitor adopts a new DSKit screen construction pattern.
- `DSList`, `DSSection`, or DSKit interaction rules change.

Generated component and screen pages are still maintained by `Scripts/documentation_generator.sh`; do not hand-edit `Content/Views/*`, `Content/Screens/*`, `Content/Views.md`, or `Content/Screens.md`.
