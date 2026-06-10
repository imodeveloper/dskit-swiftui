//
//  DSRelativeTimeTag.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public enum DSRelativeTimeTagDisplayMode: Hashable, Sendable {
    case relative
    case absolute
}

public enum DSRelativeTimeTagRoundingMode: Hashable, Sendable {
    case none
    case downToHour
    case upToHour
}

public enum DSRelativeTimeTagIconStyle: Hashable, Sendable {
    case plain
    case badge
}

public enum DSRelativeTimeTagIconSize: Hashable {
    case textStyle
    case badge(diameter: CGFloat, iconFont: DSTypographyToken)
}

public struct DSRelativeTimeTag: View {
    private let date: Date
    private let displayMode: DSRelativeTimeTagDisplayMode
    private let roundingMode: DSRelativeTimeTagRoundingMode
    private let iconStyle: DSRelativeTimeTagIconStyle
    private let iconSize: DSRelativeTimeTagIconSize
    private let textStyle: DSTypographyToken
    private let iconTint: DSColorToken
    private let dateStyle: DateFormatter.Style
    private let timeStyle: DateFormatter.Style
    private let locale: Locale
    private let showsTrailingSpacer: Bool
    private let referenceDate: Date?
    private let relativeTextProvider: ((Date, Date) -> String)?

    public init(
        date: Date,
        displayMode: DSRelativeTimeTagDisplayMode = .relative,
        roundingMode: DSRelativeTimeTagRoundingMode = .none,
        iconStyle: DSRelativeTimeTagIconStyle = .plain,
        iconSize: DSRelativeTimeTagIconSize = .textStyle,
        textStyle: DSTypographyToken = .caption1,
        iconTint: DSColorToken = .text(.caption2),
        dateStyle: DateFormatter.Style = .short,
        timeStyle: DateFormatter.Style = .short,
        locale: Locale = .current,
        showsTrailingSpacer: Bool = false,
        referenceDate: Date? = nil,
        relativeTextProvider: ((Date, Date) -> String)? = nil
    ) {
        self.date = date
        self.displayMode = displayMode
        self.roundingMode = roundingMode
        self.iconStyle = iconStyle
        self.iconSize = iconSize
        self.textStyle = textStyle
        self.iconTint = iconTint
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
        self.locale = locale
        self.showsTrailingSpacer = showsTrailingSpacer
        self.referenceDate = referenceDate
        self.relativeTextProvider = relativeTextProvider
    }

    public var body: some View {
        DSHStack(spacing: .space0) {
            if iconStyle == .plain {
                DSInlineTagView(spacing: .space4) {
                    DSImageView(systemName: "clock", size: plainIconSize, tint: iconTint)
                } content: {
                    textContent
                }
            } else {
                DSHStack(spacing: .space4) {
                    clockIconView
                    textContent
                }
            }

            if showsTrailingSpacer {
                Spacer()
            }
        }
    }

    @ViewBuilder
    private var textContent: some View {
        if let referenceDate {
            DSText(formattedText(referenceDate: referenceDate))
                .dsTextStyle(textStyle)
        } else {
            TimelineView(.periodic(from: .now, by: 60)) { context in
                DSText(formattedText(referenceDate: context.date))
                    .dsTextStyle(textStyle)
            }
        }
    }

    private func formattedText(referenceDate: Date) -> String {
        let displayDate = rounded(date: date)
        switch displayMode {
        case .relative:
            return relativeTextProvider?(displayDate, referenceDate) ?? relativeLabel(
                for: displayDate,
                referenceDate: referenceDate
            )
        case .absolute:
            return absoluteLabel(for: displayDate)
        }
    }

    private func relativeLabel(for date: Date, referenceDate: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = locale
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: referenceDate)
    }

    private func absoluteLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: date)
    }

    private func rounded(date: Date) -> Date {
        switch roundingMode {
        case .none:
            return date
        case .downToHour:
            let calendar = Calendar.autoupdatingCurrent
            return calendar.dateInterval(of: .hour, for: date)?.start ?? date
        case .upToHour:
            let calendar = Calendar.autoupdatingCurrent
            guard
                let hourInterval = calendar.dateInterval(of: .hour, for: date),
                date != hourInterval.start
            else {
                return date
            }
            return hourInterval.end
        }
    }

    @ViewBuilder
    private var clockIconView: some View {
        switch iconStyle {
        case .plain:
            DSImageView(systemName: "clock", size: plainIconSize, tint: iconTint)
        case .badge:
            ZStack {
                Circle()
                    .foregroundStyle(Color.secondary)

                DSImageView(
                    systemName: "clock",
                    size: badgeIconSize,
                    tint: .color(.white)
                )
            }
            .frame(width: badgeDiameter, height: badgeDiameter)
        }
    }

    private var plainIconSize: DSSize {
        switch iconSize {
        case .textStyle:
            .font(textStyle)
        case let .badge(_, iconFont):
            .font(iconFont)
        }
    }

    private var badgeIconSize: DSSize {
        switch iconSize {
        case .textStyle:
            .font(.caption1)
        case let .badge(_, iconFont):
            .font(iconFont)
        }
    }

    private var badgeDiameter: CGFloat {
        switch iconSize {
        case .textStyle:
            19
        case let .badge(diameter, _):
            diameter
        }
    }
}
