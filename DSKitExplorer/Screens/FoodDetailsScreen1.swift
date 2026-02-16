//
//  FoodDetailsScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import SwiftUI
import DSKit

struct FoodDetailsScreen1: View {
    
    @Environment(\.dismiss) var dismiss
    let ingredients = ["Food_Ingredient_1","Food_Ingredient_1","Food_Ingredient_1"]
    
    var body: some View {
        DSList {
            DSSection {
            
                DSImageView(named: "Food_menu_1", displayShape: .capsule)
                    .dsHeight(260)
                    .dsCornerRadius()
                
                DSVStack(spacing: .small) {
                    
                    DSText("Authentic Japanese Ramen")
                        .dsTextStyle(.title1)
                    
                    DSHStack() {
                        
                        DSPriceView(
                            price: .init(amount: "8", regularAmount: "10", currency: "$", discountBadge: "-2$"),
                            size: .headline
                        )
                        
                        DSHStack(spacing: .small) {
                            DSImageView(
                                systemName: "star.fill",
                                size: .font(.smallHeadline),
                                tint: .color(.yellow)
                            )
                            DSText("4.5")
                                .dsTextStyle(.smallHeadline)
                        }
                        
                        DSHStack(spacing: .small) {
                            DSImageView(
                                systemName: "clock.fill",
                                size: .font(.smallHeadline),
                                tint: .text(.smallHeadline)
                            )
                            DSText("30 min")
                                .dsTextStyle(.smallHeadline)
                        }
                    }
                }
                
                DSText("Lorem ipsum et dolor sit amet, and consectetur eadipiscing elit. Ametmo magna the cursus yum dolor praesenta the  pulvinar tristique the food.")
                    .dsTextStyle(.subheadline)
                
                DSVStack(spacing: .small) {
                    DSText("Main Ingredients")
                        .dsTextStyle(.smallHeadline)
                    DSGrid(columns: 8, data: 1...5, id: \.self) { id in
                        DSImageView(named: "Food_Ingredient_\(id)")
                            .dsHeight(40)
                            .dsCornerRadius()
                    }
                }
                
                DSVStack(spacing: .small) {
                    DSText("Food Information")
                        .dsTextStyle(.smallHeadline)
                    
                    DSHStack() {
                        DSHStack(spacing: .small) {
                            DSImageView(
                                named: "Fodd_Icon_Calories",
                                size: .font(.smallHeadline)
                            )
                            DSText("1990 kal")
                                .dsTextStyle(.smallHeadline)
                        }.dsCardStyle()
                        DSHStack(spacing: .small) {
                            DSImageView(
                                named: "Food_Icon_GluttenFree",
                                size: .font(.smallHeadline)
                            )
                            DSText("Gluten Free")
                                .dsTextStyle(.smallHeadline)
                        }.dsCardStyle()
                        DSHStack(spacing: .small) {
                            DSImageView(
                                named: "Food_Icon_Organic",
                                size: .font(.smallHeadline)
                            )
                            DSText("Organic")
                                .dsTextStyle(.smallHeadline)
                        }.dsCardStyle()
                    }
                }
            .dsPadding(.bottom)
        
            }}
        .safeAreaInset(edge: .bottom) {
            DSBottomContainer {
                DSButton(title: "Add to cart") { dismiss() }
                DSTermsAndConditions(message: "By continuing you agree to our")
            }
        }
    }
}


// MARK: - Testable

struct Testable_FoodDetailsScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            FoodDetailsScreen1()
                .navigationTitle("Product Details")
        }
    }
}

// MARK: - Preview

struct FoodDetailsScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_FoodDetailsScreen1()
        }
    }
}

