//
//  DSText.swift
//  DSKit
//
//  Created by Ivan Borinschi on 14.12.2022.
//

import SwiftUI

/*
## DSText

`DSText` is a SwiftUI component within the DSKit framework designed to display text with enhanced styling capabilities, allowing for customization according to the design system's guidelines. It integrates seamlessly with environmental settings for appearance and view style to ensure consistency across the application.

#### Initialization:
Initializes a `DSText` with the text content and optional alignment.
- Parameters:
- `text`: The text to be displayed.
- `alignment`: Alignment of the text within the view, defaulting to `.leading`.

#### Usage:
`DSText` is ideal for displaying any textual content where adherence to a design system is required. It supports multiple text styles and configurations, making it versatile for use in titles, body text, captions, and more.
*/

public struct DSText: View {
    
    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.viewStyle) var viewStyle: DSViewStyle
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Environment(\.textStyle) var textStyle: DSTextStyle
    
    let text: String
    let alignment: TextAlignment
    let lineSpacing: CGFloat
    
    public init(_ text: String, alignment: TextAlignment = .leading, lineSpacing: CGFloat = 0) {
        self.text = text
        self.alignment = alignment
        self.lineSpacing = lineSpacing
    }
    
    public var body: some View {
        Text(text)
            .font(textStyle.font(for: appearance, sizeCategory: sizeCategory))
            .foregroundStyle(textStyle.color(for: appearance, and: viewStyle))
            .multilineTextAlignment(alignment)
            .lineSpacing(lineSpacing)
            .dsDebuggable(debugColor: Color.orange.opacity(0.3))
    }
}

public extension DSText {
    
    func dsTextStyle(_ textFont: DSTextFontKey) -> some View {
        return self.environment(\.textStyle, DSTextStyle.textFont(textFont))
    }
    
    func dsTextStyle(_ textStyle: DSTextStyle) -> some View {
        return self.environment(\.textStyle, textStyle)
    }
    
    func dsTextStyle(_ textFont: DSTextFontKey, _ size: CGFloat) -> some View {
        return self.environment(\.textStyle, .textFont(.fontWithSize(textFont, size)))
    }
    
    func dsTextStyle(_ textFont: DSTextFontKey, _ size: CGFloat, _ dsColor: DSColorKey) -> some View {
        return self.environment(\.textStyle, .textFontWithColor(.fontWithSize(textFont, size), dsColor))
    }
    
    func dsTextStyle(_ textFont: DSTextFontKey, _ size: CGFloat, _ color: Color) -> some View {
        return self.environment(\.textStyle, .textFontWithColor(.fontWithSize(textFont, size), .color(color)))
    }
    
    func dsTextStyle(_ textStyle: DSTextStyle, _ dsColor: DSColorKey) -> some View {
        return self.environment(\.textStyle, .reStyleWithColor(textStyle, dsColor))
    }
    
    func dsTextStyle(_ textStyle: DSTextStyle, _ color: Color) -> some View {
        return self.environment(\.textStyle, .reStyleWithColor(textStyle, .color(color)))
    }
    
    func dsTextStyle(_ textFont: DSTextFontKey, _ dsColor: DSColorKey) -> some View {
        return self.environment(\.textStyle, .textFontWithColor(textFont, dsColor))
    }
    
    func dsTextStyle(_ textFont: DSTextFontKey, _ color: Color) -> some View {
        return self.environment(\.textStyle, .textFontWithColor(textFont, .color(color)))
    }
}

public indirect enum DSTextStyle: Equatable, Hashable {
    
    case textFont(DSTextFontKey)
    case textFontWithColor(DSTextFontKey, DSColorKey)
    case reStyleWithColor(DSTextStyle, DSColorKey)
    
    func textStyle(for appearance: DSAppearance) -> (font: DSTextFontKey, color: DSTextColorKey) {
        switch self {
        case .textFont(let font):
            return (font: font, color: DSTextColorKey.font(font))
        case .textFontWithColor(let font, let color):
            return (font: font, color: .dsColor(color))
        case .reStyleWithColor(let textStyle, let color):
            return (font: .fontWithSize(textStyle.dsTextFont, textStyle.dsTextFont.pointSize(for: appearance)), color: .dsColor(color))
        }
    }
    
    var dsTextFont: DSTextFontKey {
        return switch self {
        case .textFont(let font):
            font
        case .textFontWithColor(let font, _):
            font
        case .reStyleWithColor(let style, _):
            style.dsTextFont
        }
    }
    
    func font(for appearance: DSAppearance) -> Font {
        font(for: appearance, sizeCategory: nil)
    }
    
    func font(
        for appearance: DSAppearance,
        sizeCategory: ContentSizeCategory?
    ) -> Font {
        Font(uiFont(for: appearance, sizeCategory: sizeCategory))
    }
    
    private func uiFont(
        for appearance: DSAppearance,
        sizeCategory: ContentSizeCategory?
    ) -> DSFont {
        #if canImport(UIKit)
        let uiFont = dsTextFont.uiFont(for: appearance)
        guard let sizeCategory,
              let textStyle = dsTextFont.uiTextStyle()
        else {
            return uiFont
        }
        
        return UIFontMetrics(forTextStyle: textStyle)
            .scaledFont(
                for: uiFont,
                compatibleWith: UITraitCollection(preferredContentSizeCategory: sizeCategory.uiContentSizeCategory)
            )
        #else
        return dsTextFont.uiFont(for: appearance)
        #endif
    }
    
    func color(for appearance: DSAppearance, and viewStyle: DSViewStyle) -> Color {
        textStyle(for: appearance).color.color(for: appearance, and: viewStyle)
    }
    
    func size(_ appearance: DSAppearance) -> CGFloat {
        dsTextFont.uiFont(for: appearance).pointSize
    }
}

