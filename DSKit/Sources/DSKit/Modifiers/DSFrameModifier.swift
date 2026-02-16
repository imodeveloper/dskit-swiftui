//
//  DSFrameModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 19.12.2022.
//

import Foundation
import SwiftUI

public extension View {
    func dsFullWidth(alignment: Alignment = .leading) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
}

struct DSFullWidthModifier_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                DSText("Welcome to DSKit")
                    .dsFullWidth()
                    .border(Color.black, width: 1)
                DSText("Welcome to DSKit")
                    .dsFullWidth(alignment: .center)
                    .border(Color.black, width: 1)
                DSText("Welcome to DSKit")
                    .dsFullWidth(alignment: .trailing)
                    .border(Color.black, width: 1)
            }
        }
    }
}
