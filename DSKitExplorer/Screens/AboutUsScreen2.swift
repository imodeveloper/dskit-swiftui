//
//  AboutUsScreen2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import DSKit
import MapKit
import SwiftUI

struct AboutUsScreen2: View {
    init(selectedTab: Int = 2) {
        _selectedTab = State(initialValue: selectedTab)
    }

    @Environment(\.appearance) var appearance: DSAppearance
    @State private var selectedTab: Int
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )

    let viewModel = AboutUsScreen2Model()
    let infoImageGallery = [p1Image, p2Image, p3Image]

    var body: some View {
        DSList {
            DSSection {
                Picker("Section", selection: $selectedTab) {
                    Text("Info").tag(0)
                    Text("Feedback").tag(1)
                    Text("Contacts").tag(2)
                }.pickerStyle(.segmented)

                switch selectedTab {
                case 0:
                    infoView
                case 1:
                    feedbackView
                case 2:
                    contactsView
                default:
                    infoView
                }
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            if selectedTab == 1 {
                DSBottomContainer {
                    DSButton(title: "Leave feedback", rightSystemName: "message.fill", action: {})
                        .dsPadding(.bottom, .medium)
                }
            }

        })
    }

    var infoView: some View {
        DSVStack {
            DSVStack {
                DSText("Grocify")
                    .dsTextStyle(.title2)
                    .dsFullWidth()
                DSText("Here you will feel the attitude, here you will receive quality, here you will see the atmosphere of an authentic store")
                    .dsFullWidth()
            }

            DSCoverFlow(height: 200, data: infoImageGallery, id: \.self) { image in
                DSImageView(url: image)
                    .dsCornerRadius()
            }

            DSVStack {
                DSText("Introducing Grocify, where convenience meets quality. Our goal: tailor solutions for modern grocery stores. With a focus on user-friendly technology, we empower stores of all sizes to thrive.")
                    .dsTextStyle(.body)
                    .dsFullWidth()
                DSText("At Grocify, collaboration is key. Our team crafts cutting-edge tools for seamless operations, from inventory management to customer service. From local markets to supermarket chains, we're committed to elevating the grocery experience.")
                    .dsTextStyle(.subheadline)
                    .dsFullWidth()
                    .dsCardStyle()
                DSText("Join us at Grocify, redefining the grocery industry. With intuitive solutions, we're shaping the future of shopping.")
                    .dsTextStyle(.body)
                    .dsFullWidth()
            }
        }
    }

    var feedbackView: some View {
        DSVStack(spacing: .zero) {
            DSVStack {
                ForEach(viewModel.feedbackArray) { feedback in
                    FeedbackView(feedback: feedback)
                }
            }
            Spacer()
        }
    }

    var contactsView: some View {
        DSVStack(spacing: .zero) {
            ScrollView {
                DSVStack {
                    ContactView(iconName: "phone.fill", title: "Phone:", info: "+373 791 93398")
                    ContactView(iconName: "map.fill", title: "Address:", info: "Alexandru Cel Bun 13/2")
                    ContactView(iconName: "clock.fill", title: "Working Hours:", info: "Open ⋅ Closes 5PM")

                    DSHStack(alignment: .healthSafetyAlignment, spacing: .regular) {
                        DSVStack(spacing: .medium) {
                            DSImageView(systemName: "info.circle.fill", size: .font(.headline), tint: .text(.headline))
                                .alignmentGuide(.healthSafetyAlignment) { d in d[VerticalAlignment.center] }
                        }

                        DSVStack {
                            DSText("Health and safety").dsTextStyle(.headline)
                                .alignmentGuide(.healthSafetyAlignment) { d in d[VerticalAlignment.center] }
                            DSText("· Mask required\n· Temperature check required\n· Staff wear masks\n· Staff get temperature checks")
                                .dsTextStyle(.subheadline, 14)
                                .dsFullWidth()
                        }
                    }
                    .dsPadding()
                    .dsSecondaryBackground()
                    .dsCornerRadius()

                    Map(coordinateRegion: $region)
                        .dsFullWidth()
                        .dsHeight(200)
                        .dsCornerRadius()
                        .disabled(true)

                    DSButton(title: "Get directions", rightSystemName: "location.fill", action: {})
                }
                Spacer()
            }
        }
    }
}

