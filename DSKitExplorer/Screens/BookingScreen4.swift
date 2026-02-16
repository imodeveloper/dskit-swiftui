//
//  BookingScreen4.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import SwiftUI
import DSKit
import MapKit

struct BookingScreen4: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = BookingScreen4Model()
    var body: some View {
        DSList {
            DSSection {
            
                ForEach(viewModel.barbers) { barber in
                    Barber(barber: barber)
                        .dsCardStyle()
                        .onTap { dismiss() }
                }
        
            }}
    }
}

extension BookingScreen4 {
    
    struct Barber: View {
        let barber: Data
        var body: some View {
            DSVStack {
                DSHStack(spacing: .medium) {
                    DSImageView(url: barber.image, style: .circle)
                        .dsSize(60)
                    DSVStack(spacing: .zero) {
                        DSText(barber.name)
                            .dsTextStyle(.headline)
                        DSText(barber.grade)
                            .dsTextStyle(.subheadline)
                    }.dsFullWidth()
                    
                    DSSFSymbolButton(name: "info.circle", size: .smallIcon)
                }
                
                DSText("Nearest time for appointment")
                    .dsTextStyle(.caption2)
                
                DSGrid(columns: 4, data: barber.hours, id: \.self) { hour in
                    DSText(hour)
                        .dsTextStyle(.smallHeadline)
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

final class BookingScreen4Model: ObservableObject {
    
    @Published public var barbers: [BookingScreen4.Barber.Data] = [
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
                .navigationTitle("Select specialist")
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

fileprivate let p1Image = URL(string: "https://images.unsplash.com/photo-1554387415-b0c2fcce17fd?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")

fileprivate let p2Image = URL(string: "https://images.unsplash.com/photo-1567894340315-735d7c361db0?q=80&w=2537&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")

fileprivate let p3Image = URL(string: "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")

fileprivate let p4Image = URL(string: "https://images.unsplash.com/photo-1614289371518-722f2615943d?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")

fileprivate let p5Image = URL(string: "https://images.unsplash.com/photo-1578875315363-076171ddef21?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")

fileprivate let p6Image = URL(string: "https://images.unsplash.com/photo-1480455624313-e29b44bbfde1?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")



