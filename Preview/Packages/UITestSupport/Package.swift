// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "UITestSupport",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UITestSupport",
            targets: ["UITestSupport"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "UITestSupport",
            dependencies: []),
        .testTarget(
            name: "UITestSupportTests",
            dependencies: ["UITestSupport"]),
    ]
)
