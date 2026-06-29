

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

DSKit is a SwiftUI design system package built to be easy for developers and coding agents to inspect, compose, and reuse. It organizes views, appearance themes, spacing tokens, typography tokens, source-linked examples, and snapshot previews into predictable repo-native documentation.

The Swift Package currently declares **iOS 17+** and **macOS 12+** support. The DSKitExplorer app and snapshot test targets use an **iOS 17.6+** deployment target.

<img src="Content/Images/Preview.png">

DSKit includes **DSKitExplorer**, a catalog app with 60+ ready-to-use screens that show complete SwiftUI flows in context. Use the [DSKitExplorer showcase](Content/Showcase.md) for a visual overview, then open the generated [screen catalog](Content/Screens.md) or [component catalog](Content/Views.md) when you need source files, snapshots, and usage references that agents can follow directly.

## Get Started

To get started with DSKit, add the package using Swift Package Manager.

### Step 1: Adding DSKit via Swift Package Manager (SPM)
To add DSKit to your project, follow these steps:

1. Open your Xcode project: Launch Xcode and open the project where you want to include DSKit.

2. Add the package dependency:
   - Go to `File` > `Swift Packages` > `Add Package Dependency...`
   - Enter the repository URL `https://github.com/imodeveloper/dskit-swiftui.git`.
   - Select the version of the package you wish to add. You can choose a specific release or the latest commit.
   - Xcode will download the package and ask which of your project's targets to add it to. Select the target where you want to use DSKit.

### Step 2: Set Up
Once DSKit is added to your project, import it where you build SwiftUI screens. Apply an appearance at the root of your app with `.dsAppearance(...)`. You can start with a built-in appearance such as `RetroAppearance()` and then copy or customize an appearance when you need a brand-specific theme.

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

### Step 3: Using DSKit in Your Screens
Use [DSKit components](Content/Views.md) and modifiers like regular SwiftUI views. The generated component catalog links to a dedicated page for each view, including source files, snapshot previews, testable examples, related components, and DSKitExplorer usage references.

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

In this example, [DSVStack](Content/Views/DSVStack.md), [DSText](Content/Views/DSText.md), and [DSButton](Content/Views/DSButton.md) are combined with modifiers like `dsPadding()` and `dsBackground()`. These components and modifiers are part of DSKit and help apply consistent styling and spacing as defined in your design system.

## Documentation

Start with the generated docs when you need to find a component or screen quickly:

- [Views / Components](Content/Views.md): generated component catalog split into primitives and composed components.
- [DSKitExplorer Screens](Content/Screens.md): generated screen catalog with snapshot previews and source links.
- [DSKitExplorer Usage Index](Content/Views/UsageIndex.md): exhaustive component-to-screen usage references.
- [Layout](Content/Layout-in-DSKit.md): hand-written layout and spacing guidance.
- [Appearance](Content/Appearance-in-DSKit.md): hand-written appearance and theming guidance.

The generated docs are refreshed from Swift source comments, `Testable_*` examples, snapshots, and Explorer usage references. Do not hand-edit generated pages under `Content/Views/` or `Content/Screens/`; update source, snapshots, or the generator and then run `cd Scripts && ./documentation_generator.sh`.

### Components, Screens, and Layouts

DSKit offers a library of ready-to-use UI components and full-screen [layouts](Content/Layout-in-DSKit.md) that are designed to be easily integrated and customized within your projects. Start with the generated [component catalog](Content/Views.md), then open an individual view page such as [DSImageView](Content/Views/DSImageView.md), [DSList](Content/Views/DSList.md), or [DSSection](Content/Views/DSSection.md) when you need source links, testable examples, required preview images, and Explorer usage references. Use the generated [screen catalog](Content/Screens.md) when you need full DSKitExplorer examples with snapshot previews, source links, and the DSKit views used by each screen. For exhaustive component-to-screen references, use the generated [DSKitExplorer usage index](Content/Views/UsageIndex.md).

### Appearances

DSKit includes a selection of ready-to-use [appearances](Content/Appearance-in-DSKit.md) that support both light and dark modes, suitable for immediate integration into your projects. These appearances are fully customizable, allowing you to tweak and modify them according to your specific requirements. This flexibility ensures that you can maintain consistency across different themes while adapting to user preferences. 

### Running DSKitExplorer

Open `DSKitExplorer.xcodeproj`, select the `DSKitExplorer` scheme, and run it on an iPhone simulator. The repo's current automation target is `iPhone 17 Pro`; see [docs/WORKFLOWS.md](docs/WORKFLOWS.md) for CLI build, test, and documentation refresh commands.

## Contributions and support

DSKit is developed completely in the open, and contributions are welcome.

Before changing DSKit, read [CONTRIBUTING.md](CONTRIBUTING.md), [docs/WORKFLOWS.md](docs/WORKFLOWS.md), and the generated component or screen page for the area you are changing.

Generated docs are not edited by hand. Update Swift source comments, `Testable_*` examples, snapshots, or the generator, then run `cd Scripts && ./documentation_generator.sh`.

This project does not come with GitHub Issues-based support. Users are encouraged to become active participants by fixing bugs they encounter or improving documentation wherever it is lacking.

If you wish to make a change, open a [Pull Request](https://github.com/imodeveloper/dskit-swiftui/pulls), even if it just contains a draft of the changes you are planning or a test that reproduces an issue.

Hope you will enjoy using DSKit.
