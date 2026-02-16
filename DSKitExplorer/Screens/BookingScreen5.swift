//
//  BookingScreen5.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import DSKit
import MapKit
import SwiftUI

struct BookingScreen5: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = BookingScreen5Model()
    var body: some View {
        DSList {
            DSSection {
                Barber(barber: viewModel.barber)
                    .dsFullWidth(alignment: .center)
                    .onTap { dismiss() }

                DSVStack(spacing: .zero) {
                    DSVStack {
                        ForEach(viewModel.feedbackArray) { feedback in
                            FeedbackView(feedback: feedback)
                        }
                    }
                    Spacer()
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            DSBottomContainer {
                DSButton(title: "Leave Feedback", rightSystemName: "message.fill") {}
            }
        }
    }
}

extension BookingScreen5 {
    struct Barber: View {
        let barber: Data
        var body: some View {
            DSVStack(alignment: .center, spacing: .small) {
                DSImageView(url: barber.image, style: .circle)
                    .dsSize(90)
                DSText(barber.name)
                    .dsTextStyle(.headline)
                DSText(barber.grade)
                    .dsTextStyle(.subheadline)
            }.dsPadding(.top, 25)
                .dsPadding(.bottom, 25)
        }

        struct Data: Identifiable {
            let id = UUID()
            let name: String
            let grade: String
            let image: URL?
        }
    }

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

// MARK: - Model

final class BookingScreen5Model: ObservableObject {
    @Published var barber: BookingScreen5.Barber.Data = .init(
        name: "Ms. Ole Thompson",
        grade: "Pro Barber",
        image: p1Image
    )

    let feedbackArray: [BookingScreen5.FeedbackView.Data] = [
        .init(
            userName: "Sophia",
            image: userProfile3,
            feedbackText: "As someone who values a good haircut, I appreciate the personalized care and expertise. It's like having a personal stylist!"
        ),
        .init(
            userName: "David",
            image: userProfile4,
            feedbackText: "The customer service here is exceptional. Anytime I've had a request, they've been quick to accommodate and deliver."
        ),
        .init(
            userName: "George",
            image: userProfile5,
            feedbackText: "This barber shop has transformed the way I look. The convenience, efficiency, and fantastic user interface make it my go-to place!"
        ),
        .init(
            userName: "Emily",
            image: userProfile1,
            feedbackText: "Getting a haircut here was an absolute delight. The attention to detail and friendly service made it a fantastic experience!"
        ),
        .init(
            userName: "Michael",
            image: userProfile2,
            feedbackText: "I love how efficient and seamless the booking process is. It saves me so much time!"
        )
    ]
}

// MARK: - Testable

struct Testable_BookingScreen5: View {
    var body: some View {
        NavigationView {
            BookingScreen5()
                .platformBasedNavigationBarTitleDisplayModeInline()
                .navigationTitle("Barber Details")
        }
    }
}

// MARK: - Preview

struct BookingScreen5_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_BookingScreen5()
        }
    }
}

private let p1Image = URL(string: "https://images.unsplash.com/photo-1554387415-b0c2fcce17fd?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")

private let userProfile1 = URL(string: "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=2459&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let userProfile2 = URL(string: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=2960&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let userProfile3 = URL(string: "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let userProfile4 = URL(string: "https://images.unsplash.com/photo-1489980557514-251d61e3eeb6?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let userProfile5 = URL(string: "https://images.unsplash.com/photo-1474176857210-7287d38d27c6?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
