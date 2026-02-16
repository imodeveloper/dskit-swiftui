//
//  Filters3.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Filters3: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = Filters3Model()

    var body: some View {
        DSList {
            DSSection {
                OptionView(title: "Brand", option: "Adidas, Puma, HRX")
                OptionToggleView(title: "Free shipping")
                OptionView(title: "Shipping to", option: "London UK")
                OptionRangeView(title: "Range")

                DSPickerView(
                    data: viewModel.sizes,
                    id: \.self,
                    selected: $viewModel.selectedSize
                ) { size in
                    DSText(size).dsTextStyle(.smallHeadline)
                        .frame(maxWidth: .infinity)
                        .dsSize(dimension: .actionElement)
                        .dsSecondaryBackground()
                }.dsSectionStyle(title: "Size")

                DSPickerView(
                    data: viewModel.colors,
                    id: \.self,
                    selected: $viewModel.selectedColor
                ) { color in
                    Color(color)
                        .dsSize(dimension: .actionElement)
                }.dsSectionStyle(title: "Color")
            }
        }
        .safeAreaInset(edge: .bottom) {
            DSBottomContainer {
                DSButton(
                    title: "View (235) Items",
                    action: { dismiss() }
                )
            }
        }.toolbar {
            ToolbarItem(placement: .automatic) {
                DSButton(title: "Reset", style: .toolbar, action: {})
            }
        }
    }
}

extension Filters3 {
    // MARK: - Option View

    struct OptionView: View {
        let title: String
        let option: String
        var body: some View {
            DSHStack {
                DSText(title).dsTextStyle(.smallHeadline)
                Spacer()
                DSText(option).dsTextStyle(.subheadline, 14)
                DSChevronView()
            }.dsCardStyle()
        }
    }

    // MARK: - Toggle View

    struct OptionToggleView: View {
        let title: String
        @State private var isSwitchOn = true
        @Environment(\.appearance) var appearance: DSAppearance

        var body: some View {
            DSHStack {
                DSText(title).dsTextStyle(.smallHeadline)
                Spacer()
                Toggle("Show welcome message", isOn: $isSwitchOn)
                    .tint(Color.green)
                    .labelsHidden()
            }.dsCardStyle()
        }
    }

    // MARK: - Range View

    struct OptionRangeView: View {
        let title: String
        @State private var value: Double = 20
        @Environment(\.appearance) var appearance: DSAppearance

        var body: some View {
            DSHStack {
                DSText(title).dsTextStyle(.smallHeadline)
                Spacer()
                Slider(value: $value, in: 0 ... 100).tint(Color.green)
                DSText("\(round(value))").dsTextStyle(.subheadline)
                    .dsWidth(40)
            }.dsCardStyle()
        }
    }
}

// MARK: - View Model

final class Filters3Model: ObservableObject {
    @Published var selectedSize: String = "10"
    let sizes = ["8", "9", "10", "11", "12", "13", "14", "15", "16"]

    @Published var selectedColor: DSUIColor = .init(0xF88F6F)
    let colors = [DSUIColor(0xFFC6A3),
                  DSUIColor(0xF88F6F),
                  DSUIColor(0x5CB946),
                  DSUIColor(0x006A7A),
                  DSUIColor(0x28527A),
                  DSUIColor(0x8AC4D0),
                  DSUIColor(0xFBEEAC)]

    @Published var selectedSortByOption = "Chelsea Boots"
    let sortByOptions = ["Boots", "Chelsea Boots", "Casual Sneakers", "Casual Shoes"]
}

// MARK: - Testable

struct Testable_Filters3: View {
    var body: some View {
        NavigationView {
            Filters3()
                .navigationTitle("Filters")
        }
    }
}

// MARK: - Preview

struct Filters3_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Filters3() }
    }
}
