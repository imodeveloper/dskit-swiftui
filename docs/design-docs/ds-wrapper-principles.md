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
  - `primaryView` and `secondaryView` style containers
  - `spacing` and `padding` systems
  - `fonts`, `tabBar`, `navigationBar`, `textField`, and `price` appearance
  - helper methods for color/font lookups
- Built-in theme examples live in `DSKit/Sources/DSKit/Appearances`, with `LightBlueAppearance` and others as practical baselines.
- Existing docs already describe custom appearance flow in `Content/Appearance-in-DSKit.md`.

## Spacing policy

- All DS spacing uses token enums and token systems:
  - `DSSpace` defines semantic spacing (`.small`, `.regular`, `.medium`, `.custom`, `.zero`).
  - `DSSpacingSystem` converts those values into concrete CGFloat values for component layout internals.
  - `DSPaddingSystem` does the same for container/inset spacing.
- Wrapper components prefer semantic spacing to ad-hoc numeric literals.
- Appearance controls the scale, so spacing changes at the theme level can cascade safely across all screens.

## Color policy

- Colors are not read directly from hardcoded literals in most wrappers.
- `DSColorKey` models color source categories:
  - view-level colors (`.view`, `.viewStyle`)
  - text colors (`.text`)
  - navigation/tab bar colors
  - price colors
  - explicit `.color(...)` overrides
- `DSViewStyle` (`.primary`, `.secondary`) selects matching appearance surfaces at render time.
- `DSBackground` style modifiers and component internals resolve colors from `DSColorKey + DSAppearance` so dark/light and custom themes stay synchronized.

## Typography policy

- Typography is tokenized through:
  - `DSFontsProtocol` (`body`, `headline`, `title1`, etc.)
  - `DSTextFontKey` (`.title1`, `.headline`, `.fontWithSize`, etc.)
  - `DSTextStyle` environment state in `DSText`
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
  - generated API surface and test-backed examples

For future edits, keep wrapper usage aligned to the token systems above unless there is a feature requirement that cannot be represented through existing tokens.
