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
    @StateObject private var viewModel = BookingScreen5Model()
    var body: some View {
        DSList {
            DSSection {
                Barber(barber: viewModel.barber)
                    .dsFullWidth(alignment: .center)
                    .onTap { dismiss() }
                DSVStack(spacing: .custom(0)) {
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
            DSVStack(alignment: .center, spacing: .space4) {
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
            DSCardSurface {
                DSHStack(spacing: .space16) {
                    DSImageView(url: feedback.image, style: .circle)
                        .dsSize(60)
                    DSVStack(spacing: .space4) {
                        DSText(feedback.userName).dsTextStyle(.headline)
                            .dsFullWidth()
                        DSMetadataRow {
                            DSMetadataTag("14.05.2024", systemName: "calendar")
                        }
                        DSRatingView(rating: 4.5, size: 12)
                        DSText(feedback.feedbackText).dsTextStyle(.caption1)
                            .dsFullWidth()
                    }
                }
            }
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
@MainActor
final class BookingScreen5Model: ObservableObject {
    let barber: BookingScreen5.Barber.Data = .init(
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
private let p1Image = ExplorerImageAssets.url(named: "web_booking_screen3_p1_image_fcc128bbd4")
private let userProfile1 = ExplorerImageAssets.url(named: "web_about_us_screen2_user_profile1_76991e04ef")
private let userProfile2 = ExplorerImageAssets.url(named: "web_about_us_screen2_user_profile2_3c39af609a")
private let userProfile3 = ExplorerImageAssets.url(named: "web_about_us_screen2_user_profile3_3073ed774b")
private let userProfile4 = ExplorerImageAssets.url(named: "web_about_us_screen2_user_profile4_00cbb971c3")
private let userProfile5 = ExplorerImageAssets.url(named: "web_about_us_screen2_user_profile5_fae256983b")
