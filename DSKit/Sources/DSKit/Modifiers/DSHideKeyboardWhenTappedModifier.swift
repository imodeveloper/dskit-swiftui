//
//  DSHideKeyboardWhenTappedModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 28.12.2022.
//

import SwiftUI

public struct DSHideKeyboardWhenTappedModifier: ViewModifier {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.surfaceStyle) var surfaceStyle: DSSurfaceStyle

    public func body(content: Content) -> some View {
        ZStack {
            // Invisible touch layer
            appearance.color(for: .background(surfaceStyle.backgroundToken), surfaceStyle: surfaceStyle)
                .onTapGesture {
                    self.dismissKeyboard()
                }
                .zIndex(-1) // Ensure it doesn't interfere with other UI elements
            content
        }
    }

    private func dismissKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}

public extension View {
    func hideKeyboardWhenTappedOutside() -> some View {
        self.modifier(DSHideKeyboardWhenTappedModifier())
    }
}
