//
//  ItemDetails2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//
import DSKit
import SwiftUI
struct ItemDetails2: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ItemDetails2Model()
    var body: some View {
        DSList {
            DSSection {
                DSCoverFlow(height: 250, data: viewModel.imageGallery, id: \.self) { imageUrl in
                    DSImageView(url: imageUrl).dsCornerRadius()
                }
                DSVStack(spacing: .space16) {
                    DSVStack(spacing: .custom(0)) {
                        DSText(viewModel.title).dsTextStyle(.title2)
                        DSText(viewModel.subtitle).dsTextStyle(.subheadline)
                    }
                    DSPriceView(price: viewModel.price, size: .headline)
                    DSQuantityPicker()
                }
                DSPickerView(
                    style: .grid(columns: 4),
                    data: viewModel.sizes,
                    id: \.self, selected: $viewModel.selectedSize
                ) { size in
                    DSText(size).dsTextStyle(DSTypographyToken.label)
                        .frame(maxWidth: .infinity)
                        .dsPadding(.horizontal)
                        .dsHeight(.actionElement)
                        .dsSecondaryBackground()
                }.dsSectionStyle(title: "Size")
                DSPickerView(
                    data: viewModel.colors,
                    id: \.self,
                    selected: $viewModel.selectedColor
                ) { color in
                    DSImageView(named: color, size: .size(width: 80, height: 60))
                }.dsSectionStyle(title: "Model")
                DSText(viewModel.description).dsTextStyle(.callout)
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
// MARK: - Model
@MainActor
final class ItemDetails2Model: ObservableObject {
    @Published var selectedSize: String = "US 5.5"
    @Published var selectedColor: String = "nike_2"
    let colors = ["nike_1", "nike_2", "nike_3", "nike_4", "nike_5", "nike_6"]
    let sizes = ["US 5", "US 5.5", "US 6", "US 6.5", "US 7", "US 7.5", "US 8", "US 8.5", "US 9"]
    let imageGallery = [p4Image, p3Image, p1Image, p2Image]
    let title = "Women's Running Shoe"
    let subtitle = "Nike Revolution 5"
    let description = "The Nike Revolution 5 cushions your stride with soft foam to keep you running in comfort. Lightweight knit material wraps your foot in breathable support, while a minimalist design fits in anywhere your day takes you."
    let priceDisclaimer = "The price listed here is subject to change. The final amount will be displayed on the checkout screen."
    let price = DSPrice(
        amount: "120.0",
        regularAmount: "200",
        currency: "$",
        discountBadge: "80$ OFF"
    )
}
// MARK: - Testable
struct Testable_ItemDetails2: View {
    var body: some View {
        NavigationView {
            ItemDetails2()
                .navigationTitle("Product Details")
                .platformBasedNavigationBarTitleDisplayModeInline()
        }
    }
}
// MARK: - Preview
struct ItemDetails2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_ItemDetails2() }
    }
}
// MARK: - Image Links
private let p1Image = ExplorerImageAssets.url(named: "web_item_details2_p1_image_83ed9fc42d")
private let p2Image = ExplorerImageAssets.url(named: "web_item_details2_p2_image_3247001761")
private let p3Image = ExplorerImageAssets.url(named: "web_item_details1_p3_image_05393dc177")
private let p4Image = ExplorerImageAssets.url(named: "web_item_details2_p4_image_574e90dc3f")
