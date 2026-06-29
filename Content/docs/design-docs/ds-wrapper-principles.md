# DSKit Wrappers and Design Tokens

## Why DSKit has SwiftUI wrappers instead of raw native views

`DSVStack`, `DSHStack`, `DSText`, and `DSButton` are wrappers around native SwiftUI views to centralize DSKit behavior behind a stable API:

- Consistent default spacing across the whole UI.
- App-wide theming without touching every consumer call site.
- Single-point control for typography and color semantics.
- Snapshot determinism through explicit environment-driven defaults.

Representative examples:

- `DSVStack` wraps `VStack` and derives `spacing` from `appearance.spacing`.
- `DSHStack` wraps `HStack` and applies DSKit content margin behavior (`dsContentMargins` / `dsResetContentMargins`).
- `DSText` wraps `Text` and resolves font + color from environment tokens.
- `DSButton` wraps `Button` and uses DS view-style colors, spacing, and sizing tokens.

## Theme system (spacing, colors, typography)

- Theme entrypoint is `DSAppearance`, injected at the root via `.dsAppearance(_:)`.
- `DSAppearance` provides:
  - `colors` through `DSColorTheme`
  - `primaryView` and `secondaryView` style containers
  - `spacing` and `padding` systems
  - `typography`, `tabBar`, `navigationBar`, and `price` appearance
  - helper methods for color/font lookups
- Built-in theme examples live in `DSKit/Sources/DSKit/Appearances`, with `LightBlueAppearance` and others as practical baselines.
- Existing docs already describe custom appearance flow in `Content/Appearance-in-DSKit.md`.

## Spacing policy

- All DS spacing uses token enums and token systems:
  - `DSSpatialToken` defines concrete scale tokens such as `.space0`, `.space4`, `.space8`, `.space16`, and `.custom(...)`.
  - `DSSpacingSystem` converts those values into concrete `CGFloat` values for component layout internals.
  - `DSPaddingSystem` does the same for container/inset spacing.
- Wrapper components prefer spacing tokens to ad-hoc numeric literals.
- Appearance controls the scale, so spacing changes at the theme level can cascade safely across all screens.

## Color policy

- Colors are not read directly from hardcoded literals in most wrappers.
- `DSColorToken` models semantic background, text, icon, and border colors.
- `DSSurfaceStyle` identifies the rendering surface (`.canvas`, `.surface`, `.surfaceRaised`, `.surfaceSunken`, `.inverse`).
- Legacy `DSColorKey` and `DSViewStyle` APIs still exist for compatibility, but new wrapper work should prefer semantic tokens where possible.
- Background/text/icon modifiers and component internals resolve colors through `DSColorToken + DSAppearance` so light, dark, and custom themes stay synchronized.

## Typography policy

- Typography is tokenized through:
  - `DSTypographyProtocol` (`body`, `headline`, `title1`, etc.)
  - `DSTypographyToken` (`.title1`, `.headline`, `.bodySmall`, `.custom(...)`, etc.)
  - `DSText` resolving font and semantic text color from the active appearance
- `DSText` uses `.dsTextStyle(...)` to pull both font and color from tokenized state, ensuring:
  - consistent text hierarchy
  - theme-safe semantic color usage
  - no copy-paste style drift

## Read path for implementation + examples

Start here before touching DS wrappers:

- `README.md`:
  - quick setup and `.dsAppearance(...)`
  - `dsTextStyle` and layout usage examples
- `Content/Layout-in-DSKit.md`:
  - layout behavior and spacing intent
- `Content/Appearance-in-DSKit.md`:
  - theme design and custom appearance examples
- `Content/Views.md`:
  - generated component catalog, API surface, snapshots, and test-backed examples
- `Content/Screens.md`:
  - generated DSKitExplorer screen catalog with snapshot previews and component references

For future edits, keep wrapper usage aligned to the token systems above unless there is a feature requirement that cannot be represented through existing tokens.
