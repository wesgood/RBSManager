// swift-tools-version:5
import PackageDescription

let package = Package(
    name: "RBSManager",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "RBSManager",
            targets: ["RBSManager"]),
    ],
    dependencies: [
        .package(url: "https://github.com/daltoniam/Starscream.git", from: "3.1.1"),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", from: "4.2"),
    ],
    targets: [
        .target(
            name: "RBSManager",
            path: "RBSManager/Classes"
            dependencies: []),
    ]
)