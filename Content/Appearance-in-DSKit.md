# Appearance In DSKit

DSKit appearance is the theme layer that resolves colors, typography, spacing, padding, corner radius, navigation bars, tab bars, and price styling for DSKit views.

Use this page for the appearance model. Use the generated [component catalog](Views.md) and [screen catalog](Screens.md) to see how components and full screens render with the active appearance.

## Applying An Appearance

Inject an appearance at the root of your SwiftUI app with `.dsAppearance(...)`.

```swift
import SwiftUI
import DSKit

@main
struct DSKitDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .dsAppearance(RetroAppearance())
        }
    }
}
```

If the app should also apply DSKit navigation bar and tab bar styling to UIKit-backed system chrome, enable `overrideSystemAppearance`.

```swift
ContentView()
    .dsAppearance(
        RetroAppearance(),
        overrideSystemAppearance: true,
        opaqueNavigationBar: true,
        opaqueTabBar: true
    )
```

## Built-In Appearances

Built-in appearances live in `DSKit/Sources/DSKit/Appearances`.

Useful starting points include:

- `LightBlueAppearance`
- `DarkAppearance`
- `RetroAppearance`
- `BlueAppearance`
- `PeachAppearance`

Most custom themes should start by copying a built-in appearance and changing brand colors, typography, surfaces, and component-specific values.

## What `DSAppearance` Provides

`DSAppearance` is a protocol with the current theme contract:

- `colors`: semantic `DSColorTheme`
- `primaryView` and `secondaryView`: legacy-compatible surface containers for text, buttons, fields, backgrounds, separators, and corner radius
- `spacing`: `DSSpacingProtocol`
- `padding`: `DPaddingsProtocol`
- `tabBar`: `DSTabBarAppearanceProtocol`
- `navigationBar`: `DSNavigationBarAppearanceProtocol`
- `price`: `DSPriceAppearanceProtocol`
- `typography`: `DSTypographyProtocol`
- `actionElementHeight`, `screenMargins`, and `cornerRadius`

DSKit still supports older `DSViewStyle` and `DSColorKey` paths, but new component work should prefer `DSColorToken`, `DSSurfaceStyle`, `DSTypographyToken`, and `DSSpatialToken`.

## Tokens Used By Components

### Spacing

Use `DSSpatialToken` for layout and padding values:

```swift
DSVStack(spacing: .space16) {
    DSText("Profile")
    DSText("Manage account details")
}
.dsPadding(.space16)
```

### Typography

Use `DSTypographyToken` through `DSText.dsTextStyle(...)`:

```swift
DSText("Featured")
    .dsTextStyle(.title2)

DSText("Updated today")
    .dsTextStyle(.caption1)
```

### Colors And Surfaces

Use semantic surface and color APIs instead of hardcoded values where possible:

```swift
DSText("Saved")
    .dsTextStyle(.headline)
    .dsPadding(.horizontal, .space12)
    .dsPadding(.vertical, .space8)
    .dsBackground(.secondary)
    .dsCornerRadius()
```

## Customizing A Theme

The lowest-risk path is to copy a built-in appearance and adjust the values in its initializer. A custom appearance should keep these invariants:

- define both `primaryView` and `secondaryView`
- keep `colors` synchronized with the legacy-compatible view appearances
- keep text colors readable in light and dark mode
- keep `spacing` and `padding` token-based
- preserve deterministic values for snapshot tests

For a brand color override, use a built-in initializer when it exists:

```swift
ContentView()
    .dsAppearance(
        RetroAppearance(
            brandColor: .dynamic(light: 0x0A84FF, dark: 0x64D2FF),
            title: "Brand"
        )
    )
```

For a deeper custom theme, copy one of the built-in files under `DSKit/Sources/DSKit/Appearances` and rename it. That keeps the full `DSAppearance` contract visible and avoids partial themes that compile but render inconsistently.

## Documentation Maintenance

When appearance behavior changes:

1. Update the relevant appearance or token source comments.
2. Update affected component or screen snapshots.
3. Regenerate docs with `cd Scripts && ./documentation_generator.sh`.
4. Check generated component and screen pages for stale examples or previews.