extension AboutUsScreen2 {
    struct FeedbackView: View {
        let feedback: Data
        var body: some View {
            DSHStack(spacing: .medium) {
                DSImageView(url: feedback.image, style: .circle)
                    .dsSize(60)
                DSVStack(spacing: .small) {
                    DSText(feedback.userName).dsTextStyle(.headline)
                        .dsFullWidth()
                    DSHStack {
                        DSImageView(systemName: "calendar", size: .font(.smallSubheadline), tint: .text(.caption1))
                        DSText("14.05.2024").dsTextStyle(.smallSubheadline)
                    }
                    DSRatingView(rating: 4.5, size: 12)
                    DSText(feedback.feedbackText).dsTextStyle(.caption1)
                        .dsFullWidth()
                }
            }
            .dsPadding()
            .dsSecondaryBackground()
            .dsCornerRadius()
        }

        struct Data: Identifiable {
            let id = UUID()
            let userName: String
            let image: URL?
            let feedbackText: String
        }
    }
}

private extension VerticalAlignment {
    struct HealthSafetyAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.top]
        }
    }

    static let healthSafetyAlignment = VerticalAlignment(HealthSafetyAlignment.self)
}

struct ContactView: View {
    let iconName: String
    let title: String
    let info: String

    var body: some View {
        DSHStack {
            DSImageView(systemName: iconName, size: .font(.headline), tint: .text(.headline))
            DSHStack {
                DSText(title).dsTextStyle(.smallHeadline)
                DSText(info)
                    .dsTextStyle(.subheadline, 14)
                    .dsFullWidth()
            }
        }.dsCardStyle()
    }
}

// MARK: - Model

final class AboutUsScreen2Model: ObservableObject {
    let feedbackArray: [AboutUsScreen2.FeedbackView.Data] = [
        .init(
            userName: "Emily",
            image: userProfile1,
            feedbackText: "Grocify has made managing my grocery store a breeze. The inventory management tools are so intuitive!"
        ),
        .init(
            userName: "Michael",
            image: userProfile2,
            feedbackText: "I love how Grocify streamlines the checkout process. It's made shopping for groceries much faster."
        ),
        .init(
            userName: "Sophia",
            image: userProfile3,
            feedbackText: "As a small local market owner, I appreciate the personalized support Grocify provides. It's like having a dedicated tech team!"
        ),
        .init(
            userName: "David",
            image: userProfile4,
            feedbackText: "The customer service at Grocify is top-notch. Anytime I've had an issue, they've been quick to respond and resolve it."
        ),
        .init(
            userName: "George",
            image: userProfile5,
            feedbackText: "Grocify has transformed the way I shop for groceries. It's convenient, efficient, and the user interface is fantastic!"
        )
    ]
}

// MARK: - Testable

struct Testable_AboutUsScreen2: View {
    var selectedTab: Int = 0
    @Environment(\.dismiss) var dismiss
    @State var tab: Int = 2
    var body: some View {
        TabView(selection: $tab) {
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
            AboutUsScreen2(selectedTab: selectedTab)
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

// MARK: - Preview

struct AboutUsScreen2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_AboutUsScreen2() }
    }
}

private let p1Image = URL(string: "https://images.pexels.com/photos/164763/pexels-photo-164763.jpeg?cs=srgb&dl=pexels-pixabay-164763.jpg&fm=jpg")
private let p2Image = URL(string: "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?cs=srgb&dl=pexels-pixabay-264636.jpg&fm=jpg")
private let p3Image = URL(string: "https://images.pexels.com/photos/1402407/pexels-photo-1402407.jpeg?cs=srgb&dl=pexels-lisa-fotios-1402407.jpg&fm=jpg")

private let userProfile1 = URL(string: "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=2459&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let userProfile2 = URL(string: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2960&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let userProfile3 = URL(string: "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let userProfile4 = URL(string: "https://images.unsplash.com/photo-1489980557514-251d61e3eeb6?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let userProfile5 = URL(string: "https://images.unsplash.com/photo-1474176857210-7287d38d27c6?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
