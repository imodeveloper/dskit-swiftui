//
//  DSLoadingIndicator.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import SwiftUI

/*
## DSLoadingIndicator

`DSLoadingIndicator` renders compact animated loading affordances inspired by dot, dash, matrix, equalizer, and pulse states. It is suitable for inline progress chips, empty-state loading rows, and compact activity surfaces where a full `ProgressView` would feel too generic.

#### Initialization:
Initializes `DSLoadingIndicator` with a style, fixed capsule size, dot metrics, semantic tint, optional container color, and animation state.
- Parameters:
- `style`: One of the built-in `DSLoadingIndicatorStyle` cases.
- `width`: The indicator container width.
- `height`: The indicator container height.
- `dotSize`: The base size used by dots, dashes, and bars.
- `dotSpacing`: Spacing between repeated marks.
- `tint`: Semantic color token used for dots, dashes, and bars.
- `containerColor`: Optional semantic color token for the capsule background. Pass `nil` for an unframed indicator.
- `containerOpacity`: Opacity applied after resolving `containerColor` from the active DSKit appearance.
- `isAnimated`: Enables the live looping animation.

#### Usage:
Use `DSLoadingIndicator` when a screen needs a compact loading treatment that still follows DSKit colors and sizing. Previews can animate normally, while snapshot examples can disable animation for deterministic documentation.
*/

public enum DSLoadingIndicatorStyle: String, CaseIterable, Hashable, Sendable {
    case pulsingDots
    case bouncingDots
    case fadingDots
    case slidingDots
    case matrixDots
    case glowingDots
    case dashDots
    case equalizer
    case singlePulse

    var displayTitle: String {
        switch self {
        case .pulsingDots:
            "Pulsing"
        case .bouncingDots:
            "Bouncing"
        case .fadingDots:
            "Fading"
        case .slidingDots:
            "Sliding"
        case .matrixDots:
            "Matrix"
        case .glowingDots:
            "Glow"
        case .dashDots:
            "Dashes"
        case .equalizer:
            "Equalizer"
        case .singlePulse:
            "Pulse"
        }
    }

    var snapshotPhase: Double {
        switch self {
        case .pulsingDots:
            0.10
        case .bouncingDots:
            0.22
        case .fadingDots:
            0.40
        case .slidingDots:
            0.35
        case .matrixDots:
            0.50
        case .glowingDots:
            0.32
        case .dashDots:
            0.45
        case .equalizer:
            0.38
        case .singlePulse:
            0.42
        }
    }
}

public struct DSLoadingIndicator: View {
    @Environment(\.appearance) private var appearance: DSAppearance
    @Environment(\.surfaceStyle) private var surfaceStyle: DSSurfaceStyle

    private let style: DSLoadingIndicatorStyle
    private let width: CGFloat
    private let height: CGFloat
    private let dotSize: CGFloat
    private let dotSpacing: CGFloat
    private let tint: DSColorToken
    private let containerColor: DSColorToken?
    private let containerOpacity: Double
    private let isAnimated: Bool
    private let staticPhase: Double

    public init(
        style: DSLoadingIndicatorStyle = .pulsingDots,
        width: CGFloat = 78,
        height: CGFloat = 40,
        dotSize: CGFloat = 5,
        dotSpacing: CGFloat = 6,
        tint: DSColorToken = .icon(.brand),
        containerColor: DSColorToken? = .background(.surfaceRaised),
        containerOpacity: Double = 1,
        isAnimated: Bool = true
    ) {
        self.init(
            style: style,
            width: width,
            height: height,
            dotSize: dotSize,
            dotSpacing: dotSpacing,
            tint: tint,
            containerColor: containerColor,
            containerOpacity: containerOpacity,
            isAnimated: isAnimated,
            staticPhase: 0
        )
    }

    init(
        style: DSLoadingIndicatorStyle = .pulsingDots,
        width: CGFloat = 78,
        height: CGFloat = 40,
        dotSize: CGFloat = 5,
        dotSpacing: CGFloat = 6,
        tint: DSColorToken = .icon(.brand),
        containerColor: DSColorToken? = .background(.surfaceRaised),
        containerOpacity: Double = 1,
        isAnimated: Bool = true,
        staticPhase: Double
    ) {
        self.style = style
        self.width = width
        self.height = height
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
        self.tint = tint
        self.containerColor = containerColor
        self.containerOpacity = containerOpacity
        self.isAnimated = isAnimated
        self.staticPhase = staticPhase
    }

