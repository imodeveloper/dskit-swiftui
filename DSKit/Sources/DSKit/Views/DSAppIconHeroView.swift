//
//  DSAppIconHeroView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import SwiftUI

/*
## DSAppIconHeroView

`DSAppIconHeroView` displays app icon artwork as a prominent onboarding or loading hero with consistent sizing, corner radius, shadow, and accessibility labeling.

#### Initialization:
Initializes the hero with icon content and presentation metrics.
- Parameters:
- `size`: Fixed width and height for the icon.
- `cornerRadius`: Continuous rounded-rectangle corner radius.
- `shadowRadius`: Drop-shadow radius.
- `accessibilityLabel`: Accessibility label for the icon artwork.
- `icon`: Resizable icon content provided by the app.

#### Usage:
Use `DSAppIconHeroView` in onboarding, first-run, permission, or loading surfaces where the app brand should be the primary visual signal. Apps provide their own icon asset or SwiftUI icon content.
*/

public struct DSAppIconHeroView<Icon: View>: View {
    private let size: CGFloat
    private let cornerRadius: CGFloat
    private let shadowRadius: CGFloat
    private let accessibilityLabel: String
    private let icon: Icon

    public init(
        size: CGFloat = 105.6,
        cornerRadius: CGFloat = 24,
        shadowRadius: CGFloat = 14.4,
        accessibilityLabel: String,
        @ViewBuilder icon: () -> Icon
    ) {
        self.size = size
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.accessibilityLabel = accessibilityLabel
        self.icon = icon()
    }

    public var body: some View {
        icon
            .frame(width: size, height: size)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.18), radius: shadowRadius, y: 8)
            .accessibilityLabel(accessibilityLabel)
    }
}

struct Testable_DSAppIconHeroView: View {
    var body: some View {
        DSAppIconHeroView(accessibilityLabel: "Demo") {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    DSImageView(
                        systemName: "square.stack.3d.up.fill",
                        size: .font(.largeTitle),
                        tint: .color(.white)
                    )
                }
        }
    }
}

struct DSAppIconHeroView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSAppIconHeroView()
            }
        }
    }
}
