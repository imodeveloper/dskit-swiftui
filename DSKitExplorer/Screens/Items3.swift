//
//  Items3.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Items3: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = Items3Model()

    var body: some View {
        DSList {
            DSSection {
                ForEach(viewModel.products) { product in
                    ProductView(product: product)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "arrow.up.arrow.down.circle.fill")
                    .onTap { dismiss() }
            }
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "line.horizontal.3.decrease.circle.fill")
                    .onTap { dismiss() }
            }
        }
    }
}

extension Items3 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Data
        var body: some View {
            ZStack {
                DSHStack(alignment: .center, spacing: .space16) {
                    DSImageView(url: product.image, size: .size(width: 90, height: 120))
                        .dsCornerRadius()
                    DSVStack(alignment: .leading) {
                        DSText(product.title).dsTextStyle(DSTypographyToken.label)
                        DSText(product.description).dsTextStyle(.caption2)
                        DSPriceView(price: product.price, size: DSTypographyToken.label)
                    }.dsFullWidth()
                }

                DSImageView(
                    systemName: "heart.fill",
                    size: .font(.subheadline),
                    tint: .color(product.favorite ? .red : .gray.opacity(0.5))
                )
                .dsPadding(.space8)
                .dsBackground(.primary)
                .dsCornerRadius()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            .dsPadding(.space8)
            .dsSecondaryBackground()
            .dsCornerRadius()
        }

        struct Data: Identifiable {
            let id = UUID()
            let title: String
            let description: String
            var tag: String?
            let price: DSPrice
            let favorite: Bool
            let image: URL?
        }
    }
}

// MARK: - View Model

final class Items3Model {
    let products: [Items3.ProductView.Data] = [
        .init(
            title: "The Iconic Mesh Polo Shirt - All Fits",
            description: "Polo Ralph Lauren",
            tag: "SALES",
            price: DSPrice(amount: "22", regularAmount: "89", currency: "$"),
            favorite: true,
            image: p1Image
        ),
        .init(
            title: "Big Pony Mesh Polo Shirt",
            description: "Stella McCarthney",
            price: DSPrice(amount: "92", currency: "$"),
            favorite: false,
            image: p2Image
        ),
        .init(
            title: "Soft Cotton Polo Shirt - All Fits",
            description: "Hermes",
            price: DSPrice(amount: "13", regularAmount: "82", currency: "$", discountBadge: "-69$"),
            favorite: true,
            image: p4Image
        ),
        .init(
            title: "Big Pony Mesh Polo Shirt",
            description: "Arrmani",
            tag: "50% OFF",
            price: DSPrice(amount: "57", regularAmount: "85", currency: "$"),
            favorite: false,
            image: p5Image
        ),
        .init(
            title: "Polo Team Mesh Polo Shirt",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favorite: true,
            image: p6Image
        ),
        .init(
            title: "Polo Team Mesh Polo Shirt",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favorite: true,
            image: p7Image
        ),
        .init(
            title: "Mesh Long-Sleeve Polo Shirt – All Fits",
            description: "Dolce & Gabbana",
            price: DSPrice(amount: "84", currency: "$"),
            favorite: false,
            image: p3Image
        )
    ]
}

// MARK: - Testable

struct Testable_Items3: View {
    var body: some View {
        NavigationView {
            Items3()
                .navigationTitle("Products")
        }
    }
}

// MARK: - Preview

struct Items3_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Items3() }
    }
}

// MARK: - Image Links

private let p1Image = ExplorerImageAssets.url(named: "web_items3_p1_image_1b474e81aa")
private let p2Image = ExplorerImageAssets.url(named: "web_items3_p2_image_838c47c481")
private let p3Image = ExplorerImageAssets.url(named: "web_items3_p3_image_a1cd060098")
private let p4Image = ExplorerImageAssets.url(named: "web_items3_p4_image_2f01cdf7b4")
private let p5Image = ExplorerImageAssets.url(named: "web_items3_p5_image_0b0c4f90b5")
private let p6Image = ExplorerImageAssets.url(named: "web_items3_p6_image_eb7182a212")
private let p7Image = ExplorerImageAssets.url(named: "web_items3_p7_image_28958d805f")
