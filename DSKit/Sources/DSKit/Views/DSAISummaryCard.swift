//
//  DSAISummaryCard.swift
//  DSKit
//
//  Created by Ivan Borinschi on 29.07.2026.
//

import SwiftUI

/*
## DSAISummaryCard

`DSAISummaryCard` presents an AI-generated article summary with a clear content hierarchy,
an AI disclosure, and a compact overlapping group of contributing source badges.

#### Usage:
- Pass display-ready title, summary, disclosure, and source names.
- Keep navigation and source-opening actions in the consuming screen.
- Use the card wherever an article-level AI summary needs a consistent presentation.
*/

public struct DSAISummarySource: Hashable, Identifiable, Sendable {
    public let name: String
    public let articleTitle: String

    public var id: String {
        "\(name)-\(articleTitle)"
    }

    public init(name: String, articleTitle: String) {
        self.name = name
        self.articleTitle = articleTitle
    }
}

public struct DSAISummaryCard: View {
    @State private var areSourcesExpanded: Bool

    private let title: String
    private let summary: String
    private let disclosure: String
    private let sources: [DSAISummarySource]
    private let maximumVisibleSources: Int

    public init(
        title: String,
        summary: String,
        disclosure: String,
        sources: [DSAISummarySource],
        maximumVisibleSources: Int = 5,
        initiallyExpanded: Bool = false
    ) {
        _areSourcesExpanded = State(initialValue: initiallyExpanded)
        self.title = title
        self.summary = summary
        self.disclosure = disclosure
        self.sources = sources
        self.maximumVisibleSources = max(1, maximumVisibleSources)
    }

    public var body: some View {
        DSVStack(alignment: .leading, spacing: .space12) {
            DSVStack(alignment: .leading, spacing: .space12) {
                DSText(title)
                    .dsTextStyle(.body, .text(.primary))
                    .fixedSize(horizontal: false, vertical: true)

                DSText(summary)
                    .dsTextStyle(.caption1, .text(.primary))
                    .fixedSize(horizontal: false, vertical: true)
            }

            disclosureView
        }
        .dsCardStyle()
        .accessibilityElement(children: .contain)
    }

    @ViewBuilder
    private var disclosureView: some View {
        if sources.isEmpty {
            disclosureContent
                .dsCardStyle(padding: .space8, background: .primary)
        } else {
            Button(action: toggleSources) {
                disclosureContent
                    .dsCardStyle(padding: .space8, background: .primary)
            }
            .buttonStyle(.plain)
            .contentShape(.rect)
            .dsFullWidth()
            .accessibilityLabel(areSourcesExpanded ? "Collapse sources" : "Expand sources")
            .accessibilityValue("\(sources.count) sources")
        }
    }

    private var disclosureContent: some View {
        DSVStack(alignment: .leading, spacing: .custom(6)) {
            DSHStack(alignment: .center, spacing: .custom(6)) {
                DSAISummarySparkleIcon()
                .accessibilityHidden(true)

                DSText(disclosure)
                    .dsTextStyle(.caption1, .text(.secondary))
                    .fixedSize(horizontal: false, vertical: true)
                    .dsFullWidth()
            }

            if sources.isEmpty == false {
                sourcesPresentation
            }
        }
    }

    @ViewBuilder
    private var sourcesPresentation: some View {
        if areSourcesExpanded {
            expandedSources
                .clipped()
                .transition(.opacity)
        } else {
            sourceBadges
                .transition(.opacity)
        }
    }

    private var sourceBadges: some View {
        DSHStack(spacing: .custom(-2)) {
            ForEach(visibleSources) { source in
                DSLetterBadgeView(
                    text: sourceInitial(for: source.name),
                    backgroundColor: DSLetterBadgeView.generatedColor(for: source.name),
                    textStyle: .label
                )
                .accessibilityLabel(source.name)
            }

            if hiddenSourceCount > 0 {
                DSAISummaryOverflowBadge(hiddenSourceCount: hiddenSourceCount)
                .accessibilityLabel("\(hiddenSourceCount) additional sources")
            }
        }
        .accessibilityElement(children: .combine)
    }

    private var expandedSources: some View {
        DSVStack(alignment: .leading, spacing: .space16) {
            ForEach(sources) { source in
                DSVStack(alignment: .leading, spacing: .space8) {
                    DSAuthorView(
                        name: source.name,
                        badgeColor: DSLetterBadgeView.generatedColor(for: source.name),
                        textStyle: .label,
                        textColor: .text(.primary)
                    )

                    DSText(source.articleTitle)
                        .dsTextStyle(.bodySmall, .text(.secondary))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .dsFullWidth()
                }
                .dsFullWidth()
                .accessibilityElement(children: .combine)
            }
        }
        .dsFullWidth()
    }

    private var visibleSources: [DSAISummarySource] {
        Array(sources.prefix(maximumVisibleSources))
    }

    private var hiddenSourceCount: Int {
        max(0, sources.count - maximumVisibleSources)
    }

    private func sourceInitial(for name: String) -> String {
        String(name.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1)).uppercased()
    }

    private func toggleSources() {
        withAnimation(.easeInOut(duration: 0.25)) {
            areSourcesExpanded.toggle()
        }
    }
}

