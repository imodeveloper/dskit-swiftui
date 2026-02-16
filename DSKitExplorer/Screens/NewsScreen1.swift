//
//  NewsScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import SwiftUI
import DSKit

struct NewsScreen1: View {
    
    enum Style {
        case regular
        case compact
    }
    
    @Environment(\.dismiss) var dismiss
    let viewModel = NewsScreen1Model()
    @State var style: Style = .regular
    
    var body: some View {
        DSList {
            DSSection {
            
                ForEach(viewModel.articles) { article in
                    ArticleView(article: article, style: $style)
                }
        
            }}
        .toolbar {
            ToolbarItem(placement: .platformBasedTrailing) {
                let icon = self.style == .compact ? "list.dash" : "list.bullet.below.rectangle"
                DSToolbarSFSymbolButton(name: icon)
                    .onTap {
                        if self.style == .compact {
                            self.style = .regular
                        } else {
                            self.style = .compact
                        }
                    }
            }
        }
    }
}

extension NewsScreen1 {
    
    // MARK: - Article View
    
    struct ArticleView: View {
        let article: Data
        
        @Binding var style: Style
        
        var body: some View {
            DSVStack(alignment: .center, spacing: .zero) {
                
                if style == .regular {
                    if let image = article.image {
                        DSImageView(url: image)
                            .dsHeight(180)
                    }
                    
                    DSVStack(spacing: .regular) {
                        DSText(article.title)
                            .dsTextStyle(.headline)
                            .dsFullWidth()
                        
                        DSHStack(alignment: .bottom) {
                            DSText(article.description, alignment: .leading)
                                .dsTextStyle(.subheadline)
                                .dsFullWidth()
                            if article.bookmarked {
                                DSImageView(
                                    systemName: "bookmark.fill",
                                    size: .font(.subheadline), tint: .color(.orange)
                                )
                            }
                        }
                    }.dsPadding()
                } else {
                    DSHStack(alignment: .top, spacing: .medium) {
                        
                        if let image = article.image {
                            DSImageView(url: image)
                                .frame(width: 75, height: 75)
                                .dsCornerRadius()
                        }
                        
                        DSVStack(spacing: .regular) {
                            DSText(article.title)
                                .dsTextStyle(.smallHeadline)
                                .dsFullWidth()
                            
                            DSText(article.description, alignment: .leading)
                                .dsTextStyle(.smallSubheadline)
                                .dsFullWidth()
                        }
                        
                        if article.bookmarked {
                            DSImageView(
                                systemName: "bookmark.fill",
                                size: .font(.smallSubheadline),
                                tint: .color(.orange)
                            )
                        }
                        
                    }.dsPadding()
                }
            }
            .frame(maxWidth: .infinity)
            .dsSecondaryBackground()
            .dsCornerRadius()
        }
        
        struct Data: Identifiable {
            let id = UUID()
            let title: String
            let description: String
            let bookmarked: Bool
            let image: URL?
        }
    }
}

// MARK: - Model

final class NewsScreen1Model {
    let articles: [NewsScreen1.ArticleView.Data] = [
        .init(
            title: "The Future of 5G Networks: What to Expect",
            description: "A look at the future of 5G networks, their potential impact on IT, and the innovations they will bring to various industries.",
            bookmarked: false,
            image: image3
        ),
        .init(
            title: "Best Practices for DevOps in Modern IT",
            description: "Discover the best practices for implementing DevOps in modern IT environments to enhance collaboration, efficiency, and software delivery.",
            bookmarked: true,
            image: image4
        ),
        .init(
            title: "Understanding the Latest Cybersecurity Threats",
            description: "An in-depth analysis of the most pressing cybersecurity threats today, and strategies for protecting your IT environment.",
            bookmarked: true,
            image: nil
        ),
        .init(
            title: "Blockchain Technology: Revolutionizing IT Systems",
            description: "Exploring how blockchain technology is revolutionizing IT systems with enhanced security, transparency, and efficiency.",
            bookmarked: false,
            image: nil
        ),
        .init(
            title: "The AI Revolution: Transforming the IT Landscape",
            description: "A deep dive into how artificial intelligence is reshaping the information technology industry, with key insights and future predictions.",
            bookmarked: false,
            image: image1
        ),
        .init(
            title: "Top Cloud Computing Trends in 2024",
            description: "An overview of the most significant trends in cloud computing this year, and how they are influencing IT infrastructure and business strategies.",
            bookmarked: false,
            image: image2
        ),
        .init(
            title: "Advancements in Machine Learning and Their Impact",
            description: "A comprehensive review of the latest advancements in machine learning and their profound impact on various sectors of IT.",
            bookmarked: false,
            image: nil
        ),
        .init(
            title: "The Role of Big Data Analytics in IT",
            description: "An exploration of the critical role that big data analytics plays in the IT industry, including trends and case studies.",
            bookmarked: false,
            image: nil
        ),
        .init(
            title: "Innovations in the Internet of Things (IoT)",
            description: "Examining the latest innovations in IoT technology and their implications for IT infrastructure and smart solutions.",
            bookmarked: true,
            image: nil
        ),
        .init(
            title: "Quantum Computing: The Next Frontier in IT",
            description: "An introduction to quantum computing, its potential to revolutionize IT, and the challenges that lie ahead.",
            bookmarked: false,
            image: image5
        )
    ]
}

// MARK: - Testable

struct Testable_NewsScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        TabView {
            NavigationView {
                NewsScreen1()
                    .navigationTitle("News")
            }
            .tabItem {
                Image(systemName: "newspaper.fill")
                Text("Home")
            }
            Text("Bookmarks")
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Bookmarks")
                }
            DSVStack {
                DSButton(title: "Dismiss", style: .clear) {
                    dismiss()
                }.dsPadding()
            }.tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
    }
}

// MARK: - Preview

struct NewsScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_NewsScreen1()
        }
    }
}

// MARK: - Image Links

fileprivate let image1 = URL(string: "https://images.unsplash.com/photo-1677442136019-21780ecad995?q=80&w=3132&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
fileprivate let image2 = URL(string: "https://images.unsplash.com/photo-1569428034239-f9565e32e224?q=80&w=3279&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
fileprivate let image3 = URL(string: "https://images.unsplash.com/photo-1681356382603-dc9d7b9ee0c8?q=80&w=3271&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
fileprivate let image4 = URL(string: "https://images.unsplash.com/photo-1558346490-a72e53ae2d4f?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
fileprivate let image5 = URL(string: "https://images.unsplash.com/photo-1589149098258-3e9102cd63d3?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8UXVhbnR1bSUyMENvbXB1dGluZ3xlbnwwfHwwfHx8MA%3D%3D")
