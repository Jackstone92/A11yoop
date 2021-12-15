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
            dependencies: ["MonitorLive", .product(name: "CombineSchedulers", package: "combine-schedulers")]),
        .testTarget(
            name: "A11yoopMonitorTests",
            dependencies: ["A11yoopMonitor"])
    ]
)

// MARK: - Features
package.targets.append(contentsOf: [
    .target(
        name: "A11yFeature",
        dependencies: []),
    .testTarget(
        name: "A11yFeatureTests",
        dependencies: ["A11yFeature"])
])

// MARK: - Clients
package.targets.append(contentsOf: [
    .target(
        name: "Monitor",
        dependencies: ["A11yFeature"]),
    .target(
        name: "MonitorLive",
        dependencies: ["Monitor", "A11yStatusObserverLive", "A11yStatusEmitterLive", "A11yStatusProviderLive"]),
    .testTarget(
        name: "MonitorTests",
        dependencies: ["MonitorLive", "A11yStatusEmitterTestSupport"]),

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
        dependencies: ["A11yFeature", "A11yStatusEmitter"]),
    .target(
        name: "A11yStatusObserverLive",
        dependencies: [
            "A11yStatusObserver",
            "A11yStoreLive",
            "A11yStatusProviderLive",
            .product(name: "CombineSchedulers", package: "combine-schedulers")
        ]),
    .testTarget(
        name: "A11yStatusObserverTests",
        dependencies: ["A11yStatusObserverLive",
                       "A11yStoreTestSupport",
                       "A11yStatusEmitterTestSupport"]),

    .target(
        name: "A11yStatusProvider",
        dependencies: ["A11yFeature"]),
    .target(
        name: "A11yStatusProviderLive",
        dependencies: ["A11yFeature", "A11yStatusProvider"]),
    .testTarget(
        name: "A11yStatusProviderTests",
        dependencies: ["A11yStatusProviderLive"])
])
