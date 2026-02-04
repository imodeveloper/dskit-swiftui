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
        let width = fixedDimension(for: size.width)
        let height = fixedDimension(for: size.height)
        let maxWidth = size.width == .fillUpTheSpace ? CGFloat.infinity : nil
        let maxHeight = size.height == .fillUpTheSpace ? CGFloat.infinity : nil
        
        return content
            .frame(width: width, height: height)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }
    
    private func fixedDimension(for dimension: DSDimension) -> CGFloat? {
        switch dimension {
        case .fillUpTheSpace:
            return nil
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
