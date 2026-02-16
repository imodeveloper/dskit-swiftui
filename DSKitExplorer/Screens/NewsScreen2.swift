//
//  NewsScreen2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct NewsScreen2: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = NewsScreen2Model()

    var body: some View {
        DSList {
            DSSection {
                ForEach(viewModel.articles) { article in
                    ArticleView(article: article)
                }
            }
        }
    }
}

extension NewsScreen2 {
    // MARK: - Article View

    struct ArticleView: View {
        let article: Data

        var body: some View {
            DSHStack(alignment: .top, spacing: .medium) {
                DSVStack(spacing: .regular) {
                    DSText(article.title)
                        .dsTextStyle(.smallHeadline)
                        .dsFullWidth()

                    DSText(article.description, alignment: .leading)
                        .dsTextStyle(.smallSubheadline)
                        .dsFullWidth()

                    DSHStack {
                        DSImageView(systemName: "clock", size: .font(.footnote), tint: .text(.footnote))
                        DSText(article.formattedDate, alignment: .leading)
                            .dsTextStyle(.footnote)
                            .dsFullWidth()
                    }
                }

                if let image = article.image {
                    DSImageView(url: image)
                        .frame(width: 50, height: 50)
                        .dsCornerRadius()
                }
            }
            .overlay(alignment: .bottomTrailing) {
                DSHStack {
                    DSImageView(
                        systemName: "bookmark.fill",
                        size: .font(.footnote),
                        tint: .color(.orange)
                    )
                    DSImageView(
                        systemName: "checkmark.circle.fill",
                        size: .font(.footnote),
                        tint: .color(.green)
                    )
                }
            }
            .dsPadding()
            .frame(maxWidth: .infinity)
            .dsSecondaryBackground()
            .dsCornerRadius()
        }

        struct Data: Identifiable {
            let id = UUID()
            let title: String
            let description: String
            let date: Date
            let image: URL?

            var formattedDate: String {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                return formatter.string(from: date)
            }
        }
    }
}

// MARK: - Model

final class NewsScreen2Model {
    let articles: [NewsScreen2.ArticleView.Data] = [
        .init(
            title: "The Future of 5G Networks: What to Expect",
            description: "A look at the future of 5G networks, their potential impact on IT, and the innovations they will bring to various industries.",
            date: Date(timeIntervalSince1970: 1_704_067_200),
            image: image3
        ),
        .init(
            title: "Best Practices for DevOps in Modern IT",
            description: "Discover the best practices for implementing DevOps in modern IT environments to enhance collaboration, efficiency, and software delivery.",
            date: Date(timeIntervalSince1970: 1_705_555_200),
            image: image4
        ),
        .init(
            title: "Understanding the Latest Cybersecurity Threats",
            description: "An in-depth analysis of the most pressing cybersecurity threats today, and strategies for protecting your IT environment.",
            date: Date(timeIntervalSince1970: 1_717_200_000),
            image: image5
        ),
        .init(
            title: "Blockchain Technology: Revolutionizing IT Systems",
            description: "Exploring how blockchain technology is revolutionizing IT systems with enhanced security, transparency, and efficiency.",
            date: Date(timeIntervalSince1970: 1_711_228_800),
            image: nil
        ),
        .init(
            title: "The AI Revolution: Transforming the IT Landscape",
            description: "A deep dive into how artificial intelligence is reshaping the information technology industry, with key insights and future predictions.",
            date: Date(timeIntervalSince1970: 1_711_929_600),
            image: image1
        ),
        .init(
            title: "Top Cloud Computing Trends in 2024",
            description: "An overview of the most significant trends in cloud computing this year, and how they are influencing IT infrastructure and business strategies.",
            date: Date(timeIntervalSince1970: 1_709_251_200),
            image: image2
        ),
        .init(
            title: "Advancements in Machine Learning and Their Impact",
            description: "A comprehensive review of the latest advancements in machine learning and their profound impact on various sectors of IT.",
            date: Date(timeIntervalSince1970: 1_706_745_600),
            image: nil
        )
    ]
}

// MARK: - Testable

struct Testable_NewsScreen2: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedTab: Int = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Home")
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Home")
                }.tag(0)
            NavigationView {
                NewsScreen2()
                    .navigationTitle("Bookmarks")
            }
            .tabItem {
                Image(systemName: "bookmark")
                Text("Bookmarks")
            }.tag(1)
            DSVStack {
                DSButton(title: "Dismiss", style: .clear) {
                    dismiss()
                }.dsPadding()
            }
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }.tag(2)
        }
    }
}

// MARK: - Preview

struct NewsScreen2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_NewsScreen2()
        }
    }
}

// MARK: - Image Links

private let image1 = URL(string: "https://images.unsplash.com/photo-1677442136019-21780ecad995?q=80&w=3132&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let image2 = URL(string: "https://images.unsplash.com/photo-1569428034239-f9565e32e224?q=80&w=3279&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let image3 = URL(string: "https://images.unsplash.com/photo-1681356382603-dc9d7b9ee0c8?q=80&w=3271&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let image4 = URL(string: "https://images.unsplash.com/photo-1558346490-a72e53ae2d4f?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
private let image5 = URL(string: "https://images.unsplash.com/photo-1589149098258-3e9102cd63d3?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8UXVhbnR1bSUyMENvbXB1dGluZ3xlbnwwfHwwfHx8MA%3D%3D")
