//
//  ItemDetails1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct ItemDetails1: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = ItemDetails1Model()

    var body: some View {
        DSList {
            DSSection {
                DSCoverFlow(height: 250, data: viewModel.imageGallery, id: \.self) { imageUrl in
                    DSImageView(url: imageUrl).dsCornerRadius()
                }

                DSVStack(spacing: .custom(0)) {
                    DSText(viewModel.title).dsTextStyle(.title2)
                    DSText(viewModel.subtitle).dsTextStyle(.subheadline)
                }

                DSPriceView(price: viewModel.price, size: .headline)

                DSQuantityPicker()

                DSHStack {
                    SelectView(title: "Size", selection: "US 14").onTap {}
                    SelectColorView(title: "Color", selection: .yellow, label: "Yellow").onTap {}
                }

                DSText(viewModel.description).dsTextStyle(.caption1)
            }
        }
        .safeAreaInset(edge: .bottom) {
            DSBottomContainer {
                DSButton(title: "Add to cart", rightSystemName: "cart.fill") {
                    dismiss()
                }
                DSText(viewModel.priceDisclaimer, alignment: .center)
                    .dsTextStyle(.caption2)
                    .dsPadding(.horizontal)
            }
        }
        .toolbar {
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "square.and.arrow.up.fill").onTap { dismiss() }
            }
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "heart").onTap { dismiss() }
            }
        }
    }
}

extension ItemDetails1 {
    // MARK: - Select View

    struct SelectView: View {
        let title: String
        let selection: String
        var body: some View {
            DSHStack {
                DSText(title).dsTextStyle(DSTypographyToken.label)
                Spacer()
                DSText(selection).dsTextStyle(.caption1)
                DSChevronView()
            }
            .dsHeight(.actionElement)
            .dsPadding(.horizontal)
            .dsSecondaryBackground()
            .dsCornerRadius()
        }
    }

    struct SelectColorView: View {
        let title: String
        let selection: Color
        let label: String
        var body: some View {
            DSHStack {
                DSText(title).dsTextStyle(DSTypographyToken.label)
                Spacer()
                DSText(label).dsTextStyle(.caption1)
                selection
                    .dsSize(20)
                    .dsCornerRadius()
                DSChevronView()
            }
            .dsHeight(.actionElement)
            .dsPadding(.horizontal)
            .dsSecondaryBackground()
            .dsCornerRadius()
        }
    }
}

// MARK: - Model

final class ItemDetails1Model: ObservableObject {
    let imageGallery = [p3Image, p1Image, p2Image]
    let price = DSPrice(amount: "200.0", regularAmount: "200", currency: "$", discountBadge: "80$ OFF")
    let title = "Women's Running Shoe"
    let subtitle = "Nike Revolution 5"
    let description = "The Nike Revolution 5 cushions your stride with soft foam to keep you running in comfort. Lightweight knit material wraps your foot in breathable support, while a minimalist design fits in anywhere your day takes you."
    let priceDisclaimer = "The price listed here is subject to change. The final amount will be displayed on the checkout screen."
}

// MARK: - Testable

struct Testable_ItemDetails1: View {
    var body: some View {
        NavigationView {
            ItemDetails1()
                .navigationTitle("Product Details")
                .platformBasedNavigationBarTitleDisplayModeInline()
        }
    }
}

// MARK: - Preview

struct ItemDetails1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_ItemDetails1() }
    }
}

// MARK: - Image Links

private let p1Image = ExplorerImageAssets.url(named: "web_item_details1_p1_image_d1e3d2a7d5")
private let p2Image = ExplorerImageAssets.url(named: "web_item_details1_p2_image_cf591e6cdf")
private let p3Image = ExplorerImageAssets.url(named: "web_item_details1_p3_image_05393dc177")
