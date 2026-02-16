//
//  FoodNearbyRestaurantScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import SwiftUI
import DSKit

struct FoodNearbyRestaurantScreen1: View {
    
    @StateObject var viewModel = FoodNearbyRestaurantScreen1Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSList {
            DSSection {
                ForEach(viewModel.popularProducts) { product in
                    PopularProductView(product: product)
                }
            }
        }
    }
}

extension FoodNearbyRestaurantScreen1 {
    
    // MARK: - CategoryView View
    struct PopularProductView: View {
        let product: Data
        
        var body: some View {
            DSVStack(spacing: .zero) {
                DSImageView(named: product.image)
                    .dsHeight(130)
                    .overlay(alignment: .bottomLeading) {
                        DSText(product.distance)
                            .dsTextStyle(.smallSubheadline)
                            .dsCardStyle(padding: .small)
                            .dsPadding()
                    }
                
                DSVStack(spacing: .zero) {
                    
                    DSHStack {
                        DSText(product.title)
                            .dsTextStyle(.headline)
                        
                        DSHStack {
                            DSHStack(spacing: .zero) {
                                DSImageView(
                                    systemName: "star.fill",
                                    size: .font(.smallSubheadline),
                                    tint: .color(.yellow)
                                )
                                DSText(product.rating)
                                    .dsTextStyle(.smallSubheadline)
                            }
                        }
                    }

                    DSText(product.description)
                        .dsTextStyle(.subheadline)

                }.dsPadding()
            }
            .dsSecondaryBackground()
            .dsCornerRadius()
        }

        struct Data: Identifiable, Equatable {
            let id = UUID()
            let title: String
            let description: String
            let distance: String
            let rating: String
            let image: String
        }
    }
}

// MARK: - Model

final class FoodNearbyRestaurantScreen1Model: ObservableObject {
        
    var popularProducts: [FoodNearbyRestaurantScreen1.PopularProductView.Data] = [
        .init(
            title: "Right From Oven",
            description: "Bread, Cake ⋅ $$",
            distance: "1.4 km",
            rating: "4.5",
            image: "Food_restaurant_place_1"
        ),
        .init(
            title: "Brown Coffee Shop",
            description: "Bread, Cake ⋅ $$",
            distance: "4.5 km",
            rating: "4.5",
            image: "Food_restaurant_place_2"
        ),
        .init(
            title: "Brown Bakery",
            description: "Bread, Cake ⋅ $$",
            distance: "12.1 km",
            rating: "4.5",
            image: "Food_restaurant_place_3"
        ),
        .init(
            title: "Salad Factory",
            description: "Bread, Cake ⋅ $$",
            distance: "14.4 km",
            rating: "4.5",
            image: "Food_restaurant_place_4"
        )
    ]
}

// MARK: - Testable

struct Testable_FoodNearbyRestaurantScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            FoodNearbyRestaurantScreen1()
                .navigationTitle("Restaurants")
        }
    }
}

// MARK: - Preview

struct FoodNearbyRestaurantScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_FoodNearbyRestaurantScreen1()
        }
    }
}

