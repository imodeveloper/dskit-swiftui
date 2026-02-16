//
//  FoodCategoriesScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import SwiftUI
import DSKit

struct FoodCategoriesScreen1: View {
    
    @StateObject var viewModel = FoodCategoriesScreen1Model()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        DSList {
            DSSection {
                DSGrid(
                    spacing: .regular,
                    data: viewModel.categories,
                    id: \.self.id
                ) { category in
                    CategoryView(category: category)
                }
                .dsPadding(.bottom)
            }
        }
    }
}

extension FoodCategoriesScreen1 {
    
    
    // MARK: - CategoryView View
    struct CategoryView: View {
        let category: Data
        
        var body: some View {
            DSVStack {
                DSImageView(named: category.image)
                DSHStack {
                    DSVStack(spacing: .zero) {
                        DSText(category.title)
                            .dsTextStyle(.smallHeadline)
                        DSText(category.subtitle)
                            .dsTextStyle(.smallSubheadline)
                    }
                    Spacer()
                    DSSFSymbolButton(
                        name: "chevron.right.square.fill",
                        size: .mediumIcon
                    )
                }
            }
            .dsCardStyle()
        }
        
        struct Data: Identifiable, Equatable {
            let id = UUID()
            let title: String
            let subtitle: String
            let image: String
        }
    }
}

// MARK: - Model

final class FoodCategoriesScreen1Model: ObservableObject {
        
    var categories: [FoodCategoriesScreen1.CategoryView.Data] = [
        .init(
            title: "Breakfast",
            subtitle: "30+ items",
            image: "Food_category_1"
        ),
        .init(
            title: "Salad Veggie",
            subtitle: "13+ items",
            image: "Food_category_2"
        ),
        .init(
            title: "Noodles",
            subtitle: "10+ items",
            image: "Food_category_3"
        ),
        .init(
            title: "Shimp Dishes",
            subtitle: "10+ items",
            image: "Food_category_4"
        ),
        .init(
            title: "Egg Dishes",
            subtitle: "10+ items",
            image: "Food_category_5"
        ),
        .init(
            title: "Seafood",
            subtitle: "10+ items",
            image: "Food_category_6"
        ),
        .init(
            title: "Pizza",
            subtitle: "10+ items",
            image: "Food_category_7"
        ),
        .init(
            title: "Pasta",
            subtitle: "10+ items",
            image: "Food_category_8"
        ),
        .init(
            title: "Noodles",
            subtitle: "10+ items",
            image: "Food_category_9"
        ),
        .init(
            title: "Noodles",
            subtitle: "10+ items",
            image: "Food_category_10"
        ),
        .init(
            title: "Meat",
            subtitle: "10+ items",
            image: "Food_category_11"
        )
    ]
}

// MARK: - Testable

struct Testable_FoodCategoriesScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            FoodCategoriesScreen1()
                .navigationTitle("Main Menu")
        }
    }
}

// MARK: - Preview

struct FoodCategoriesScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_FoodCategoriesScreen1()
            //.dsLayoutDebug()
        }
    }
}
