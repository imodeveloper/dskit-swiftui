//
//  BookingScreen4.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//
import DSKit
import MapKit
import SwiftUI
struct BookingScreen4: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = BookingScreen4Model()
    var body: some View {
        DSList {
            DSSection {
                ForEach(viewModel.barbers) { barber in
                    DSCardSurface {
                        Barber(barber: barber)
                    }.onTap { dismiss() }
                }
            }
        }
    }
}
extension BookingScreen4 {
    struct Barber: View {
        let barber: Data
        var body: some View {
            DSVStack {
                DSHStack(spacing: .space16) {
                    DSImageView(url: barber.image, style: .circle)
                        .dsSize(60)
                    DSVStack(spacing: .custom(0)) {
                        DSText(barber.name)
                            .dsTextStyle(.headline)
                        DSText(barber.grade)
                            .dsTextStyle(.subheadline)
                    }.dsFullWidth()
                    DSCardAccessory(.info, size: .smallIcon)
                }
                DSText("Nearest time for appointment")
                    .dsTextStyle(.caption2)
                DSGrid(columns: 4, data: barber.hours, id: \.self) { hour in
                    DSText(hour)
                        .dsTextStyle(DSTypographyToken.label)
                        .dsMaxWidthCentered()
                        .dsHeight(.actionElement)
                        .dsBackground(.primary)
                        .dsCornerRadius()
                }
            }
        }
        struct Data: Identifiable {
            let id = UUID()
            let name: String
            let grade: String
            let image: URL?
            let hours: [String]
        }
    }
}
// MARK: - Model
@MainActor
final class BookingScreen4Model: ObservableObject {
    let barbers: [BookingScreen4.Barber.Data] = [
        .init(
            name: "Ms. Ole Thompson",
            grade: "Pro Barber",
            image: p1Image,
            hours: ["13:00", "14:00"]
        ),
        .init(
            name: "Alexander Dickinson",
            grade: "Barber",
            image: p2Image,
            hours: ["11:00", "15:00", "16:00"]
        ),
        .init(
            name: "Dulce Kub",
            grade: "Pro Barber",
            image: p3Image,
            hours: ["13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]
        ),
        .init(
            name: "Nash Hansen",
            grade: "Super Pro Barber",
            image: p4Image,
            hours: ["13:00", "14:00", "15:00"]
        ),
        .init(
            name: "Perry Hudson",
            grade: "Barber",
            image: p5Image,
            hours: ["10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00"]
        ),
        .init(
            name: "John Mesh",
            grade: "Barber",
            image: p6Image,
            hours: ["17:00", "18:00", "19:00", "20:00"]
        )
    ]
}
// MARK: - Testable
struct Testable_BookingScreen4: View {
    var body: some View {
        NavigationView {
            BookingScreen4()
                .navigationTitle("Specialist")
        }
    }
}
// MARK: - Preview
struct BookingScreen4_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_BookingScreen4()
        }
    }
}
private let p1Image = ExplorerImageAssets.url(named: "web_booking_screen3_p1_image_fcc128bbd4")
private let p2Image = ExplorerImageAssets.url(named: "web_booking_screen4_p2_image_b9751a1173")
private let p3Image = ExplorerImageAssets.url(named: "web_booking_screen4_p3_image_c3502cfb22")
private let p4Image = ExplorerImageAssets.url(named: "web_booking_screen4_p4_image_04c6dac8d2")
private let p5Image = ExplorerImageAssets.url(named: "web_booking_screen4_p5_image_92b1deb00c")
private let p6Image = ExplorerImageAssets.url(named: "web_booking_screen4_p6_image_71ac7c85da")
