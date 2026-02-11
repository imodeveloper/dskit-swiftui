// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "DSKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "DSKit", targets: ["DSKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "3.0.4"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.19.2")
    ],
    targets: [
        .target(
            name: "DSKit",
            dependencies: [
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                .product(name: "SDWebImage", package: "SDWebImage")
            ],
            path: "DSKit/Sources"
        )
    ]
)
