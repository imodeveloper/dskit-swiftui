//
//  DSPrice.swift
//  DSKit
//
//  Created by Borinschi Ivan on 21.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

/*
## DSPriceView

`DSPriceView` is a customizable view component designed to display price information effectively, accommodating various styles and states such as discounts. It adheres to the design system, responding dynamically to appearance and style settings.

#### Initializer:
Initializes a `DSPriceView` with a given `DSPrice` model, text font key for style, and an optional color.
- Parameters:
- `price`: `DSPrice` struct containing amount, currency, and optional regular amount and discount badge.
- `size`: `DSTypographyToken` indicating the text size and style.
- `color`: Optional `Color` for the price text, defaults to nil.
 
#### Usage:
The `DSPriceView` can display a standard price, a regular (crossed-out) price when a discount is applicable, and an optional discount badge.
*/

public struct DSPriceView: View, DSDesignable {

    @Environment(\.appearance) public var appearance: DSAppearance
    @Environment(\.surfaceStyle) public var surfaceStyle: DSSurfaceStyle

    let amount: String
    let regularAmount: String?
    let currency: String
    var discountBadge: String?
    var textFont: DSTypographyToken
    var color: Color?

    public init(price: DSPrice, size: DSTypographyToken, color: Color? = nil) {
        self.amount = price.amount
        self.currency = price.currency
        self.regularAmount = price.regularAmount
        self.discountBadge = price.discountBadge
        self.textFont = size
        self.color = color
    }

    var amountColor: DSColorToken {
        if let color {
            .custom(color)
        } else {
            .text(.secondary)
        }
    }

    public var body: some View {

        DSHStack(spacing: .space4) {

            DSHStack(spacing: .space0) {
                DSText(currency)
                    .dsTextStyle(textFont, amountColor)
                DSText(amount)
                    .dsTextStyle(textFont, amountColor)
            }

            if let regularAmount = regularAmount {
                ZStack {
                    DSText(regularAmount)
                        .dsTextStyle(textFont, amountColor)
                        .overlay(alignment: .center) {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(color(for: amountColor))
                                .offset(y: 1)
                        }.opacity(0.5)
                }
            }

            if let discountBadge = discountBadge {
                DSText(discountBadge)
                    .dsTextStyle(
                        .custom(
                            size: textFont.pointSize(for: appearance) * 0.72,
                            weight: .regular,
                            relativeTo: textFont
                        ),
                        .text(.brandOnBold)
                    )
                    .dsPadding(.horizontal, .space8)
                    .dsPadding(.vertical, .custom(2))
                    .dsBackground(.background(.brand))
                    .cornerRadius(appearance.price.badgeCornerRadius)
            }
        }
    }
}

public struct DSPrice {
    let amount: String
    let regularAmount: String?
    let currency: String
    var discountBadge: String?

    public init(amount: String, regularAmount: String? = nil, currency: String, discountBadge: String? = nil) {
        self.amount = amount
        self.regularAmount = regularAmount
        self.currency = currency
        self.discountBadge = discountBadge
    }
}

struct Testable_DSPriceView: View {
    let price = DSPrice(
        amount: "100",
        regularAmount: "250",
        currency: "$",
        discountBadge: "10% OFF"
    )
    var body: some View {
        DSVStack(spacing: .space8) {
            DSPriceView(price: price, size: .title1)
            DSPriceView(price: price, size: .title2)
            DSPriceView(price: price, size: .title3)
            DSPriceView(price: price, size: .headline)
            DSPriceView(price: price, size: .subheadline)
            DSPriceView(price: price, size: .caption1, color: .green)
            DSPriceView(price: price, size: .caption2, color: .green)
            DSPriceView(price: price, size: .footnote)
            DSPriceView(price: price, size: .custom(size: 20, weight: .semibold, relativeTo: .headline))
        }
    }
}

struct DSPrice_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSPriceView()
            }
        }
    }
}