    public var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0, paused: !isAnimated)) { context in
            indicator(progress: progress(for: context.date), tint: resolvedTint)
                .frame(width: width, height: height)
                .background {
                    if let containerColor {
                        Capsule()
                            .fill(containerColor.color(for: appearance, in: surfaceStyle))
                            .opacity(containerOpacity)
                    }
                }
        }
        .accessibilityLabel(Text("Loading"))
    }

    private var resolvedTint: Color {
        tint.color(for: appearance, in: surfaceStyle)
    }

    private func progress(for date: Date) -> Double {
        guard isAnimated else {
            return normalized(staticPhase)
        }

        let cycleDuration = 1.2
        let rawProgress = date.timeIntervalSinceReferenceDate
            .truncatingRemainder(dividingBy: cycleDuration) / cycleDuration
        return normalized(rawProgress)
    }

    @ViewBuilder
    private func indicator(progress: Double, tint: Color) -> some View {
        switch style {
        case .pulsingDots:
            pulsingDots(progress: progress, tint: tint)
        case .bouncingDots:
            bouncingDots(progress: progress, tint: tint)
        case .fadingDots:
            fadingDots(progress: progress, tint: tint)
        case .slidingDots:
            slidingDots(progress: progress, tint: tint)
        case .matrixDots:
            matrixDots(progress: progress, tint: tint)
        case .glowingDots:
            glowingDots(progress: progress, tint: tint)
        case .dashDots:
            dashDots(progress: progress, tint: tint)
        case .equalizer:
            equalizer(progress: progress, tint: tint)
        case .singlePulse:
            singlePulse(progress: progress, tint: tint)
        }
    }

    private func pulsingDots(progress: Double, tint: Color) -> some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<3, id: \.self) { index in
                let phase = wave(progress: progress, index: index, count: 3)
                Circle()
                    .fill(tint)
                    .frame(width: dotSize, height: dotSize)
                    .scaleEffect(0.72 + (phase * 0.55))
                    .opacity(0.38 + (phase * 0.62))
            }
        }
    }

    private func bouncingDots(progress: Double, tint: Color) -> some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<3, id: \.self) { index in
                let phase = wave(progress: progress, index: index, count: 3)
                Circle()
                    .fill(tint)
                    .frame(width: dotSize, height: dotSize)
                    .scaleEffect(0.82 + (phase * 0.26))
                    .offset(y: -phase * dotSize * 0.95)
                    .opacity(0.55 + (phase * 0.45))
            }
        }
    }

    private func fadingDots(progress: Double, tint: Color) -> some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<3, id: \.self) { index in
                let phase = wave(progress: progress, index: index, count: 3)
                ZStack {
                    Circle()
                        .strokeBorder(tint.opacity(0.34), lineWidth: max(1, dotSize * 0.18))

                    Circle()
                        .fill(tint.opacity(phase))
                        .scaleEffect(0.55 + (phase * 0.45))
                }
                .frame(width: dotSize, height: dotSize)
                .opacity(0.42 + (phase * 0.58))
            }
        }
    }

    private func slidingDots(progress: Double, tint: Color) -> some View {
        ZStack {
            ForEach(0..<3, id: \.self) { index in
                let phase = shifted(progress: progress, index: index, count: 3)
                Circle()
                    .fill(tint)
                    .frame(width: dotSize, height: dotSize)
                    .offset(x: (phase - 0.5) * dotSize * 7.2)
                    .scaleEffect(0.62 + (travelVisibility(phase) * 0.38))
                    .opacity(0.22 + (travelVisibility(phase) * 0.78))
            }
        }
        .frame(width: dotSize * 9, height: dotSize * 3)
    }

    private func matrixDots(progress: Double, tint: Color) -> some View {
        VStack(spacing: dotSize * 0.78) {
            ForEach(0..<2, id: \.self) { row in
                HStack(spacing: dotSpacing * 0.82) {
                    ForEach(0..<3, id: \.self) { column in
                        let index = (row * 3) + column
                        let phase = wave(progress: progress, index: index, count: 6)
                        Circle()
                            .fill(tint)
                            .frame(width: dotSize * 0.62, height: dotSize * 0.62)
                            .scaleEffect(0.65 + (phase * 0.6))
                            .opacity(0.25 + (phase * 0.75))
                    }
                }
            }
        }
    }

    private func glowingDots(progress: Double, tint: Color) -> some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<3, id: \.self) { index in
                let phase = wave(progress: progress, index: index, count: 3)
                Circle()
                    .fill(tint)
                    .frame(width: dotSize, height: dotSize)
                    .scaleEffect(0.76 + (phase * 0.36))
                    .blur(radius: phase * 0.8)
                    .shadow(color: tint.opacity(phase * 0.9), radius: phase * 5)
                    .opacity(0.42 + (phase * 0.58))
            }
        }
    }

    private func dashDots(progress: Double, tint: Color) -> some View {
        HStack(spacing: dotSpacing * 0.72) {
            ForEach(0..<3, id: \.self) { index in
                let phase = wave(progress: progress, index: index, count: 3)
                Capsule()
                    .fill(tint)
                    .frame(
                        width: dotSize * (0.65 + (phase * 2.15)),
                        height: max(2, dotSize * 0.66)
                    )
                    .opacity(0.32 + (phase * 0.68))
            }
        }
    }

    private func equalizer(progress: Double, tint: Color) -> some View {
        HStack(alignment: .center, spacing: dotSpacing * 0.58) {
            ForEach(0..<3, id: \.self) { index in
                let phase = wave(progress: progress, index: index, count: 3)
                Capsule()
                    .fill(tint)
                    .frame(
                        width: max(2, dotSize * 0.78),
                        height: dotSize * (1.2 + (phase * 3.1))
                    )
                    .opacity(0.52 + (phase * 0.48))
            }
        }
        .frame(height: dotSize * 4.8)
    }

    private func singlePulse(progress: Double, tint: Color) -> some View {
        let phase = wave(progress: progress, index: 0, count: 1)

        return Circle()
            .fill(tint)
            .frame(width: dotSize, height: dotSize)
            .scaleEffect(0.72 + (phase * 0.48))
            .opacity(0.44 + (phase * 0.56))
    }

    private func wave(progress: Double, index: Int, count: Int) -> Double {
        let shiftedProgress = shifted(progress: progress, index: index, count: count)
        return (sin((shiftedProgress * 2 * .pi) - (.pi / 2)) + 1) / 2
    }

    private func shifted(progress: Double, index: Int, count: Int) -> Double {
        normalized(progress - (Double(index) / Double(max(count, 1))) * 0.72)
    }

    private func travelVisibility(_ progress: Double) -> Double {
        max(0, sin(progress * .pi))
    }

    private func normalized(_ value: Double) -> Double {
        let remainder = value.truncatingRemainder(dividingBy: 1)
        return remainder >= 0 ? remainder : remainder + 1
    }
}