private struct DSAISummarySparkleIcon: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let shimmerInterval: TimeInterval = 3
    private let shimmerDuration: TimeInterval = 0.7
    private let unitTestMode = ProcessInfo.processInfo.arguments.contains("TESTMODE")

    var body: some View {
        TimelineView(
            .animation(
                minimumInterval: 1.0 / 30.0,
                paused: reduceMotion || unitTestMode
            )
        ) { timeline in
            let progress = shimmerProgress(at: timeline.date)
            let intensity = sin(progress * .pi)

            ZStack {
                sparkle(tint: .icon(.warning))

                sparkle(tint: .color(.white))
                    .opacity(intensity * 0.75)
            }
            .scaleEffect(1 + (intensity * 0.08))
        }
    }

    private func sparkle(tint: DSColorToken) -> some View {
        DSImageView(
            systemName: "sparkles",
            size: .font(.body),
            tint: tint
        )
    }

    private func shimmerProgress(at date: Date) -> Double {
        guard reduceMotion == false, unitTestMode == false else { return 0 }
        let elapsed = date.timeIntervalSinceReferenceDate
            .truncatingRemainder(dividingBy: shimmerInterval)
        return min(max(elapsed / shimmerDuration, 0), 1)
    }
}

private struct DSAISummaryOverflowBadge: View {
    @Environment(\.appearance) private var appearance
    @Environment(\.surfaceStyle) private var surfaceStyle

    let hiddenSourceCount: Int

    var body: some View {
        DSLetterBadgeView(
            text: "+\(hiddenSourceCount)",
            backgroundColor: appearance.color(
                for: .background(.brand),
                surfaceStyle: surfaceStyle
            ),
            textStyle: .label
        )
    }
}

struct Testable_DSAISummaryCard: View {
    var body: some View {
        DSAISummaryCard(
            title: DSAISummaryCardFixtures.title,
            summary: DSAISummaryCardFixtures.summary,
            disclosure: "Rezumat generat cu ajutorul inteligenței artificiale, pe baza articolelor din surse multiple.",
            sources: [
                DSAISummarySource(name: "Moldova 1", articleTitle: DSAISummaryCardFixtures.sourceArticleTitle),
                DSAISummarySource(name: "ProTV", articleTitle: DSAISummaryCardFixtures.sourceArticleTitle),
                DSAISummarySource(name: "NewsMaker", articleTitle: DSAISummaryCardFixtures.sourceArticleTitle),
                DSAISummarySource(name: "TV8", articleTitle: DSAISummaryCardFixtures.sourceArticleTitle)
            ]
        )
    }
}

struct Testable_DSAISummaryCardWithoutSources: View {
    var body: some View {
        DSAISummaryCard(
            title: DSAISummaryCardFixtures.title,
            summary: DSAISummaryCardFixtures.summary,
            disclosure: "Rezumat generat cu ajutorul inteligenței artificiale, pe baza articolelor din surse multiple.",
            sources: []
        )
    }
}

struct Testable_DSAISummaryCardExpanded: View {
    var body: some View {
        DSAISummaryCard(
            title: DSAISummaryCardFixtures.title,
            summary: DSAISummaryCardFixtures.summary,
            disclosure: "Rezumat generat cu ajutorul inteligenței artificiale, pe baza articolelor din surse multiple.",
            sources: DSAISummaryCardFixtures.expandedSources,
            initiallyExpanded: true
        )
    }
}

struct Testable_DSAISummaryCardWithManySources: View {
    var body: some View {
        DSAISummaryCard(
            title: DSAISummaryCardFixtures.title,
            summary: DSAISummaryCardFixtures.summary,
            disclosure: "Rezumat generat cu ajutorul inteligenței artificiale, pe baza articolelor din 23 de surse.",
            sources: DSAISummaryCardFixtures.manySources,
            maximumVisibleSources: 7
        )
    }
}

private enum DSAISummaryCardFixtures {
    static let title = "Leul avansează decisiv, iar ziua aduce alegeri importante"
    static let sourceArticleTitle = "Săgetătorii aleg dintre mari oportunități, iar Leii avansează decisiv: Află ce-ți rezervă ziua de astăzi"
    static let summary = """
    Contextul zilei pune accent pe decizii amânate, limite mai clare și detalii care nu mai pot fi trecute cu vederea. Schimbările mici pot avea cel mai mare efect atunci când sunt făcute la momentul potrivit.
    """
    static let expandedSources = [
        "Moldova 1", "ProTV", "NewsMaker", "TV8", "Ziarul de Gardă"
    ].map {
        DSAISummarySource(name: $0, articleTitle: sourceArticleTitle)
    }
    static let manySources = [
        "Moldova 1", "ProTV", "NewsMaker", "TV8", "Ziarul de Gardă",
        "Agora", "IPN", "Moldpres", "Jurnal TV", "Realitatea",
        "Radio Moldova", "Europa Liberă", "Diez", "Unimedia", "Anticorupție",
        "Newsmaker RU", "Nokta", "NordNews", "Esp.md", "Gagauzinfo",
        "Studio-L", "Observatorul de Nord", "BAStv"
    ].map {
        DSAISummarySource(name: $0, articleTitle: sourceArticleTitle)
    }
}

struct DSAISummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                ScrollView {
                    DSVStack(spacing: .space16) {
                        Testable_DSAISummaryCard()
                        Testable_DSAISummaryCardWithoutSources()
                        Testable_DSAISummaryCardExpanded()
                        Testable_DSAISummaryCardWithManySources()
                    }
                    .dsPadding()
                }
            }
        }
    }
}
