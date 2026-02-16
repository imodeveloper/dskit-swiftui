//
//  DSBlurBackgroundModifier.swift
//  DSKit
//
//  Created by Borinschi Ivan on 21.01.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

// iOS Implementation
public struct BlurredBackgroundView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#elseif canImport(AppKit)
import AppKit

// macOS Implementation
public struct BlurredBackgroundView: NSViewRepresentable {
    var material: NSVisualEffectView.Material

    public func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }

    public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}
#endif

// MARK: - Cross-Platform Modifier

public struct DSBlurBackgroundModifier: ViewModifier {
    #if canImport(UIKit)
    let style: UIBlurEffect.Style
    #elseif canImport(AppKit)
    let material: NSVisualEffectView.Material
    #endif

    public func body(content: Content) -> some View {
        #if canImport(UIKit)
        content
            .background(
                BlurredBackgroundView(style: style)
                    .edgesIgnoringSafeArea(.all)
            )
        #elseif canImport(AppKit)
        content
            .background(
                BlurredBackgroundView(material: material)
                    .edgesIgnoringSafeArea(.all)

            )
        #endif
    }
}

public extension View {
    #if canImport(UIKit)
    func dsBlurBackground(style: UIBlurEffect.Style = .systemThinMaterialDark) -> some View {
        let modifier = DSBlurBackgroundModifier(style: style)
        return self.modifier(modifier)
    }
    #elseif canImport(AppKit)
    func dsBlurBackground(material: NSVisualEffectView.Material = .hudWindow) -> some View {
        let modifier = DSBlurBackgroundModifier(material: material)
        return self.modifier(modifier)
    }
    #endif

    func dsBlurBackgroundLight() -> some View {
        #if canImport(UIKit)
        return self.dsBlurBackground(style: .light)
        #else
        self
        #endif
    }

    func dsBlurSystemThinMaterialLight() -> some View {
        #if canImport(UIKit)
        return self.dsBlurBackground(style: .systemThinMaterialLight)
        #else
        self
        #endif
    }

}

#Preview {
    VStack {
        DSVStack {
            DSText("Default")
            DSText("Grouped")
            DSText("Grouped in section")
        }.dsBlurBackground()
    }.dsPadding()
}
