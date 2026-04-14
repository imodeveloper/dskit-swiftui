//
//  DSFloatingBannerView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 14.04.2026.
//

import SwiftUI

/*
## DSFloatingBannerView

`DSFloatingBannerView` is a reusable top overlay banner for transient actions and status updates.

#### Usage:
- Provide a `DSFloatingBannerContent` value describing the title, accessory style, accessibility, and interaction behavior.
- Mount the banner through `dsFloatingBanner(...)` to overlay it on top of any screen content.
- Keep domain-specific state machines outside DSKit and map them into generic banner content values.
*/

public enum DSFloatingBannerIconPlacement: Hashable, Sendable {
    case leading
    case trailing
}

public enum DSFloatingBannerAccessoryEmphasis: String, Hashable, Sendable {
    case primary
    case secondary
    case success
}

public enum DSFloatingBannerStyle: Hashable, Sendable {
    case label(
        systemImage: String? = nil,
        placement: DSFloatingBannerIconPlacement = .leading,
        emphasis: DSFloatingBannerAccessoryEmphasis = .secondary
    )
    case progress
    case status(systemImage: String, emphasis: DSFloatingBannerAccessoryEmphasis = .success)
}

public struct DSFloatingBannerContent: Hashable, Sendable {
    public let title: String
    public let style: DSFloatingBannerStyle
    public let transitionID: String
    public let accessibilityLabel: String?
    public let accessibilityHint: String?
    public let isInteractive: Bool
    public let titleUsesMonospacedDigits: Bool

    public init(
        title: String,
        style: DSFloatingBannerStyle,
        transitionID: String? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil,
        isInteractive: Bool = true,
        titleUsesMonospacedDigits: Bool = false
    ) {
        self.title = title
        self.style = style
        self.transitionID = transitionID ?? style.defaultTransitionID
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
        self.isInteractive = isInteractive
        self.titleUsesMonospacedDigits = titleUsesMonospacedDigits
    }
}

public struct DSFloatingBannerView: View {
    public let isPresented: Bool
    public let content: DSFloatingBannerContent
    public var topInset: CGFloat = 10
    public var horizontalPadding: CGFloat = 16
    public var onTap: () -> Void = {}

    @Namespace private var glassNamespace

    private var showHideAnimation: Animation {
        .spring(response: 0.46, dampingFraction: 0.82)
    }

    private var contentAnimation: Animation {
        .spring(response: 0.56, dampingFraction: 0.84, blendDuration: 0.18)
    }

    private var liquidContentTransition: AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: LiquidContentTransitionModifier(opacity: 0, scale: 0.92, blur: 9, y: 10),
                identity: LiquidContentTransitionModifier(opacity: 1, scale: 1, blur: 0, y: 0)
            ),
            removal: .modifier(
                active: LiquidContentTransitionModifier(opacity: 0, scale: 1.05, blur: 6, y: -8),
                identity: LiquidContentTransitionModifier(opacity: 1, scale: 1, blur: 0, y: 0)
            )
        )
    }

    public init(
        isPresented: Bool,
        content: DSFloatingBannerContent,
        topInset: CGFloat = 10,
        horizontalPadding: CGFloat = 16,
        onTap: @escaping () -> Void = {}
    ) {
        self.isPresented = isPresented
        self.content = content
        self.topInset = topInset
        self.horizontalPadding = horizontalPadding
        self.onTap = onTap
    }

    public var body: some View {
        VStack(spacing: 0) {
            if isPresented {
                bannerButton
                    .padding(.top, topInset)
                    .padding(.horizontal, horizontalPadding)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .allowsHitTesting(isPresented)
        .animation(showHideAnimation, value: isPresented)
        .animation(contentAnimation, value: content)
    }

    private var bannerButton: some View {
        Button(action: onTap) {
            contentSwitcher
                .contentShape(.capsule)
        }
        .buttonStyle(.plain)
        .allowsHitTesting(content.isInteractive)
        .contentShape(.capsule)
        .shadow(color: .black.opacity(0.12), radius: 10, y: 3)
        .accessibilityLabel(Text(content.accessibilityLabel ?? content.title))
        .accessibilityHint(Text(content.accessibilityHint ?? ""))
    }

    @ViewBuilder
    private var contentSwitcher: some View {
        if #available(iOS 26.0, *) {
            GlassEffectContainer(spacing: 18) {
                contentSwitcherStack
            }
            .glassEffectUnion(id: "DSFloatingBanner.Union", namespace: glassNamespace)
            .glassEffectTransition(.matchedGeometry)
            .animation(contentAnimation, value: content)
        } else {
            contentSwitcherStack
                .animation(contentAnimation, value: content)
        }
    }

    @ViewBuilder
    private var contentSwitcherStack: some View {
        ZStack {
            if case let .label(systemImage, placement, emphasis) = content.style {
                surfaceContent {
                    labelContent(systemImage: systemImage, placement: placement, emphasis: emphasis)
                }
                .modifier(LiquidGlassSurfaceMorphModifier(surfaceID: content.transitionID, namespace: glassNamespace))
                .transition(liquidContentTransition)
            }

            if case .progress = content.style {
                surfaceContent {
                    HStack(spacing: 10) {
                        titleText(minimumScaleFactor: 0.85)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(0.7)
                    }
                }
                .modifier(LiquidGlassSurfaceMorphModifier(surfaceID: content.transitionID, namespace: glassNamespace))
                .transition(liquidContentTransition)
            }

            if case let .status(systemImage, emphasis) = content.style {
                surfaceContent {
                    HStack(spacing: 10) {
                        titleText(minimumScaleFactor: 0.85)
                        Image(systemName: systemImage)
                            .font(.headline)
                            .foregroundStyle(color(for: emphasis))
                    }
                }
                .modifier(LiquidGlassSurfaceMorphModifier(surfaceID: content.transitionID, namespace: glassNamespace))
                .transition(liquidContentTransition)
            }
        }
    }

    @ViewBuilder
    private func labelContent(
        systemImage: String?,
        placement: DSFloatingBannerIconPlacement,
        emphasis: DSFloatingBannerAccessoryEmphasis
    ) -> some View {
        if let systemImage {
            HStack(spacing: 10) {
                if placement == .leading {
                    Image(systemName: systemImage)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(color(for: emphasis))
                }

                titleText(minimumScaleFactor: 0.9)

                if placement == .trailing {
                    Image(systemName: systemImage)
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(color(for: emphasis))
                }
            }
        } else {
            titleText(minimumScaleFactor: 0.9)
        }
    }

    private func titleText(minimumScaleFactor: CGFloat) -> some View {
        Text(content.title)
            .monospacedDigit()
            .contentTransition(content.titleUsesMonospacedDigits ? .numericText() : .identity)
            .font(.subheadline.weight(.semibold))
            .lineLimit(1)
            .minimumScaleFactor(minimumScaleFactor)
            .foregroundStyle(.primary)
    }

    private func surfaceContent<Inner: View>(@ViewBuilder _ inner: () -> Inner) -> some View {
        inner()
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .frame(minHeight: 40)
            .modifier(FloatingBannerMaterial())
            .contentShape(.capsule)
    }

    private func color(for emphasis: DSFloatingBannerAccessoryEmphasis) -> Color {
        switch emphasis {
        case .primary:
            return .primary
        case .secondary:
            return .secondary
        case .success:
            return .green
        }
    }
}

