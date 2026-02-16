//
//  DSList.swift
//  DSKit
//
//  Created by Ivan Borinschi on 02.01.2025.
//

import SwiftUI

public struct DSSectionHeaderSpacingKey: EnvironmentKey {
    public static let defaultValue: CGFloat = .zero
}

public extension EnvironmentValues {
    var dsSectionHeaderSpacingKey: CGFloat {
        get { self[DSSectionHeaderSpacingKey.self] }
        set { self[DSSectionHeaderSpacingKey.self] = newValue }
    }
}

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

    let sectionSpacing: DSSpace
    let sectionHeaderSpacing: DSSpace
    let content: () -> Content

    public init(
        sectionSpacing: DSSpace = .regular,
        sectionHeaderSpacing: DSSpace = .zero,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.sectionSpacing = sectionSpacing
        self.sectionHeaderSpacing = sectionHeaderSpacing
    }

    public init(
        spacing: DSSpace = .regular,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            sectionSpacing: spacing,
            sectionHeaderSpacing: .zero,
            content: content
        )
    }

    public var body: some View {
        applySectionSpacing(
            List {
                content()
            }
            .background(Color(viewStyle.colors(from: appearance).background))
            .listStyle(.plain)
            .listRowSpacing(0)
            .environment(\.dsContentMarginKey, appearance.screenMargins)
            .environment(\.dsScrollableContentMarginKey, appearance.screenMargins)
            .environment(\.dsScreenMarginsAlreadyApplied, true)
            .environment(\.dsSectionHeaderSpacingKey, appearance.spacing.value(for: sectionHeaderSpacing))
        )
    }

    @ViewBuilder
    private func applySectionSpacing<ListContent: View>(_ view: ListContent) -> some View {
        if #available(iOS 17, *) {
            view.listSectionSpacing(appearance.spacing.value(for: sectionSpacing))
        } else {
            view.listRowSpacing(appearance.spacing.value(for: sectionSpacing))
        }
    }
}

struct Testable_DSList: View {
    private struct Category: Identifiable {
        let id = UUID()
        let title: String
    }

    private struct Product: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let imageURL: URL?
        let price: DSPrice
    }

    private let categories: [Category] = [
        .init(title: "Shoes"),
        .init(title: "Shirts"),
        .init(title: "Jeans"),
        .init(title: "Watches")
    ]

    private let topProducts: [URL?] = [
        URL(string: "https://images.pexels.com/photos/1478442/pexels-photo-1478442.jpeg?cs=srgb&dl=pexels-ray-piedra-1478442.jpg&fm=jpg"),
        URL(string: "https://images.pexels.com/photos/2421374/pexels-photo-2421374.jpeg?cs=srgb&dl=pexels-hoang-loc-2421374.jpg&fm=jpg"),
        URL(string: "https://images.pexels.com/photos/2300334/pexels-photo-2300334.jpeg?cs=srgb&dl=pexels-adrian-dorobantu-2300334.jpg&fm=jpg")
    ]

    private let products: [Product] = [
        .init(
            title: "New trend",
            description: "Colourful sneakers",
            imageURL: URL(string: "https://images.pexels.com/photos/2300334/pexels-photo-2300334.jpeg?cs=srgb&dl=pexels-adrian-dorobantu-2300334.jpg&fm=jpg"),
            price: DSPrice(amount: "100", regularAmount: "120", currency: "$", discountBadge: "20% Off")
        ),
        .init(
            title: "Shirts",
            description: "Fresh prints of Bel-Air",
            imageURL: URL(string: "https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c2hpcnRzfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"),
            price: DSPrice(amount: "50", regularAmount: "60", currency: "$", discountBadge: "15% Off")
        ),
        .init(
            title: "Shoes",
            description: "Bring power to you",
            imageURL: URL(string: "https://images.pexels.com/photos/267301/pexels-photo-267301.jpeg?cs=srgb&dl=pexels-pixabay-267301.jpg&fm=jpg"),
            price: DSPrice(amount: "200", regularAmount: "250", currency: "$", discountBadge: "20% Off")
        ),
        .init(
            title: "Watches",
            description: "Time is what you make",
            imageURL: URL(string: "https://images.pexels.com/photos/277390/pexels-photo-277390.jpeg?cs=srgb&dl=pexels-pixabay-277390.jpg&fm=jpg"),
            price: DSPrice(amount: "300", regularAmount: "350", currency: "$", discountBadge: "10% Off")
        ),
        .init(
            title: "Jeans",
            description: "Quality never goes down",
            imageURL: URL(string: "https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg?cs=srgb&dl=pexels-mnz-1598507.jpg&fm=jpg"),
            price: DSPrice(amount: "80", regularAmount: "90", currency: "$", discountBadge: "10% Off")
        ),
        .init(
            title: "T-Shirts",
            description: "Blink if you want me",
            imageURL: URL(string: "https://images.pexels.com/photos/761963/pexels-photo-761963.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
            price: DSPrice(amount: "40", regularAmount: "45", currency: "$", discountBadge: "10% Off")
        )
    ]

    var body: some View {
        DSList(sectionSpacing: .medium, sectionHeaderSpacing: .medium) {

            DSSection {
                DSHStack {
                    DSVStack(spacing: .zero) {
                        DSText("Shop").dsTextStyle(.largeHeadline)
                        DSText("Over 45k items available for you").dsTextStyle(.subheadline)
                    }
                    Spacer()
                    DSImageView(
                        url: URL(string: "https://images.pexels.com/photos/3760707/pexels-photo-3760707.jpeg?cs=srgb&dl=pexels-sound-on-3760707.jpg&fm=jpg"),
                        style: .circle,
                        size: 50
                    )
                }
            }

            DSSection {
                DSCoverFlow(height: .custom(220), data: topProducts, id: \.self) { imageURL in
                    DSImageView(url: imageURL, style: .capsule)
                }
            }

            DSSection {
                DSSectionHeaderView(title: "Categories", actionTitle: "View all", action: { })
                DSGrid(data: categories, id: \.id) { category in
                    DSText(category.title).dsTextStyle(.smallHeadline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .dsCardStyle()
                }
            }

            DSSection {
                DSSectionHeaderView(title: "Discounts", actionTitle: "View all", action: { })
                DSGrid(viewHeight: 180, data: products, id: \.id) { product in
                    DSVStack {
                        DSImageView(
                            url: product.imageURL,
                            style: .capsule
                        )
                        DSVStack(spacing: .zero) {
                            DSText(product.title).dsTextStyle(.smallHeadline)
                            DSText(product.description).dsTextStyle(.smallSubheadline)
                            DSPriceView(price: product.price, size: .smallHeadline)
                                .dsPadding(.top, .regular)
                        }
                    }.dsPadding(.bottom)
                }
            }
        }
    }
}
struct DSList_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_DSList().dsLayoutDebug()
        }
    }
}
