// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Main
var package = Package(
    name: "A11yoop",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "A11yoop",
            targets: ["A11yoop"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "A11yoop",
            dependencies: ["A11yFeature"]),
        .target(
            name: "A11yoopLive",
            dependencies: ["A11yoop", "A11yStatusManagerLive", "A11yStatusEmitterLive", "A11yFeatureLive"]),
        .testTarget(
            name: "A11yoopTests",
            dependencies: ["A11yoopLive"]),
    ]
)

// MARK: - Features
package.targets.append(contentsOf: [
    .target(
        name: "A11yFeature",
        dependencies: []),
    .target(
        name: "A11yFeatureLive",
        dependencies: ["A11yFeature"]),
    .testTarget(
        name: "A11yFeatureTests",
        dependencies: ["A11yFeatureLive"])
])

// MARK: - Clients
package.targets.append(contentsOf: [
    .target(
        name: "A11yStatusEmitter",
        dependencies: ["A11yFeature"]),
    .target(
        name: "A11yStatusEmitterLive",
        dependencies: ["A11yStatusEmitter"]),
    .testTarget(
        name: "A11yStatusEmitterTests",
        dependencies: ["A11yStatusEmitterLive"]),

    .target(
        name: "A11yStore",
        dependencies: ["A11yFeature"]),
    .target(
        name: "A11yStoreLive",
        dependencies: ["A11yStore"]),
    .testTarget(
        name: "A11yStoreTests",
        dependencies: ["A11yStoreLive"]),

    .target(
        name: "A11yStatusObserver",
        dependencies: ["A11yFeature", "A11yFeature", "A11yStatusEmitter", "A11yStoreLive"]),
    .target(
        name: "A11yStatusObserverLive",
        dependencies: ["A11yStatusObserver"]),
    .testTarget(
        name: "A11yStatusObserverTests",
        dependencies: ["A11yStatusObserverLive"]),

    .target(
        name: "A11yStatusManager",
        dependencies: ["A11yFeature", "A11yStatusEmitter", "A11yFeature"]),
    .target(
        name: "A11yStatusManagerLive",
        dependencies: ["A11yStatusManager", "A11yStatusObserverLive", "A11yStoreLive"]),
])
