//
//  DSCardStyleModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 14.12.2022.
//

import SwiftUI

public struct DSScreenModifier: ViewModifier {
    @Environment(\.appearance) var appearance: DSAppearance
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .dsBackground(.primary)
            .dsContentMargins()
    }
}

public extension View {
    func dsScreen() -> some View {
        return self
            .modifier(DSScreenModifier())
    }
}
