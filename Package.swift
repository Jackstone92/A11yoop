// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Main
var package = Package(
    name: "A11yoop",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "A11yoopMonitor",
            targets: ["A11yoopMonitor"]),
    ],
    dependencies: [
        .package(name: "combine-schedulers", url: "https://github.com/pointfreeco/combine-schedulers", .upToNextMajor(from: "0.5.3")),
    ],
    targets: [
        .target(
            name: "A11yoopMonitor",
            dependencies: [.product(name: "CombineSchedulers", package: "combine-schedulers")]),
        .testTarget(
            name: "A11yoopMonitorTests",
            dependencies: ["A11yoopMonitor"]),
        .testTarget(
            name: "A11yoopMonitorIntegrationTests",
            dependencies: ["A11yoopMonitor"])
    ]
)
