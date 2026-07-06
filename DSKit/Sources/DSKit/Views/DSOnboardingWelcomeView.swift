//
//  DSOnboardingWelcomeView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import SwiftUI

/*
## DSOnboardingWelcomeView

`DSOnboardingWelcomeView` provides an Apple-style first-run onboarding layout with a hero, concise headline, supporting subtitle, feature rows, one-line terms acceptance, and a bottom primary action.

#### Initialization:
Initializes the welcome layout with display copy, feature rows, legal link copy, actions, and hero content.
- Parameters:
- `headline`: Main welcome headline.
- `subtitle`: Supporting product description.
- `features`: Feature rows shown below the hero copy.
- `acceptanceNote`: Text before the terms link.
- `termsLinkTitle`: Link-styled legal text.
- `termsLinkAccessibilityHint`: Accessibility hint for the legal link.
- `ctaTitle`: Primary action title.
- `onTermsTap`: Legal link action.
- `onContinue`: Primary action.
- `hero`: App icon, illustration, or brand view.

#### Usage:
Use `DSOnboardingWelcomeView` when an app needs a compact first-run explanation. Keep copy and navigation in the app, and pass a DSKit-compatible hero such as `DSAppIconHeroView`.
*/

public struct DSOnboardingWelcomeFeature: Identifiable, Hashable, Sendable {
    public let id: String
    public let systemImage: String
    public let title: String
    public let subtitle: String

    public init(
        id: String? = nil,
        systemImage: String,
        title: String,
        subtitle: String
    ) {
        self.id = id ?? "\(systemImage)-\(title)"
        self.systemImage = systemImage
        self.title = title
        self.subtitle = subtitle
    }
}

public struct DSOnboardingWelcomeView<Hero: View>: View {
    private let headline: String
    private let subtitle: String
    private let features: [DSOnboardingWelcomeFeature]
    private let acceptanceNote: String
    private let termsLinkTitle: String
    private let termsLinkAccessibilityHint: String?
    private let ctaTitle: String
    private let onTermsTap: () -> Void
    private let onContinue: () -> Void
    private let hero: Hero

    public init(
        headline: String,
        subtitle: String,
        features: [DSOnboardingWelcomeFeature],
        acceptanceNote: String,
        termsLinkTitle: String,
        termsLinkAccessibilityHint: String? = nil,
        ctaTitle: String,
        onTermsTap: @escaping () -> Void,
        onContinue: @escaping () -> Void,
        @ViewBuilder hero: () -> Hero
    ) {
        self.headline = headline
        self.subtitle = subtitle
        self.features = features
        self.acceptanceNote = acceptanceNote
        self.termsLinkTitle = termsLinkTitle
        self.termsLinkAccessibilityHint = termsLinkAccessibilityHint
        self.ctaTitle = ctaTitle
        self.onTermsTap = onTermsTap
        self.onContinue = onContinue
        self.hero = hero()
    }

    public var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 80)

            VStack(spacing: 0) {
                hero
                    .padding(.bottom, 40)

                DSText(headline)
                    .dsTextStyle(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.84)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)

                DSText(subtitle, lineSpacing: 3)
                    .dsTextStyle(.bodyLarge, .text(.subheadline))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 4)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            VStack(alignment: .leading, spacing: 20) {
                ForEach(features) { feature in
                    DSOnboardingWelcomeFeatureRow(feature: feature)
                }
            }
            .padding(.top, 44)

            Spacer()

            VStack(spacing: 16) {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    DSText(acceptanceNote)
                        .dsTextStyle(.footnote)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.88)

                    Button(action: onTermsTap) {
                        Text(termsLinkTitle)
                            .font(.footnote)
                            .underline(true, color: .accentColor)
                            .foregroundStyle(.tint)
                            .lineLimit(1)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.88)
                    }
                    .accessibilityHint(termsLinkAccessibilityHint ?? "")
                    .accessibilityAddTraits(.isLink)
                }
                .frame(maxWidth: .infinity)
                .accessibilityElement(children: .combine)

                DSButton(
                    title: ctaTitle,
                    style: .default,
                    titleFont: .headline,
                    action: onContinue
                )
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 32)
        .dsScreen()
    }
}

private struct DSOnboardingWelcomeFeatureRow: View {
    let feature: DSOnboardingWelcomeFeature

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            DSImageView(
                systemName: feature.systemImage,
                size: .font(.title1),
                tint: .icon(.brand)
            )
            .frame(width: 34, height: 34)

            VStack(alignment: .leading, spacing: 3) {
                DSText(feature.title)
                    .dsTextStyle(.headline)
                DSText(feature.subtitle)
                    .dsTextStyle(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct Testable_DSOnboardingWelcomeView: View {
    var body: some View {
        DSOnboardingWelcomeView(
            headline: "Welcome to Monitor",
            subtitle: "All local stories in one clear place.",
            features: [
                DSOnboardingWelcomeFeature(
                    systemImage: "rectangle.stack.fill",
                    title: "Clear topics",
                    subtitle: "Related articles are grouped automatically."
                ),
                DSOnboardingWelcomeFeature(
                    systemImage: "person.2.fill",
                    title: "People and sources",
                    subtitle: "See who is mentioned and who published each story."
                ),
                DSOnboardingWelcomeFeature(
                    systemImage: "magnifyingglass.circle.fill",
                    title: "Fast search",
                    subtitle: "Find articles, sources, people, and categories."
                )
            ],
            acceptanceNote: "By continuing, you accept",
            termsLinkTitle: "Terms and Conditions",
            ctaTitle: "Continue",
            onTermsTap: {},
            onContinue: {},
            hero: {
                Testable_DSAppIconHeroView()
            }
        )
    }
}

struct DSOnboardingWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_DSOnboardingWelcomeView()
        }
    }
}
