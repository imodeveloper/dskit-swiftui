// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "DSKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v12)
    ],
    products: [
        .library(name: "DSKit", targets: ["DSKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Nuke.git", from: "12.0.0")
    ],
    targets: [
        .target(
            name: "DSKit",
            dependencies: [
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke")
            ],
            path: "DSKit/Sources"
        )
    ]
)