#if canImport(UIKit)
private extension ContentSizeCategory {
    var uiContentSizeCategory: UIContentSizeCategory {
        switch self {
        case .extraSmall:
            .extraSmall
        case .small:
            .small
        case .medium:
            .medium
        case .large:
            .large
        case .extraLarge:
            .extraLarge
        case .extraExtraLarge:
            .extraExtraLarge
        case .extraExtraExtraLarge:
            .extraExtraExtraLarge
        case .accessibilityMedium:
            .accessibilityMedium
        case .accessibilityLarge:
            .accessibilityLarge
        case .accessibilityExtraLarge:
            .accessibilityExtraLarge
        case .accessibilityExtraExtraLarge:
            .accessibilityExtraExtraLarge
        case .accessibilityExtraExtraExtraLarge:
            .accessibilityExtraExtraExtraLarge
        @unknown default:
            .medium
        }
    }
}

private extension DSTextFontKey {
    func uiTextStyle() -> UIFont.TextStyle? {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title1:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .caption1:
            return .caption1
        case .caption2:
            return .caption2
        case .footnote:
            return .footnote
        case .custom:
            return nil
        case .fontWithSize(let style, _):
            return style.uiTextStyle()
        case .smallHeadline, .largeHeadline:
            return .headline
        case .smallSubheadline:
            return .subheadline
        }
    }
}
#endif

struct DSTextStyleEnvironment: EnvironmentKey {
    static let defaultValue: DSTextStyle = .textFont(.body)
}

public extension EnvironmentValues {
    var textStyle: DSTextStyle {
        get { self[DSTextStyleEnvironment.self] }
        set { self[DSTextStyleEnvironment.self] = newValue }
    }
}

struct Testable_DSText: View {
    var body: some View {
        DSVStack {
            DSText("Large title").dsTextStyle(.largeTitle)
            DSText("Title 1").dsTextStyle(.title1)
            DSText("Title 2").dsTextStyle(.title2)
            DSText("Title 3").dsTextStyle(.title3)
            DSText("Headline").dsTextStyle(.headline)
            DSText("Headline with size 20").dsTextStyle(.headline, 20)
            DSText("Subheadline").dsTextStyle(.subheadline)
            DSText("Subheadline with size 20").dsTextStyle(.headline, 20)
            DSText("Body").dsTextStyle(.body)
            DSText("Callout").dsTextStyle(.callout)
            DSText("Caption 1").dsTextStyle(.caption1)
            DSText("Caption 2").dsTextStyle(.caption2)
            DSText("Footnote").dsTextStyle(.footnote)
            
            DSHStack {
                DSText(
                    "Lorem Ipsum is simply dummy text.",
                    alignment: .center
                )
                .dsTextStyle(.footnote)
                .border(Color.black, width: 1)
                DSText(
                    "Lorem Ipsum is simply dummy text.",
                    alignment: .leading
                )
                .dsTextStyle(.footnote)
                .border(Color.black, width: 1)
                DSText("Lorem Ipsum is simply dummy text.",
                       alignment: .trailing
                )
                .dsTextStyle(.footnote)
                .border(Color.black, width: 1)
            }
        }
    }
}

struct DSText_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSText()
            }
        }
    }
}

private let dsTextDynamicTypeSnapshots: [(String, ContentSizeCategory)] = [
    ("extraSmall", .extraSmall),
    ("small", .small),
    ("medium", .medium),
    ("large", .large),
    ("extraLarge", .extraLarge),
    ("extraExtraLarge", .extraExtraLarge),
    ("extraExtraExtraLarge", .extraExtraExtraLarge),
    ("accessibilityMedium", .accessibilityMedium),
    ("accessibilityLarge", .accessibilityLarge),
    ("accessibilityExtraLarge", .accessibilityExtraLarge),
    ("accessibilityExtraExtraLarge", .accessibilityExtraExtraLarge),
    ("accessibilityExtraExtraExtraLarge", .accessibilityExtraExtraExtraLarge)
]

struct DSText_DynamicType_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(dsTextDynamicTypeSnapshots, id: \.0) { label, category in
            DSPreviewForEachAppearance {
                DSPreview {
                    Testable_DSText()
                        .environment(\.sizeCategory, category)
                }
            }
            .previewDisplayName("DSText (\(label))")
        }
    }
}
