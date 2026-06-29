//
//  Items5.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Items5: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = Items5Model()

    var body: some View {
        DSList {
            DSSection {
                DSImageView(url: p0Image, size: .size(width: .none, height: 180))
                    .dsCornerRadius()
                    .overlay(alignment: .center) {
                        DSVStack(alignment: .center) {
                            DSText("Clothing")
                                .dsTextStyle(DSTypographyToken.custom(size: 30, weight: .semibold, relativeTo: .headline), Color.black)
                            DSText("73.3k items")
                                .dsTextStyle(DSTypographyToken.label, Color.black)
                        }
                    }
                DSHScroll(data: viewModel.filters, id: \.self) { title in
                    DSText(title).dsTextStyle(DSTypographyToken.label)
                        .dsPadding(.horizontal)
                        .dsCardStyle()
                        .dsHeight(.actionElement)
                        .onTap { dismiss() }
                }
                DSGrid(data: viewModel.products, id: \.id) { product in
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

extension Items5 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Data
        var body: some View {
            DSVStack(spacing: .custom(0)) {
                DSImageView(url: product.image)
                    .dsSecondaryBackground()
                DSVStack(spacing: .space4) {
                    DSText(product.title).dsTextStyle(DSTypographyToken.label)
                    DSText(product.description).dsTextStyle(.caption1)
                    DSPriceView(price: product.price, size: DSTypographyToken.label)
                }.dsPadding()
            }.overlay(alignment: .topTrailing, content: {
                DSImageView(
                    systemName: "heart.fill",
                    size: .font(.subheadline),
                    tint: .color(product.favourite ? .red : .white)
                )
                .dsPadding(.space8)
                .dsCornerRadius()
                .dsPadding(.space8)
            })
            .dsSecondaryBackground()
            .dsCornerRadius()
            .dsHeight(290)
        }

        struct Data: Identifiable {
            var id = UUID()
            let title: String
            let description: String
            var tag: String?
            let price: DSPrice
            var favourite: Bool = false
            let image: URL?
        }
    }
}

// MARK: - View Model

final class Items5Model {
    let products: [Items5.ProductView.Data] = [
        .init(
            title: "The Iconic Mesh Polo Shirt - All Fits",
            description: "Polo Ralph Lauren",
            tag: "SALES",
            price: DSPrice(amount: "22", regularAmount: "89", currency: "$"),
            favourite: true,
            image: p1Image
        ),
        .init(
            title: "Big Pony Mesh Polo Shirt",
            description: "Stella McCarthney",
            price: DSPrice(amount: "92", currency: "$"),
            image: p2Image
        ),
        .init(
            title: "Soft Cotton Polo Shirt - All Fits",
            description: "Hermes",
            price: DSPrice(amount: "13", regularAmount: "82", currency: "$", discountBadge: "-69$"),
            favourite: true,
            image: p4Image
        ),
        .init(
            title: "Big Pony Mesh Polo Shirt",
            description: "Arrmani", tag: "50% OFF",
            price: DSPrice(amount: "57", regularAmount: "85", currency: "$"),
            image: p5Image
        ),
        .init(
            title: "Polo Team Mesh Polo Shirt",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favourite: true,
            image: p6Image
        ),
        .init(
            title: "Polo Team Mesh Polo Shirt",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favourite: true,
            image: p7Image
        ),
        .init(
            title: "Mesh Long-Sleeve Polo Shirt – All Fits",
            description: "Dolce & Gabbana",
            price: DSPrice(amount: "84", currency: "$"),
            favourite: false,
            image: p3Image
        )
    ]

    let filters = ["Polo", "Denim", "Jackets", "Shirts", "Shorts", "Sweaters"]
}

// MARK: - Testable

struct Testable_Items5: View {
    var body: some View {
        NavigationView {
            Items5()
                .navigationTitle("Products")
                .platformBasedNavigationBarTitleDisplayModeInline()
        }
    }
}

// MARK: - Preview

struct Items5_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Items5() }
    }
}

// MARK: - Image Links

private let p0Image = ExplorerImageAssets.url(named: "web_items5_p0_image_9f6f2ac55a")

private let p1Image = ExplorerImageAssets.url(named: "web_items5_p1_image_39b766ad67")

private let p2Image = ExplorerImageAssets.url(named: "web_items5_p2_image_50cf662b17")

private let p3Image = ExplorerImageAssets.url(named: "web_items5_p3_image_47c3cfc573")

private let p4Image = ExplorerImageAssets.url(named: "web_items5_p4_image_1d9ded9ada")

private let p5Image = ExplorerImageAssets.url(named: "web_items5_p5_image_1038d0342e")

private let p6Image = ExplorerImageAssets.url(named: "web_items5_p6_image_9c3d236726")

private let p7Image = ExplorerImageAssets.url(named: "web_items5_p7_image_762016899c")
