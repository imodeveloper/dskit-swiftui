//
//  DSList.swift
//  DSKit
//
//  Created by Ivan Borinschi on 02.01.2025.
//

import SwiftUI

/*
## DSList

`DSList` is a SwiftUI component within the DSKit framework designed to provide a consistent list layout with DSKit spacing, content margins, and background styling. It wraps SwiftUI's `List` and applies DSKit defaults.

#### Initialization:
Initializes a `DSList` with a spacing value and dynamic content.
- Parameters:
- `spacing`: Specifies the vertical spacing between list rows. Defaults to `.regular`.
- `content`: A `@ViewBuilder` closure that generates the list content.

#### Usage:
`DSList` is useful when you want list behavior with DSKit styling applied consistently across screens.
*/

public struct DSList<Content: View>: View {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.viewStyle) var viewStyle: DSViewStyle

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
        applySectionSpacing(
            List {
                content()
                    .dsScreen()
                    .dsDebuggable(debugColor: Color.mint)
                    .dsResetContentMargins()
            }
            .background(Color(viewStyle.colors(from: appearance).background))
            .listStyle(.plain)
            .listRowSpacing(appearance.spacing.value(for: spacing))
            .dsContentMargins()
        )
    }

    @ViewBuilder
    private func applySectionSpacing<ListContent: View>(_ view: ListContent) -> some View {
        if #available(iOS 17, *) {
            view.listSectionSpacing(0)
        } else {
            view
        }
    }
}

struct Testable_DSList: View {
    var body: some View {
        DSList(spacing: .custom(16)) {
            DSSection {
                DSVStack(spacing: .small) {
                    DSText("Title").dsTextStyle(.headline)
                    DSText("Subtitle").dsTextStyle(.caption2)
                }
            }
            DSSection {
                DSHStack {
                    DSButton(title: "Primary", action: { })
                    DSButton.callToActionLink(title: "Link", action: { })
                }
            }
        }
    }
}

struct DSList_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSList()
            }
        }
    }
}
