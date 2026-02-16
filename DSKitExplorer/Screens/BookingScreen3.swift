//
//  BookingScreen3.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import DSKit
import MapKit
import SwiftUI

struct BookingScreen3: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = BookingScreen3Model()
    var body: some View {
        DSList {
            DSSection {
                Location(address: viewModel.address)
                    .onTap { dismiss() }
                Barber(barber: viewModel.barber)
                    .onTap { dismiss() }
                Services(services: viewModel.services)
                    .onTap { dismiss() }
                DateAndTime(dateAndTime: "Mar 24, 2021 at 10:40 PM")
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

extension BookingScreen3 {
    struct DateAndTime: View {
        let dateAndTime: String
        var body: some View {
            DSHStack(spacing: .medium) {
                DSImageView(
                    systemName: "calendar",
                    size: .mediumIcon,
                    tint: .text(.headline)
                )

                DSText(dateAndTime)
                    .dsTextStyle(.smallHeadline)
                    .dsFullWidth()
                DSSFSymbolButton(name: "pencil.circle.fill", size: .mediumIcon)
            }
            .dsCardStyle()
            .dsSectionStyle(title: "Date & Time")
        }

        struct Data: Identifiable {
            let id = UUID()
            let name: String
            let grade: String
            let image: URL?
        }
    }

    struct Barber: View {
        let barber: Data
        var body: some View {
            DSHStack(spacing: .medium) {
                DSImageView(url: barber.image, style: .circle)
                    .dsSize(50)
                DSVStack(spacing: .zero) {
                    DSText(barber.name)
                        .dsTextStyle(.smallHeadline)
                    DSText(barber.grade)
                        .dsTextStyle(.smallSubheadline)
                }.dsFullWidth()

                DSSFSymbolButton(name: "pencil.circle.fill", size: .mediumIcon)
            }
            .dsCardStyle()
            .dsSectionStyle(title: "Barber")
        }

        struct Data: Identifiable {
            let id = UUID()
            let name: String
            let grade: String
            let image: URL?
        }
    }

    struct Services: View {
        let services: [Data]
        var body: some View {
            DSVStack(spacing: .small) {
                ForEach(services) { service in
                    DSHStack(spacing: .medium) {
                        DSVStack(spacing: .small) {
                            DSText(service.title)
                                .dsTextStyle(.smallHeadline)
                            DSHStack {
                                DSImageView(
                                    systemName: "clock.fill",
                                    size: .font(.smallSubheadline),
                                    tint: .text(.smallSubheadline)
                                )
                                DSText("Duration:\(service.duration)")
                                    .dsTextStyle(.smallSubheadline)
                            }
                            DSPriceView(price: service.price, size: .smallHeadline)
                        }
                        .dsFullWidth()
                        DSSFSymbolButton(
                            name: "minus.circle.fill",
                            size: .mediumIcon
                        )
                    }
                }
                .dsCardStyle()

                DSHStack {
                    DSText("Manage selected services")
                        .dsTextStyle(.smallHeadline)
                        .dsFullWidth()
                        .onTap { print("Manage services") }
                    DSChevronView()
                }.dsCardStyle()
            }
            .dsSectionStyle(title: "Services")
        }

        struct Data: Identifiable {
            let id = UUID()
            let title: String
            let price: DSPrice
            let duration: String
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
                .dsHeight(90)
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

final class BookingScreen3Model: ObservableObject {
    @Published var barber: BookingScreen3.Barber.Data = .init(
        name: "Ms. Ole Thompson",
        grade: "Pro Barber",
        image: p1Image
    )

    @Published var services: [BookingScreen3.Services.Data] = [
        .init(
            title: "Eybrow Correction",
            price: .init(amount: "50", regularAmount: "80", currency: "$", discountBadge: "30$ OFF"),
            duration: "1h"
        )
    ]

    @Published var address: BookingScreen3.Location.Data = .init(
        name: "Barbershop Broadway",
        address: "325 Broadway, Bayonne, NJ 07002, 7km away",
        coordinated: CLLocationCoordinate2D(latitude: 40.764382, longitude: -73.973045)
    )
}

// MARK: - Testable

struct Testable_BookingScreen3: View {
    var body: some View {
        NavigationView {
            BookingScreen3()
                .navigationTitle("New Booking")
        }
    }
}

// MARK: - Preview

struct BookingScreen3_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_BookingScreen3()
        }
    }
}

private let p1Image = URL(string: "https://images.unsplash.com/photo-1554387415-b0c2fcce17fd?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
