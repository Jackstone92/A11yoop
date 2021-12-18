//
//  A11yStatusObserverTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import CombineSchedulers
import A11yFeature
import A11yStore
import A11yStoreLive
import A11yStatusEmitter
import A11yStatusObserver
@testable import A11yStatusObserverLive

final class A11yStatusObserverTests: XCTestCase {

    private var sut: A11yStatusObserver!
    private var notificationCenter: NotificationCenter!
    private var subscriptions: Set<AnyCancellable>!

    private let queue = DispatchQueue.immediate.eraseToAnyScheduler()

    override func setUp() {
        super.setUp()
        notificationCenter = NotificationCenter()
        subscriptions = Set<AnyCancellable>()
    }

    // MARK: - observeFeatures tests
    func test_observeFeaturesAddsEachFeatureToFeatureStore() {

        let features = [A11yFeature(type: .voiceOver, status: .disabled)]
        var output = [(feature: A11yFeature, type: A11yFeatureType)]()

        let storeSpy = FeatureStore(
            get: { _ in XCTFail(); return nil },
            getAll: { XCTFail(); return [] },
            insert: { output.append(($0, $1)) },
            update: { _, _ in XCTFail() },
            remove: { _ in XCTFail(); return nil }
        )

        sut = .live(featureStore: storeSpy, notificationCenter: notificationCenter, queue: queue)

        sut.observeFeatures(features, [.noop])

        XCTAssertEqual(output.map { $0.feature.status }, [.disabled])
        XCTAssertEqual(output.map { $0.type }, [.voiceOver])
    }

    func test_observeFeaturesInvokesEmitterOnFeatureStatusChange() {

        let features = [A11yFeature(type: .voiceOver, status: .disabled)]
        var output = [A11yFeature]()

        let emitterSpy = A11yStatusEmitter { output.append($0) }

        sut = .live(featureStore: .live, notificationCenter: notificationCenter, queue: queue)

        sut.observeFeatures(features, [emitterSpy])

        notificationCenter.post(name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)

        XCTAssertEqual(output, features)
    }

    // MARK: - isFeatureEnabled tests
    func test_isFeatureEnabledWhenFeatureEnabled() {

        let store: FeatureStore = .live
        let enabledVoiceoverFeature = A11yFeature(type: .voiceOver, status: .enabled)
        store.insert(enabledVoiceoverFeature, .voiceOver)

        sut = .live(featureStore: store, notificationCenter: notificationCenter, queue: queue)

        XCTAssertTrue(sut.isFeatureEnabled(.voiceOver))
    }

    func test_isFeatureEnabledWhenFeatureDisabled() {

        let store: FeatureStore = .live
        let disabledVoiceoverFeature = A11yFeature(type: .voiceOver, status: .disabled)
        store.insert(disabledVoiceoverFeature, .voiceOver)

        sut = .live(featureStore: store, notificationCenter: notificationCenter, queue: queue)

        XCTAssertFalse(sut.isFeatureEnabled(.voiceOver))
    }

    func test_isFeatureEnabledWhenFeatureNotInFeatureStore() {

        let store: FeatureStore = .live
        XCTAssertNil(store.get(.voiceOver))

        sut = .live(featureStore: store, notificationCenter: notificationCenter, queue: queue)

        XCTAssertFalse(sut.isFeatureEnabled(.voiceOver))
    }

    // MARK: - Multiple emitter tests
    func test_multipleEmittersOnlyEmitOnceEachPerStatusChange() {

        var outputA = [A11yFeature]()
        var outputB = [A11yFeature]()

        let features = [A11yFeature(type: .voiceOver, status: .disabled)]

        let spyA = A11yStatusEmitter { outputA.append($0) }
        let spyB = A11yStatusEmitter { outputB.append($0) }

        sut = .live(notificationCenter: notificationCenter, queue: queue)

        sut.observeFeatures(features, [spyA, spyB])

        notificationCenter.post(name: A11yFeatureType.voiceOver.notificationName, object: nil)

        XCTAssertEqual(outputA.count, 1)
        XCTAssertEqual(outputB.count, 1)
    }
}

private extension A11yStatusEmitter {

    /// A status emitter designed for testing purposes, which should never be invoked.
    /// If it is, it will result in an `XCTFail`.
    static var notInvoked: Self {
        Self { _ in XCTFail() }
    }

    /// A stub status emitter designed for testing purposes.
    static var noop: Self {
        Self { _ in }
    }
}

private extension FeatureStore {

    /// An accessibility feature store designed for testing purposes, which should never be invoked.
    /// If it is, it will result in an `XCTFail`.
    static var notInvoked: Self {
        Self(
            get: { _ in XCTFail(); return nil },
            getAll: { XCTFail(); return [] },
            insert: { _, _ in XCTFail() },
            update: { _, _ in XCTFail() },
            remove: { _ in XCTFail(); return nil }
        )
    }

    /// A stub accessibility feature store designed for testing purposes.
    static var noop: Self {
        Self(
            get: { _ in return nil },
            getAll: { return [] },
            insert: { _, _ in },
            update: { _, _ in },
            remove: { _ in return nil }
        )
    }
}
