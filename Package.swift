// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HStackView",
    products: [
        .library(
            name: "HStackView",
            targets: ["HStackView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HStackView",
            dependencies: []),
        .testTarget(
            name: "HStackViewTests",
            dependencies: ["HStackView"]),
    ]
)
