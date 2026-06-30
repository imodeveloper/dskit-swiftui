//
//  DSKeyValueRow.swift
//  DSKit
//
//  Created by Ivan Borinschi on 30.06.2026.
//

import SwiftUI

/*
## DSKeyValueRow

`DSKeyValueRow` is a compact row for displaying a leading label and a trailing value. It is useful in summaries, forms, checkout totals, account details, and any card or grouped list where a piece of metadata needs a clear value on the opposite edge.

#### Initialization:
Initializes `DSKeyValueRow` with a title and a trailing value view.
- Parameters:
- `title`: The leading label.
- `titleStyle`: Typography used for the leading label.
- `spacing`: Horizontal spacing between the label, spacer, and trailing value.
- `value`: A trailing view, commonly `DSText`, `DSPriceView`, or a small `DSHStack`.

#### Usage:
Use `DSKeyValueRow` inside `DSGroupedList`, `DSCardSurface`, or `DSBottomContainer` when rows need consistent label/value alignment without duplicating spacer and typography code.
*/

public struct DSKeyValueRow<Value: View>: View {
    private let title: String
    private let titleStyle: DSTypographyToken
    private let titleColor: DSColorToken?
    private let spacing: DSSpatialToken
    private let value: Value

    public init(
        title: String,
        titleStyle: DSTypographyToken = .caption1,
        titleColor: DSColorToken? = nil,
        spacing: DSSpatialToken = .space8,
        @ViewBuilder value: () -> Value
    ) {
        self.title = title
        self.titleStyle = titleStyle
        self.titleColor = titleColor
        self.spacing = spacing
        self.value = value()
    }

    public var body: some View {
        DSHStack(alignment: .firstTextBaseline, spacing: spacing) {
            titleText
            Spacer(minLength: spacing.value)
            value
        }
    }

    @ViewBuilder
    private var titleText: some View {
        if let titleColor {
            DSText(title)
                .dsTextStyle(titleStyle, titleColor)
        } else {
            DSText(title)
                .dsTextStyle(titleStyle)
        }
    }
}

public extension DSKeyValueRow where Value == DSPriceView {
    init(
        title: String,
        price: DSPrice,
        titleStyle: DSTypographyToken = .caption1,
        titleColor: DSColorToken? = nil,
        priceStyle: DSTypographyToken = .caption1,
        priceColor: Color? = nil,
        spacing: DSSpatialToken = .space8
    ) {
        self.init(
            title: title,
            titleStyle: titleStyle,
            titleColor: titleColor,
            spacing: spacing
        ) {
            DSPriceView(price: price, size: priceStyle, color: priceColor)
        }
    }
}

public struct DSCountPriceValue: View {
    private let prefix: String
    private let count: String
    private let unit: String
    private let price: DSPrice
    private let prefixStyle: DSTypographyToken
    private let countStyle: DSTypographyToken
    private let priceStyle: DSTypographyToken

    public init(
        prefix: String = "for",
        count: String,
        unit: String = "items",
        price: DSPrice,
        prefixStyle: DSTypographyToken = .subheadline,
        countStyle: DSTypographyToken = .label,
        priceStyle: DSTypographyToken = .headline
    ) {
        self.prefix = prefix
        self.count = count
        self.unit = unit
        self.price = price
        self.prefixStyle = prefixStyle
        self.countStyle = countStyle
        self.priceStyle = priceStyle
    }

    public var body: some View {
        DSHStack(alignment: .firstTextBaseline, spacing: .space4) {
            DSText(prefix).dsTextStyle(prefixStyle)
            DSText(count).dsTextStyle(countStyle)
            DSText(unit).dsTextStyle(prefixStyle)
            DSPriceView(price: price, size: priceStyle)
        }
    }
}

public extension DSKeyValueRow where Value == DSCountPriceValue {
    init(
        title: String,
        count: String,
        unit: String = "items",
        price: DSPrice,
        titleStyle: DSTypographyToken = .headline,
        spacing: DSSpatialToken = .space8
    ) {
        self.init(
            title: title,
            titleStyle: titleStyle,
            spacing: spacing
        ) {
            DSCountPriceValue(count: count, unit: unit, price: price)
        }
    }
}

struct Testable_DSKeyValueRow: View {
    var body: some View {
        DSVStack(spacing: .space12) {
            DSCardSurface {
                DSVStack(spacing: .space12) {
                    DSKeyValueRow(title: "Subtotal", price: DSPrice(amount: "160.00", currency: "$"))
                    DSKeyValueRow(
                        title: "Shipping",
                        price: DSPrice(amount: "4.70", currency: "$")
                    )
                    DSKeyValueRow(
                        title: "Total",
                        price: DSPrice(amount: "164.70", currency: "$"),
                        titleStyle: .label,
                        priceStyle: .label
                    )
                }
            }

            DSCardSurface {
                DSKeyValueRow(title: "Status", titleStyle: .label) {
                    DSHStack(spacing: .space4) {
                        DSIconBadgeView(systemName: "checkmark", size: 20, iconSize: .font(.caption2))
                        DSText("Ready").dsTextStyle(.label)
                    }
                }
            }

            DSKeyValueRow(
                title: "Total",
                count: "4",
                price: DSPrice(amount: "1049.00", currency: "$")
            )
        }
    }
}

struct DSKeyValueRow_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSKeyValueRow()
            }
        }
    }
}
