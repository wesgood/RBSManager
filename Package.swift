// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "RBSManager",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "RBSManager",
            targets: ["RBSManager"])
    ],
    dependencies: [
        .package(url: "https://github.com/daltoniam/Starscream.git", from: "3.1.1"),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", from: "4.2.0"),
        .package(url: "https://github.com/adamayoung/swiftlint-plugin.git", from: "0.51.0")
    ],
    targets: [
        .target(
            name: "RBSManager",
            dependencies: ["Starscream", "ObjectMapper"],
            path: ".", sources: ["RBSManager"],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "swiftlint-plugin")
            ])
    ]
)
