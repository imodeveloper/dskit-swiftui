//
//  Order3.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Order3: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSVStack(alignment: .center) {
            Spacer()
            DSButton(title: "Continue Shopping", rightSystemName: "bag.fill", action: { dismiss() })

                .dsPadding(.bottom)
        }
        .overlay(alignment: .center, content: {
            DSStatusView(
                systemName: "checkmark.circle.fill",
                title: "It's Ordered",
                message: "Hi John - thanks for your order,\nwe hope you enjoyed shopping\nwith us",
                iconTint: .color(.green),
                titleStyle: .custom(size: 30, weight: .semibold, relativeTo: .headline)
            )
        })
        .dsScreen()
    }
}

// MARK: - Testable

struct Testable_Order3: View {
    var body: some View {
        Order3()
    }
}

// MARK: - Preview

struct Order3_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Order3() }
    }
}
