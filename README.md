

<p align="center">
    <img src="Content/Images/Logo.png" width="150" max-width="100%" alt="DSKit"/>
</p>
<p align="center">
    <img src="https://img.shields.io/badge/iOS-17%2B-brightgreen.svg?style=flat" alt="iOS"/>
    <img src="https://img.shields.io/badge/SwiftUI-5.0-brightgreen.svg"/>
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager"/>
    </a>
</p>

# DSKit

DSKit is a SwiftUI design system for building iOS interfaces from reusable views, design tokens, and appearance themes. The repo is organized for both developers and AI agents: generated docs connect every component and Explorer screen to source files, snapshot previews, examples, and real usage references.

<img src="Content/Images/Preview.png">

DSKit includes **DSKitExplorer**, a catalog app with 60+ ready-to-use screens that show complete SwiftUI flows in context. Use the [showcase](Content/Showcase.md) for a visual overview, the generated [screen catalog](Content/Screens.md) for full-screen examples, and the generated [component catalog](Content/Views.md) for individual DSKit views.

## Documentation

Use these entrypoints before guessing APIs:

- [Views / Components](Content/Views.md): generated visual component catalog with snapshot previews and links to per-component pages.
- [Layout](Content/Layout-in-DSKit.md): hand-written layout and spacing guidance.
- [Appearance](Content/Appearance-in-DSKit.md): hand-written appearance and theming guidance.

The generated docs are refreshed from Swift source comments, `Testable_*` examples, snapshots, and Explorer usage references. Do not hand-edit generated pages under `Content/Views/` or `Content/Screens/`; update source, snapshots, or the generator and then run `cd Scripts && ./documentation_generator.sh`.

### Running DSKitExplorer

Open `DSKitExplorer.xcodeproj`, select the `DSKitExplorer` scheme, and run it on an iPhone simulator.

## Start Here

1. Add DSKit with Swift Package Manager:
   - Package URL: `https://github.com/imodeveloper/dskit-swiftui.git`
   - Select the app target that should use DSKit.

2. Apply an appearance at the root of your app:

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

3. Build screens with DSKit views and modifiers:

```swift
import SwiftUI
import DSKit

struct ContentView: View {
    var body: some View {
        DSVStack(alignment: .center) {
            DSText("Welcome to DSKit")
                .dsTextStyle(.title1)
                .dsPadding()
                .dsBackground(.primary)
            DSText("Design with ease")
                .dsPadding()
                .dsBackground(.secondary)
                .dsCornerRadius()
            DSButton(
                title: "Start Now",
                action: { print("Do something") }
            )
        }
        .dsScreen()
    }
}
```

In this example, [DSVStack](Content/Views/DSVStack.md), [DSText](Content/Views/DSText.md), and [DSButton](Content/Views/DSButton.md) are combined with modifiers like `dsPadding()` and `dsBackground()`.

## Contributions and support

DSKit is developed completely in the open, and contributions are welcome.

Before changing DSKit, read [CONTRIBUTING.md](Content/CONTRIBUTING.md), [docs/WORKFLOWS.md](docs/WORKFLOWS.md), and the generated component or screen page for the area you are changing. Generated docs are not edited by hand; update Swift source comments, `Testable_*` examples, snapshots, or the generator, then run `cd Scripts && ./documentation_generator.sh`.

This project does not come with GitHub Issues-based support. Users are encouraged to become active participants by fixing bugs they encounter or improving documentation wherever it is lacking.

If you wish to make a change, open a [Pull Request](https://github.com/imodeveloper/dskit-swiftui/pulls), even if it just contains a draft of the changes you are planning or a test that reproduces an issue.

Hope you will enjoy using DSKit.
