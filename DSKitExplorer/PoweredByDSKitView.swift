//
//  PoweredByDSKitView.swift
//  DSKitExplorer
//
//  Created by Ivan Borinschi on 29.02.2023.
//

import SwiftUI
import DSKit

struct PoweredByDSKitView: View {
    var body: some View {
        DSVStack(spacing: .space4) {
            DSHStack(spacing: .space4) {
                DSText("Powered by").dsTextStyle(.caption1)
                DSImageView(systemName: "square.stack.3d.down.right.fill", size: .smallIcon, tint: .icon(.brand))
                DSText("DSKit").dsTextStyle(.caption1)
            }.frame(maxWidth: .infinity, alignment: .center)
            DSHStack(spacing: .space4) {
                DSText("Made with").dsTextStyle(.caption1)
                DSImageView(systemName: "heart.fill", size: .smallIcon, tint: .color(.red))
                DSText("by imodeveloper").dsTextStyle(.caption1)
            }.frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
