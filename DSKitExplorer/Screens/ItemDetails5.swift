//
//  ItemDetails5.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//
import DSKit
import SwiftUI
struct ItemDetails5: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ItemDetails5Model()
    var body: some View {
        DSList {
            DSSection {
                DSCoverFlow(height: 250, data: viewModel.imageGallery, id: \.self) { imageUrl in
                    DSImageView(url: imageUrl).dsCornerRadius()
                }
                DSPickerView(
                    data: viewModel.colors,
                    id: \.self,
                    selected: $viewModel.selectedColor
                ) { color in
                    DSImageView(named: color, size: .size(width: 70, height: 50))
                }
                DSVStack(spacing: .space16) {
                    DSHStack {
                        DSVStack(spacing: .custom(0)) {
                            DSText(viewModel.title).dsTextStyle(.title2)
                            DSText(viewModel.subtitle).dsTextStyle(.subheadline)
                        }.dsFullWidth()
                    }
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
                }
                DSText(viewModel.description).dsTextStyle(.caption1)
            }
        }
        .safeAreaInset(edge: .bottom) {
            DSBottomContainer {
                DSHStack {
                    DSText("Total").dsTextStyle(.headline)
                    Spacer()
                    DSPriceView(price: viewModel.price, size: .headline)
                }
                DSButton(title: "Add to cart", style: .borderedLight) { dismiss() }
                DSButton(title: "Buy Now") { dismiss() }
                DSTermsAndConditions(message: "By continuing you agree to our")
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
final class ItemDetails5Model: ObservableObject {
    @Published var selectedSize: String = "US 5.5"
    @Published var selectedColor: String = "nike_2"
    let colors = ["nike_1", "nike_2", "nike_3", "nike_4", "nike_5", "nike_6"]
    let sizes = ["US 5", "US 5.5", "US 6", "US 6.5", "US 7", "US 7.5", "US 8", "US 8.5", "US 9"]
    let imageGallery = [p1Image, p3Image, p2Image]
    let title = "Women's Running Shoe"
    let subtitle = "Nike Revolution 5"
    let description = "The Nike Revolution 5 cushions your stride with soft foam to keep you running in comfort. Lightweight knit material wraps your foot in breathable support, while a minimalist design fits in anywhere your day takes you."
    let price = DSPrice(
        amount: "120",
        regularAmount: "200",
        currency: "$",
        discountBadge: "80$ OFF"
    )
}
// MARK: - Testable
struct Testable_ItemDetails5: View {
    var body: some View {
        NavigationView {
            ItemDetails5()
                .navigationTitle("Product Details")
                .platformBasedNavigationBarTitleDisplayModeInline()
        }
    }
}
// MARK: - Preview
struct ItemDetails5_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_ItemDetails5() }
    }
}
private let p1Image = ExplorerImageAssets.url(named: "web_home_screen4_sneakers_neon_bbaa5adb52")
private let p2Image = ExplorerImageAssets.url(named: "web_item_details1_p2_image_cf591e6cdf")
private let p3Image = ExplorerImageAssets.url(named: "web_item_details3_p1_image_3780bd094f")
