//
//  DSSection.swift
//  DSKit
//
//  Created by Ivan Borinschi on 02.01.2025.
//

import SwiftUI

/*
## DSSection

`DSSection` is a SwiftUI component within the DSKit framework that wraps SwiftUI's `Section` and applies DSKit list styling, background, and content margins.

#### Initialization:
Initializes a `DSSection` with optional spacing and dynamic content.
- Parameters:
- `spacing`: Reserved for section spacing customization. Defaults to `.regular`.
- `content`: A `@ViewBuilder` closure that generates the section content.

#### Usage:
`DSSection` is intended to be used inside a `DSList` to keep list sections visually consistent with the design system.
*/

public struct DSSection<Content: View>: View {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.viewStyle) var viewStyle: DSViewStyle
    @Environment(\.dsContentMarginKey) var contentMargin: CGFloat

    let spacing: DSSpace
    let content: () -> Content

    public init(
        spacing: DSSpace = .regular,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.spacing = spacing
    }

    public var body: some View {
        Section {
            content()
                .dsResetContentMargins()
        }
        .dsDebuggable(debugColor: Color.yellow)
        .background(Color(viewStyle.colors(from: appearance).background))
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 0, leading: contentMargin, bottom: 0, trailing: contentMargin))
        .listSectionSeparator(.hidden)
        .listRowBackground(Color(viewStyle.colors(from: appearance).background))
    }
}

struct Testable_DSSection: View {
    var body: some View {
        DSList(spacing: .custom(12)) {
            DSSection {
                DSVStack(spacing: .small) {
                DSText("Section Title").dsTextStyle(.headline)
                DSText("Section body text").dsTextStyle(.caption2)
                }
            }
            DSSection {
                DSHStack {
                    DSButton(title: "Action", action: { })
                    DSButton.callToActionLink(title: "More", action: { })
                }
            }
        }
    }
}

struct DSSection_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSSection()
            }
        }
    }
}
