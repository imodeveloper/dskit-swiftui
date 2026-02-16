//
//  AboutUsScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import SwiftUI
import DSKit

struct AboutUsScreen1: View {
    
    @State private var isSwitchOn = true
    @Environment(\.appearance) var appearance: DSAppearance
    
    let imageGallery = [p1Image, p2Image, p3Image]
    
    var body: some View {
        DSList {
            DSSection(spacing: .medium) {
                
                    DSText("Our Story")
                        .dsTextStyle(.title2)
                    DSText("Here you will feel the attitude, here you will receive quality, here you will see the atmosphere of an authentic store")
                        .dsTextStyle(.body)
                
                DSCoverFlow(height: 250, data: imageGallery, id: \.self) { image in
                    DSImageView(url: image)
                        .dsCornerRadius()
                }
                
                DSVStack(alignment: .leading) {
                    DSHStack(spacing: .medium) {
                        DSImageView(
                            systemName: "message.fill", 
                            size: .font(.headline),
                            tint: .text(.body)
                        )
                        DSText("Introducing Grocify, where convenience meets quality. Our goal: tailor solutions for modern grocery stores. With a focus on user-friendly technology, we empower stores of all sizes to thrive.")
                            .dsTextStyle(.caption1)
                            .dsFullWidth()
                    }
                    DSDivider()
                        .dsPadding(.leading, 30)
                    DSHStack(spacing: .medium) {
                        DSImageView(
                            systemName: "shippingbox.fill",
                            size: .font(.headline),
                            tint: .text(.body)
                        )
                        DSText("At Grocify, collaboration is key. Our team crafts cutting-edge tools for seamless operations, from inventory management to customer service. From local markets to supermarket chains, we're committed to elevating the grocery experience.")
                            .dsTextStyle(.subheadline)
                            .dsFullWidth()
                    }
                    DSDivider()
                        .dsPadding(.leading, 30)
                    DSHStack(spacing: .medium) {
                        DSImageView(
                            systemName: "leaf.arrow.triangle.circlepath",
                            size: .font(.headline),
                            tint: .text(.body)
                        )
                        DSText("Join us at Grocify, redefining the grocery industry. With intuitive solutions, we're shaping the future of shopping.")
                            .dsTextStyle(.footnote)
                            .dsFullWidth()
                    }
                }.dsCardStyle()
            }
        }
    }
}

// MARK: - Testable

struct Testable_AboutUsScreen1: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedTab: Int = 2
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Shop")
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }.tag(0)
            Text("Cart")
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }.tag(1)
            
            AboutUsScreen1()
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("About")
                }.tag(2)
            
            DSVStack {
                DSButton(title: "Dismiss", style: .clear) {
                    dismiss()
                }
            }.tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }.tag(3)
        }
    }
}

struct AboutUsScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_AboutUsScreen1() }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/1036857/pexels-photo-1036857.jpeg?cs=srgb&dl=pexels-artem-beliaikin-1036857.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?cs=srgb&dl=pexels-pixabay-264636.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/1402407/pexels-photo-1402407.jpeg?cs=srgb&dl=pexels-lisa-fotios-1402407.jpg&fm=jpg")
