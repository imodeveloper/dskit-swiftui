//
//  DSListRowSeparatorModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 03.04.2026.
//

import SwiftUI

public enum DSListRowSeparatorPlacement: Sendable {
    case before
    case after
}

private struct DSListRowSeparatorModifier<Separator: View>: ViewModifier {
    @Environment(\.appearance) private var appearance

    let placement: DSListRowSeparatorPlacement
    let spacing: DSSpatialToken
    let separator: () -> Separator

    @ViewBuilder
    func body(content: Content) -> some View {
        let spacingValue = appearance.spacing.value(for: spacing)

        switch placement {
        case .before:
            DSVStack(spacing: .space0) {
                separator()
                    .padding(.bottom, spacingValue)
                content
            }
            .listRowSeparator(.hidden, edges: [.top, .bottom])
        case .after:
            DSVStack(spacing: .space0) {
                content
                separator()
                    .padding(.top, spacingValue)
            }
            .listRowSeparator(.hidden, edges: [.top, .bottom])
        }
    }
}

public extension View {
    /// Uses the platform list-row separator for standard line separators.
    func dsNativeListRowSeparator(
        _ visibility: Visibility = .visible,
        edges: VerticalEdge.Set = .bottom
    ) -> some View {
        listRowSeparator(visibility, edges: edges)
    }

    /// Adds a DSKit divider before or after a list row while keeping the row itself as the primary content.
    func dsListRowSeparator(
        _ placement: DSListRowSeparatorPlacement = .after,
        spacing: DSSpatialToken = .space8
    ) -> some View {
        modifier(
            DSListRowSeparatorModifier(
                placement: placement,
                spacing: spacing,
                separator: { DSDivider() }
            )
        )
    }

    /// Adds a custom separator view before or after a list row.
    ///
    /// Use this for app-specific list separators such as section breaks or titled time-group labels
    /// without wrapping the row and separator together in ad-hoc container views.
    func dsListRowSeparator<Separator: View>(
        _ placement: DSListRowSeparatorPlacement = .after,
        spacing: DSSpatialToken = .space8,
        @ViewBuilder separator: @escaping () -> Separator
    ) -> some View {
        modifier(
            DSListRowSeparatorModifier(
                placement: placement,
                spacing: spacing,
                separator: separator
            )
        )
    }
}

#if DEBUG
    private struct DSListRowSeparatorModifierPreview: View {
        var body: some View {
            DSList {
                DSSection {
                    DSText("Row with default separator")
                        .dsListRowSeparator(.after)

                    DSText("Row with custom separator")
                        .dsListRowSeparator(.after, spacing: .space4) {
                            DSDivider(style: .dots())
                        }
                }
            }
        }
    }

    struct DSListRowSeparatorModifier_Previews: PreviewProvider {
        static var previews: some View {
            DSPreviewForEachAppearance {
                DSPreview {
                    DSListRowSeparatorModifierPreview()
                }
            }
        }
    }
#endif
