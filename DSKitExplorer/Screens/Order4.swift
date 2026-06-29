//
//  Order4.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Order4: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = Order4Model()

    var body: some View {
        DSVStack(alignment: .center) {
            Spacer()
            DSVStack {
                DSText("You may also like").dsTextStyle(.subheadline)
                DSHScroll(data: viewModel.suggestedProducts, id: \.id) { product in
                    SuggestedProductView(product: product)
                }
            }
            DSButton(title: "Continue Shopping", rightSystemName: "bag.fill", action: {
                dismiss()
            })

            .dsPadding(.bottom)
        }
        .overlay(alignment: .center, content: {
            DSVStack(alignment: .center) {
                Spacer()
                DSImageView(systemName: "checkmark.circle.fill", size: 70, tint: .color(.green))
                    .dsPadding(.bottom, 30)
                DSText("It's Ordered").dsTextStyle(DSTypographyToken.custom(size: 30, weight: .semibold, relativeTo: .headline))
                DSText("Hi John - thanks for your order,\nwe hope you enjoyed shopping\nwith us", alignment: .center)
                    .dsTextStyle(.subheadline)
                Spacer()
                Spacer()
            }
        })
        .dsScreen()
    }
}

extension Order4 {
    // MARK: - Suggested Product

    struct SuggestedProductView: View {
        let product: Data
        var body: some View {
            DSHStack(alignment: .center, spacing: .space8) {
                DSImageView(url: product.image, size: .size(width: 80, height: 60))
                    .dsCornerRadius()
                DSVStack(alignment: .leading, spacing: .space4) {
                    DSText(product.title, alignment: .leading)
                        .dsTextStyle(DSTypographyToken.custom(size: 12, weight: .semibold, relativeTo: .headline))
                    DSText(product.subtitle, alignment: .leading)
                        .dsTextStyle(.caption1)
                    DSPriceView(price: product.price, size: DSTypographyToken.label)
                }.frame(maxWidth: 160, alignment: .leading)
            }.dsCardStyle(padding: .space8)
        }

        struct Data: Identifiable {
            let id = UUID()
            let title: String
            let subtitle: String
            let price: DSPrice
            let image: URL?
        }
    }
}

// MARK: - View Model

final class Order4Model {
    let suggestedProducts: [Order4.SuggestedProductView.Data] = [
        .init(
            title: "New Balance All Fits",
            subtitle: "New Balance",
            price: DSPrice(amount: "250", regularAmount: "290", currency: "$"),
            image: sneakersWhiteOnYellowBg
        ),
        .init(
            title: "Big Pony Mesh Shoes",
            subtitle: "Nike",
            price: DSPrice(amount: "120", currency: "$"),
            image: sneakersThreePairs
        ),
        .init(
            title: "Mesh Long-Sleeve Sneakers All Fits",
            subtitle: "Reebok",
            price: DSPrice(amount: "145", currency: "$"),
            image: sneakersOnWhiteBg
        )
    ]
}

// MARK: - Testable

struct Testable_Order4: View {
    var body: some View {
        Order4()
    }
}

// MARK: - Preview

struct Order4_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Order4() }
    }
}

// MARK: - Image Links

private let sneakersThreePairs = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_three_pairs_32ce2597b8")
private let sneakersWhiteOnYellowBg = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_white_on_yellow_bg_100c84f711")
private let sneakersOnWhiteBg = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_on_white_bg_02b087dd14")
