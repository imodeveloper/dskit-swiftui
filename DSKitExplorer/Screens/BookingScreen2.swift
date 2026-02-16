//
//  BookingScreen2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import DSKit
import MapKit
import SwiftUI

struct BookingScreen2: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = BookingScreen2Model()
    var body: some View {
        DSList {
            DSSection {
                Location(address: viewModel.address)
                    .onTap { dismiss() }
                Option(icon: "person.fill", title: "Barber", subtitle: "Select specialist")
                    .onTap { dismiss() }
                Option(icon: "scissors.badge.ellipsis", title: "Service", subtitle: "Select service")
                    .onTap { dismiss() }
                Option(icon: "calendar", title: "Date & Time", subtitle: "Select date and time")
                    .onTap { dismiss() }
            }
        }
        .safeAreaInset(edge: .bottom) {
            DSBottomContainer {
                DSButton(title: "Book Now", rightSystemName: "bookmark.fill") {}
                DSTermsAndConditions(message: "By pressing 'Book Now' you agree with our")
            }
        }
    }
}

extension BookingScreen2 {
    struct Option: View {
        let icon: String
        let title: String
        let subtitle: String

        var body: some View {
            DSHStack(spacing: .medium) {
                DSImageView(systemName: icon, size: 23, tint: .text(.headline))
                DSVStack(spacing: .zero) {
                    DSText(title)
                        .dsTextStyle(.smallHeadline)
                    DSText(subtitle)
                        .dsTextStyle(.smallSubheadline)
                }.dsFullWidth()
                DSChevronView()
            }.dsCardStyle()
        }
    }

    struct Location: View {
        let address: Data
        var body: some View {
            DSVStack(spacing: .zero) {
                DSVStack(spacing: .small) {
                    DSText(address.name)
                        .dsTextStyle(.headline)
                    DSHStack {
                        DSImageView(
                            systemName: "house",
                            size: .font(.subheadline),
                            tint: .text(.smallSubheadline)
                        )
                        DSText(address.address)
                            .dsTextStyle(.smallSubheadline)
                    }
                }.dsPadding()
                Map(
                    coordinateRegion: address.$region,
                    annotationItems: [address]
                ) { place in
                    MapPin(
                        coordinate: place.coordinated,
                        tint: .red
                    )
                }
                .dsHeight(180)
                .disabled(true)
            }
            .dsSecondaryBackground()
            .dsCornerRadius()
        }

        struct Data: Identifiable {
            let id = UUID()
            let name: String
            let address: String
            let coordinated: CLLocationCoordinate2D
            @State var region: MKCoordinateRegion

            init(
                name: String,
                address: String,
                coordinated: CLLocationCoordinate2D
            ) {
                self.coordinated = coordinated
                self.address = address
                self.name = name
                _region = State(initialValue: MKCoordinateRegion(
                    center: coordinated,
                    span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001)
                ))
            }
        }
    }
}

// MARK: - Model

final class BookingScreen2Model: ObservableObject {
    @Published var address: BookingScreen2.Location.Data = .init(
        name: "Barbershop Broadway",
        address: "325 Broadway, Bayonne, NJ 07002, 7km away",
        coordinated: CLLocationCoordinate2D(latitude: 40.764382, longitude: -73.973045)
    )
}

// MARK: - Testable

struct Testable_BookingScreen2: View {
    var body: some View {
        NavigationView {
            BookingScreen2()
                .navigationTitle("New Booking")
        }
    }
}

// MARK: - Preview

struct BookingScreen2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_BookingScreen2()
        }
    }
}