struct Testable_DSLoadingIndicator: View {
    @Environment(\.appearance) private var appearance: DSAppearance
    @Environment(\.surfaceStyle) private var surfaceStyle: DSSurfaceStyle

    private let isAnimated: Bool
    private let columns = Array(repeating: GridItem(.fixed(84), spacing: 14), count: 3)

    init(isAnimated: Bool = false) {
        self.isAnimated = isAnimated
    }

    var body: some View {
        VStack(spacing: 18) {
            DSText("Loading...")
                .dsTextStyle(.headline, .text(.brandOnBold))

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(DSLoadingIndicatorStyle.allCases, id: \.self) { style in
                    VStack(spacing: 6) {
                        DSLoadingIndicator(
                            style: style,
                            tint: .icon(.brandOnBold),
                            containerColor: .background(.surfaceRaised),
                            containerOpacity: 0.22,
                            isAnimated: isAnimated,
                            staticPhase: style.snapshotPhase
                        )
                        .accessibilityLabel(Text(style.displayTitle))

                        DSText(style.displayTitle, alignment: .center)
                            .dsTextStyle(.caption1, .text(.brandOnBold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
            }
        }
        .padding(.horizontal, 34)
        .padding(.vertical, 32)
        .background {
            DSColorToken.background(.brand)
                .color(for: appearance, in: surfaceStyle)
        }
        .clipShape(.rect(cornerRadius: 18))
    }
}

struct DSLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSLoadingIndicator(isAnimated: true)
            }
        }
    }
}
