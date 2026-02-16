//
//  BookingScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import SwiftUI
import DSKit
import MapKit

struct BookingScreen1: View {
    let viewModel = BookingScreen1Model()
    var body: some View {
        DSList {
            DSSection {
            
                ForEach(viewModel.addresses, id: \.self.id) { address in
                    Location(address: address)
                }
        
            }}
    }
}

extension BookingScreen1 {
    
    struct Location: View {
        let address: Data
        var body: some View {
            DSVStack(spacing: .zero) {
                DSVStack(spacing: .small) {
                    DSText(address.name)
                        .dsTextStyle(.smallHeadline)
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
                .dsHeight(150)
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
                self._region = State(initialValue: MKCoordinateRegion(
                    center: coordinated,
                    span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001)
                ))
            }
        }
    }
}

// MARK: - Model

final class BookingScreen1Model: ObservableObject {
    
    @Published public var addresses: [BookingScreen1.Location.Data] = [
        .init(
            name: "Barbershop Broadway",
            address: "325 Broadway, Bayonne, NJ 07002, 7km away",
            coordinated: CLLocationCoordinate2D(latitude: 40.764382, longitude: -73.973045)
        ),
        .init(
            name: "Barbershop Avenue B",
            address: "295 Avenue B, Bayonne, NJ 07002, 3km away",
            coordinated: CLLocationCoordinate2D(latitude: 40.6634361, longitude: -74.115727)
        ),
        .init(
            name: "Barbershop New York",
            address: "833 Broadway, New York, NY 10003, 1km away",
            coordinated: CLLocationCoordinate2D(latitude: 40.7337279, longitude: -73.9915569)
        ),
        .init(
            name: "Rockefeller Plaza",
            address: "45 Rockefeller Plaza, New York, NY 10111, 12km away",
            coordinated: CLLocationCoordinate2D(latitude: 40.7597203, longitude: -73.97837)
        ),
        .init(
            name: "Barbershop Broadway Bayonne",
            address: "923 Broadway Bayonne, NJ 07002, 23km away",
            coordinated: CLLocationCoordinate2D(latitude: 40.6788119, longitude: -74.1063384)
        )
    ]
}

// MARK: - Testable

struct Testable_BookingScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        TabView {
            NavigationView {
                BookingScreen1()
                    .navigationTitle("Booking")
            }
            .tabItem {
                Image(systemName: "book.closed.fill")
                Text("Booking")
            }
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
            Text("About")
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("About")
                }
            DSVStack {
                DSButton(title: "Dismiss", style: .clear) {
                    dismiss()
                }
            }.tabItem {
                Image(systemName: "bookmark.fill")
                Text("Bookmark")
            }
        }
    }
}

// MARK: - Preview

struct BookingScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_BookingScreen1()
        }
    }
}
