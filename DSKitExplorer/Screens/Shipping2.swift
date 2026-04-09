//
//  Shipping2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import Observation
import SwiftUI

struct Shipping2: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = Shipping2Model()

    var body: some View {
        DSList {
            DSSection {
                DSRadioPickerView(data: viewModel.shippingMethods, id: \.id, selected: $viewModel.selected) { method, _ in
                    ShippingMethodView(method: method)
                }
                section(with: "Order Info") {
                    OrderInfo(orderTotals: viewModel.orderTotals)
                }
            }
        }.safeAreaInset(edge: .bottom) {
            DSBottomContainer {
                DSHStack {
                    DSText("Next Step:").dsTextStyle(DSTypographyToken.label)
                    DSText("Order Info")
                        .dsTextStyle(DSTypographyToken.custom(size: 14, weight: .regular, relativeTo: .subheadline))
                }
                DSButton(
                    title: "Continue",
                    rightSystemName: "arrow.right",
                    pushContentToSides: true,
                    style: .default,
                    action: {}
                )
            }
        }
    }

    func section(with title: String, @ViewBuilder content: @escaping () -> some View) -> some View {
        DSVStack(spacing: .space4) {
            DSText(title).dsTextStyle(DSTypographyToken.label)
            content()
        }
        .dsPadding(.top)
    }
}

extension Shipping2 {
    // MARK: - Order Info

    struct OrderInfo: View {
        let orderTotals: [Data]
        var body: some View {
            DSGroupedList(data: orderTotals, id: \.id) { total in
                DSHStack {
                    DSText(total.title)
                        .dsTextStyle(total.bold ? DSTypographyToken.label : .caption1)
                    Spacer()
                    DSPriceView(price: total.price, size: total.bold ? DSTypographyToken.label : .caption1)
                }.dsHeight(25)
            }
        }

        struct Data: Identifiable {
            let id = UUID()
            let title: String
            let price: DSPrice
            var bold: Bool = false
        }
    }

    // MARK: - Shipping Method

    struct ShippingMethodView: View {
        let method: Data
        var body: some View {
            DSText(method.title).dsTextStyle(DSTypographyToken.label)
            DSVStack(spacing: .space4) {
                DSHStack(spacing: .space4) {
                    DSImageView(systemName: "calendar", size: 12, tint: .text(.subheadline))
                    DSText(method.description).dsTextStyle(.caption1)
                }
                if let price = method.price {
                    DSPriceView(price: .init(amount: price, currency: "$"), size: DSTypographyToken.label)
                        .dsPadding(.top, .space8)
                } else {
                    DSText("Free")
                        .dsTextStyle(DSTypographyToken.label, .white)
                        .dsPadding(.vertical, .space8)
                        .dsPadding(.horizontal)
                        .dsBackground(.color(.green))
                        .dsCornerRadius()
                        .dsPadding(.top, .space8)
                }
            }
        }

        struct Data: Identifiable, Equatable {
            let id = UUID()
            let title: String
            let description: String
            var price: String?
            var selected: Bool = false
        }
    }
}

// MARK: - View Model

@Observable
@MainActor
final class Shipping2Model {
    let orderTotals: [Shipping2.OrderInfo.Data] = [
        .init(title: "Subtotal", price: DSPrice(amount: "160.00", currency: "$")),
        .init(title: "Shipping", price: DSPrice(amount: "4.70", currency: "$")),
        .init(title: "Total", price: DSPrice(amount: "130.0", currency: "$"), bold: true)
    ]

    let shippingMethods: [Shipping2.ShippingMethodView.Data] = [
        .init(
            title: "Free Shipping",
            description: "1 month - Friday, 27 July 2020"
        ),
        .init(
            title: "Standard Shipping",
            description: "2 weeks - Tuesday, 10 July 2020",
            price: "4.70",
            selected: true
        ),
        .init(
            title: "Express Shipping",
            description: "3-4 days - Sunday, 1 July 2020 ",
            price: "30.00"
        )
    ]

    var selected: Shipping2.ShippingMethodView.Data

    init() {
        selected = shippingMethods.first!
    }
}

// MARK: - Testable

struct Testable_Shipping2: View {
    var body: some View {
        NavigationView {
            Shipping2()
                .navigationTitle("Shipping")
        }
    }
}

// MARK: - Preview

struct Shipping2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Shipping2() }
    }
}
