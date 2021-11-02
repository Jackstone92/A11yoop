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
    ],
    targets: [
        .target(
            name: "A11yoopMonitor",
            dependencies: ["A11yFeature"]),
        .target(
            name: "A11yoopMonitorLive",
            dependencies: ["A11yoopMonitor", "A11yStatusManagerLive", "A11yStatusEmitterLive", "A11yFeatureLive"]),
        .testTarget(
            name: "A11yoopMonitorTests",
            dependencies: ["A11yoopMonitorLive"]),
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
    .target(
        name: "A11yStatusEmitterTestSupport",
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
    .target(
        name: "A11yStoreTestSupport",
        dependencies: ["A11yStoreLive"]),
    .testTarget(
        name: "A11yStoreTests",
        dependencies: ["A11yStoreLive"]),

    .target(
        name: "A11yStatusObserver",
        dependencies: ["A11yFeature", "A11yFeature", "A11yStatusEmitter", "A11yStoreLive"]),
    .target(
        name: "A11yStatusObserverLive",
        dependencies: ["A11yStatusObserver"]),
    .target(
        name: "A11yStatusObserverTestSupport",
        dependencies: ["A11yStatusObserver"]),
    .testTarget(
        name: "A11yStatusObserverTests",
        dependencies: ["A11yStatusObserverLive",
                       "A11yStoreTestSupport",
                       "A11yStatusEmitterTestSupport"]),

    .target(
        name: "A11yStatusManager",
        dependencies: ["A11yFeature", "A11yStatusEmitter", "A11yFeature"]),
    .target(
        name: "A11yStatusManagerLive",
        dependencies: ["A11yStatusManager", "A11yStatusObserverLive", "A11yStoreLive"]),
    .testTarget(
        name: "A11yStatusManagerTests",
        dependencies: ["A11yStatusManagerLive",
                       "A11yStoreTestSupport",
                       "A11yStatusEmitterTestSupport",
                       "A11yStatusObserverTestSupport"]),
])
