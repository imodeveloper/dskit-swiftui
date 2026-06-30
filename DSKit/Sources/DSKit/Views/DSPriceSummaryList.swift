//
//  DSPriceSummaryList.swift
//  DSKit
//
//  Created by Ivan Borinschi on 30.06.2026.
//

import SwiftUI

/*
## DSPriceSummaryList

`DSPriceSummaryList` renders checkout, order, shipping, or billing totals as a grouped list of price rows. It centralizes the repeated DSKitExplorer pattern of label/value rows with a visually emphasized total row.

#### Initialization:
Initializes `DSPriceSummaryList` with a collection of `DSPriceSummaryItem` values.
- Parameters:
- `items`: Display-ready rows containing a title, price, and optional emphasis flag.
- `rowHeight`: Optional fixed row height for compact summaries.

#### Usage:
Use `DSPriceSummaryList` for totals and adjustments after a screen has already mapped domain values into display-ready `DSPriceSummaryItem` rows. Keep tax, discount, and business calculations outside the component.
*/

public struct DSPriceSummaryItem: Identifiable {
    public let id: String
    public let title: String
    public let price: DSPrice
    public let isEmphasized: Bool

    public init(
        id: String? = nil,
        title: String,
        price: DSPrice,
        isEmphasized: Bool = false
    ) {
        self.id = id ?? title
        self.title = title
        self.price = price
        self.isEmphasized = isEmphasized
    }
}

public struct DSPriceSummaryList: View {
    private let items: [DSPriceSummaryItem]
    private let rowHeight: DSDimension?

    public init(
        items: [DSPriceSummaryItem],
        rowHeight: DSDimension? = 25
    ) {
        self.items = items
        self.rowHeight = rowHeight
    }

    public var body: some View {
        DSGroupedList(data: items, id: \.id) { item in
            let textStyle: DSTypographyToken = item.isEmphasized ? .label : .caption1
            DSKeyValueRow(
                title: item.title,
                price: item.price,
                titleStyle: textStyle,
                priceStyle: textStyle
            )
            .modifier(DSOptionalHeightModifier(height: rowHeight))
        }
    }
}

private struct DSOptionalHeightModifier: ViewModifier {
    let height: DSDimension?

    func body(content: Content) -> some View {
        if let height {
            content.dsHeight(height)
        } else {
            content
        }
    }
}

struct Testable_DSPriceSummaryList: View {
    private let items = [
        DSPriceSummaryItem(title: "Subtotal", price: DSPrice(amount: "160.00", currency: "$")),
        DSPriceSummaryItem(title: "Shipping", price: DSPrice(amount: "4.70", currency: "$")),
        DSPriceSummaryItem(
            title: "Promo",
            price: DSPrice(amount: "134.70", regularAmount: "164.70", currency: "$")
        ),
        DSPriceSummaryItem(
            title: "Total",
            price: DSPrice(amount: "130.00", currency: "$"),
            isEmphasized: true
        )
    ]

    var body: some View {
        DSPriceSummaryList(items: items)
    }
}

struct DSPriceSummaryList_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSPriceSummaryList()
            }
        }
    }
}
