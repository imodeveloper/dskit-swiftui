//
//  DSSizeModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 19.12.2022.
//

import Foundation
import SwiftUI

public struct DSSizeModifier: ViewModifier {
    
    let size: DSSize
    @Environment(\.appearance) var appearance: DSAppearance
    
    public func body(content: Content) -> some View {
        Group {
            if size.width == .fillUpTheSpace || size.height == .fillUpTheSpace {
                GeometryReader { geometry in
                    self.modifiedContent(content: content, geometry: geometry)
                }
            } else {
                self.modifiedContent(content: content, geometry: nil)
            }
        }
    }
    
    private func modifiedContent(content: Content, geometry: GeometryProxy?) -> some View {
        let width = resolveDimension(dimension: size.width, totalSize: geometry?.size.width)
        let height = resolveDimension(dimension: size.height, totalSize: geometry?.size.height)

        return content.frame(width: width, height: height)
    }
    
    private func resolveDimension(dimension: DSDimension, totalSize: CGFloat?) -> CGFloat? {
        switch dimension {
        case .fillUpTheSpace:
            return totalSize
        case .none:
            return nil
        default:
            return dimension.value(appearance: appearance)
        }
    }
}

// Placeholder for your existing DSDimension, DSDesignable, and other relevant types


public extension View {
    func dsSize(_ size: DSSize) -> some View {
        self.modifier(DSSizeModifier(size: size))
    }
    
    func dsSize(dimension: DSDimension) -> some View {
        self.modifier(DSSizeModifier(size: DSSize(width: dimension, height: dimension)))
    }
}

struct DSSizeModifier_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Color.red
                    .dsSize(10)
                Color.blue
                    .dsSize(20)
                Color.green
                    .dsSize(30)
                Color.yellow
                    .dsSize(.size(width: 100, height: 30))
                Color.cyan
                    .dsSize(.size(width: 30, height: 100))
            }.dsLayoutDebug()
        }
    }
}