private extension DSFloatingBannerStyle {
    var defaultTransitionID: String {
        switch self {
        case let .label(systemImage, placement, emphasis):
            let resolvedImage = systemImage ?? "plain"
            return "DSFloatingBanner.label.\(resolvedImage).\(placement).\(emphasis.rawValue)"
        case .progress:
            return "DSFloatingBanner.progress"
        case let .status(systemImage, emphasis):
            return "DSFloatingBanner.status.\(systemImage).\(emphasis.rawValue)"
        }
    }
}

private struct LiquidContentTransitionModifier: ViewModifier {
    let opacity: CGFloat
    let scale: CGFloat
    let blur: CGFloat
    let y: CGFloat

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .scaleEffect(scale)
            .blur(radius: blur)
            .offset(y: y)
    }
}

private struct LiquidGlassSurfaceMorphModifier: ViewModifier {
    let surfaceID: String
    let namespace: Namespace.ID

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffectID(surfaceID, in: namespace)
                .glassEffectTransition(.matchedGeometry)
        } else {
            content
        }
    }
}

private struct FloatingBannerMaterial: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect(.regular.interactive(), in: .capsule)
        } else {
            content
                .background(.ultraThinMaterial, in: .capsule)
                .overlay {
                    Capsule()
                        .strokeBorder(.white.opacity(0.35), lineWidth: 0.8)
                }
        }
    }
}

public extension View {
    func dsFloatingBanner(
        isPresented: Bool,
        content: DSFloatingBannerContent,
        topInset: CGFloat = 10,
        horizontalPadding: CGFloat = 16,
        onTap: @escaping () -> Void = {}
    ) -> some View {
        overlay {
            DSFloatingBannerView(
                isPresented: isPresented,
                content: content,
                topInset: topInset,
                horizontalPadding: horizontalPadding,
                onTap: onTap
            )
        }
    }
}

private struct Testable_DSFloatingBannerView: View {
    @State private var selection = 0

    private let banners: [DSFloatingBannerContent] = [
        DSFloatingBannerContent(
            title: "Scroll to top",
            style: .label(systemImage: "arrow.up")
        ),
        DSFloatingBannerContent(
            title: "12 new articles",
            style: .label(systemImage: "arrow.trianglehead.2.clockwise.rotate.90", placement: .trailing),
            titleUsesMonospacedDigits: true
        ),
        DSFloatingBannerContent(
            title: "Syncing...",
            style: .progress,
            isInteractive: false
        ),
        DSFloatingBannerContent(
            title: "Updated",
            style: .status(systemImage: "checkmark.circle.fill"),
            isInteractive: false
        )
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.white, Color(.systemGray6)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                DSButton(title: "Next", style: .light, maxWidth: false) {
                    selection = (selection + 1) % banners.count
                }
                .padding(.top, 120)

                Spacer()
            }
        }
        .dsFloatingBanner(
            isPresented: true,
            content: banners[selection]
        )
    }
}

struct DSFloatingBannerView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSFloatingBannerView()
            }
        }
    }
}
