//
//  DSTextParticleLoadingView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import Foundation
import SwiftUI

/*
## DSTextParticleLoadingView

`DSTextParticleLoadingView` renders a bounded field of text particles moving along deterministic curved paths. It is designed for branded loading states that need more personality than a spinner while still respecting Reduce Motion and scene phase.

#### Initialization:
Initializes the loading field with display text values and animation controls.
- Parameters:
- `texts`: Text labels sampled by the animation.
- `isActive`: Enables animation when Reduce Motion is off and the scene is active.
- `staticDate`: Optional deterministic date used for snapshots or static previews.

#### Usage:
Use `DSTextParticleLoadingView` for first-run loading, content bootstrap, or data import screens where the animated labels are display-only. Keep haptics, sync state, and source-specific data in the host app.
*/

public struct DSTextParticleLoadingView: View {
    private let texts: [String]
    private let isActive: Bool
    private let staticDate: Date?

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.scenePhase) private var scenePhase

    public init(
        texts: [String],
        isActive: Bool,
        staticDate: Date? = nil
    ) {
        self.texts = texts.isEmpty ? ["Loading"] : texts
        self.isActive = isActive
        self.staticDate = staticDate
    }

    public var body: some View {
        GeometryReader { geometry in
            if let staticDate {
                animatedContent(date: staticDate, size: geometry.size)
            } else if reduceMotion || isActive == false || scenePhase == .background {
                staticFallback
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                TimelineView(.animation) { timeline in
                    animatedContent(date: timeline.date, size: geometry.size)
                }
            }
        }
        .accessibilityHidden(true)
    }

    private var staticFallback: some View {
        DSText(texts.first ?? "Loading", alignment: .center)
            .dsTextStyle(.largeTitle)
            .opacity(0.9)
            .padding(.horizontal, 24)
    }

    private func animatedContent(date: Date, size: CGSize) -> some View {
        ZStack {
            ForEach(0 ..< DSTextParticleLoadingModel.activeParticleCount, id: \.self) { index in
                particleView(
                    index: index,
                    date: date,
                    size: size
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .mask(
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0),
                    .init(color: .black.opacity(0.92), location: 0.22),
                    .init(color: .black, location: 0.5),
                    .init(color: .black.opacity(0.92), location: 0.78),
                    .init(color: .clear, location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    private func particleView(index: Int, date: Date, size: CGSize) -> some View {
        let sample = DSTextParticleLoadingModel.sample(
            slot: index,
            date: date,
            viewport: size,
            texts: texts
        )
        let centerStrength = sin(sample.progress * .pi)
        let opacity = 0.15 + centerStrength * 0.85
        let blur = (1 - centerStrength) * 18
        let scale = 0.82 + centerStrength * 0.22
        let glow = centerStrength

        return DSText(sample.particle.text)
            .dsTextStyle(sample.particle.textStyle)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .opacity(opacity)
            .blur(radius: blur)
            .scaleEffect(scale)
            .brightness(centerStrength * 0.18)
            .shadow(color: .accentColor.opacity(0.18 * glow), radius: 24 * glow)
            .position(sample.position)
    }
}

public struct DSTextParticle: Equatable, Identifiable {
    public let id: UUID
    public let text: String
    public let start: CGPoint
    public let apogee: CGPoint
    public let end: CGPoint
    public let duration: TimeInterval
    public let delay: TimeInterval
    public let textStyle: DSTypographyToken
}

public struct DSTextParticleSample: Equatable {
    public let particle: DSTextParticle
    public let progress: CGFloat
    public let position: CGPoint
}

public enum DSTextParticleLoadingModel {
    public static let activeParticleCount = 7
    private static let textStyleCount = 4

    public static func particle(
        slot: Int,
        cycle: Int,
        viewport: CGSize,
        texts: [String]
    ) -> DSTextParticle {
        let labels = texts.isEmpty ? ["Loading"] : texts
        let seed = UInt64(max(1, slot + 1) * 10_003 + max(1, cycle + 1) * 97_409)
        let textIndex = Int(random(seed: seed, salt: 1) * Double(labels.count)) % max(1, labels.count)
        let width = max(1, viewport.width)
        let height = max(1, viewport.height)
        let start = CGPoint(
            x: randomRange(seed: seed, salt: 2, min: -40, max: width + 40),
            y: randomRange(seed: seed, salt: 3, min: -120, max: -40)
        )
        let apogee = CGPoint(
            x: width * 0.5 + randomRange(seed: seed, salt: 4, min: -60, max: 60),
            y: height * 0.48 + randomRange(seed: seed, salt: 5, min: -80, max: 80)
        )
        let end = CGPoint(
            x: randomRange(seed: seed, salt: 6, min: -40, max: width + 40),
            y: height + randomRange(seed: seed, salt: 7, min: 40, max: 140)
        )
        let duration = randomRange(seed: seed, salt: 8, min: TimeInterval(4.0), max: TimeInterval(6.5))
        let delay = randomRange(seed: seed, salt: 9, min: TimeInterval(0.45), max: TimeInterval(0.9)) * Double(slot)
        let textStyleIndex = Int(random(seed: seed, salt: 10) * Double(textStyleCount)) % textStyleCount

        return DSTextParticle(
            id: UUID(uuidString: "00000000-0000-0000-0000-\(seedSuffix(seed))") ?? UUID(),
            text: labels[textIndex],
            start: start,
            apogee: apogee,
            end: end,
            duration: duration,
            delay: delay,
            textStyle: textStyle(at: textStyleIndex)
        )
    }

    public static func sample(
        slot: Int,
        date: Date,
        viewport: CGSize,
        texts: [String]
    ) -> DSTextParticleSample {
        let baseDuration: TimeInterval = 5.4
        let phase = max(0, date.timeIntervalSinceReferenceDate - Double(slot) * 0.72)
        let cycle = Int(floor(phase / baseDuration))
        let particle = particle(slot: slot, cycle: cycle, viewport: viewport, texts: texts)
        let local = (phase - Double(cycle) * baseDuration).truncatingRemainder(dividingBy: particle.duration)
        let rawProgress = CGFloat(local / particle.duration)
        let progress = smoothSpringEaseInOut(rawProgress)
        return DSTextParticleSample(
            particle: particle,
            progress: progress,
            position: point(on: particle, progress: progress)
        )
    }

    public static func point(on particle: DSTextParticle, progress: CGFloat) -> CGPoint {
        let t = min(max(progress, 0), 1)
        let inverse = 1 - t
        return CGPoint(
            x: inverse * inverse * particle.start.x + 2 * inverse * t * particle.apogee.x + t * t * particle.end.x,
            y: inverse * inverse * particle.start.y + 2 * inverse * t * particle.apogee.y + t * t * particle.end.y
        )
    }

    public static func smoothSpringEaseInOut(_ value: CGFloat) -> CGFloat {
        let clamped = min(max(value, 0), 1)
        let smooth = clamped * clamped * (3 - 2 * clamped)
        let spring = sin(clamped * .pi) * 0.035 * sin(clamped * .pi * 4)
        return min(max(smooth + spring, 0), 1)
    }

    private static func textStyle(at index: Int) -> DSTypographyToken {
        switch index {
        case 0:
            .largeTitle
        case 1:
            .title1
        case 2:
            .title2
        default:
            .title3
        }
    }

    private static func randomRange(seed: UInt64, salt: UInt64, min: CGFloat, max: CGFloat) -> CGFloat {
        min + CGFloat(random(seed: seed, salt: salt)) * (max - min)
    }

    private static func randomRange(seed: UInt64, salt: UInt64, min: TimeInterval, max: TimeInterval) -> TimeInterval {
        min + random(seed: seed, salt: salt) * (max - min)
    }

    private static func random(seed: UInt64, salt: UInt64) -> Double {
        var value = seed &+ salt &* 0x9E37_79B9_7F4A_7C15
        value = (value ^ (value >> 30)) &* 0xBF58_476D_1CE4_E5B9
        value = (value ^ (value >> 27)) &* 0x94D0_49BB_1331_11EB
        value = value ^ (value >> 31)
        return Double(value % 10_000) / 10_000
    }

    private static func seedSuffix(_ seed: UInt64) -> String {
        let suffix = String(seed & 0xFFFFFFFFFFFF, radix: 16)
        let padding = max(0, 12 - suffix.count)
        return String(repeating: "0", count: padding) + suffix
    }
}

struct Testable_DSTextParticleLoadingView: View {
    var body: some View {
        DSTextParticleLoadingView(
            texts: ["Adevărul", "Radio Chișinău", "NewsMaker", "Moldova 1", "Agora"],
            isActive: true,
            staticDate: Date(timeIntervalSinceReferenceDate: 6_600)
        )
        .frame(height: 240)
        .background(Color.accentColor.opacity(0.08))
        .clipShape(.rect(cornerRadius: 18))
    }
}

struct DSTextParticleLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSTextParticleLoadingView()
            }
        }
    }
}
