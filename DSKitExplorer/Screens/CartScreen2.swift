//
//  CartScreen2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct CartScreen2: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = CartScreen2Model()

    var body: some View {
        DSList {
            DSSection {
                ForEach(viewModel.products) { product in
                    ProductView(product: product)
                }
            }
        }.safeAreaInset(edge: .bottom) {
            DSBottomContainer {
                DSKeyValueRow(title: "Total", count: "2", price: DSPrice(amount: "349.00", currency: "$"))
                DSButton(title: "Continue") {
                    dismiss()
                }
                PoweredByDSKitView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "square.and.arrow.up.fill").onTap { dismiss() }
            }
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "trash.fill").onTap { dismiss() }
            }
        }
    }
}

extension CartScreen2 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Product
        var body: some View {
            DSVStack(spacing: .custom(0)) {
                DSImageView(url: product.image, size: .size(width: .none, height: 180))
                DSVStack {
                    DSText(product.title).dsTextStyle(.headline)
                    DSHStack {
                        DSText(product.description).dsTextStyle(.caption1)
                        DSRatingView(rating: product.rating, size: 13)
                    }
                    DSPriceView(price: product.price, size: DSTypographyToken.label)
                }
                .dsFullWidth()
                .overlay(alignment: .trailing, content: {
                    DSButton(
                        title: "Remove",
                        rightSystemName: "trash",
                        style: .clear,
                        maxWidth: false,
                        action: {}
                    )
                })
                .frame(maxWidth: .infinity)
                .dsPadding()
            }
            .dsSecondaryBackground()
            .dsCornerRadius()
        }

        struct Product: Identifiable {
            let id = UUID()
            let title: String
            let description: String
            let price: DSPrice
            let rating: Float
            let image: URL?
        }
    }
}

// MARK: - Model

final class CartScreen2Model: ObservableObject {
    let products: [CartScreen2.ProductView.Product] = [
        .init(
            title: "Sony XDE F30 Camera",
            description: "Sony",
            price: DSPrice(amount: "250", regularAmount: "270", currency: "$", discountBadge: "-20$"),
            rating: 4,
            image: p1Image
        ),
        .init(
            title: "Cannon Camera",
            description: "Cannon",
            price: DSPrice(amount: "99", regularAmount: "150", currency: "$", discountBadge: "-51$"),
            rating: 4.5,
            image: p2Image
        )
    ]
}

// MARK: - Testable

struct Testable_CartScreen2: View {
    var body: some View {
        NavigationView {
            CartScreen2()
                .navigationTitle("My Cart")
                .platformBasedNavigationBarTitleDisplayModeInline()
        }
    }
}

// MARK: - Preview

struct CartScreen2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_CartScreen2() }
    }
}

// MARK: - Image Links

private let p1Image = ExplorerImageAssets.url(named: "web_cart_screen2_p1_image_8f1220b3c8")

private let p2Image = ExplorerImageAssets.url(named: "web_cart_screen2_p2_image_1f0bc5594e")
