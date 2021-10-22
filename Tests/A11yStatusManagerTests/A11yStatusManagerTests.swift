//
//  A11yStatusManagerTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import A11yFeature
import A11yStore
import A11yStoreLive
import A11yStatusObserver
import A11yStatusEmitter
import A11yStatusManager
import A11yStatusManagerLive
import A11yStoreTestSupport
import A11yStatusEmitterTestSupport
import A11yStatusObserverTestSupport

final class A11yStatusManagerTests: XCTestCase {

    private var sut: A11yStatusManager!
    private var subscriptions: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        subscriptions = Set<AnyCancellable>()
    }

    // MARK: - observeFeatures tests
    func test_observeFeaturesAddsEachFeatureToFeatureStore() {

        let features: [A11yFeature] = [
            .init(
                type: .voiceOver,
                status: .disabled,
                observeChanges: { Empty().eraseToAnyPublisher() }
            )
        ]
        var addedFeatureData = [(status: A11yStatus, type: A11yFeatureType)]()

        let storeSpy = FeatureStore(
            get: { _ in XCTFail(); return nil },
            insert: { addedFeatureData.append(($0, $1)) },
            update: { _, _ in XCTFail() },
            remove: { _ in XCTFail() }
        )

        sut = .live(observer: .noop, featureStore: storeSpy)

        sut.observeFeatures(features, .noop)

        XCTAssertEqual(addedFeatureData.map { $0.status }, [.disabled])
        XCTAssertEqual(addedFeatureData.map { $0.type }, [.voiceOver])
    }

    func test_observeFeaturesSubscribesToObserveChangesToEachFeature() {

        var featuresObserved = [A11yFeature]()

        let features: [A11yFeature] = [
            .init(
                type: .voiceOver,
                status: .disabled,
                observeChanges: { Empty().eraseToAnyPublisher() }
            )
        ]

        let observerSpy = A11yStatusObserver { feature, _, _ in
            featuresObserved.append(feature)
            return AnyCancellable({})
        }

        sut = .live(observer: observerSpy, featureStore: .noop)

        sut.observeFeatures(features, .noop)

        XCTAssertEqual(featuresObserved, features)
    }

    // MARK: - isFeatureEnabled tests
    func test_isFeatureEnabledWhenFeatureEnabled() throws {

        let store: FeatureStore = .live
        try store.insert(.enabled, .voiceOver)

        sut = .live(observer: .noop, featureStore: store)

        XCTAssertTrue(sut.isFeatureEnabled(.voiceOver))
    }

    func test_isFeatureEnabledWhenFeatureDisabled() throws {

        let store: FeatureStore = .live
        try store.insert(.disabled, .voiceOver)

        sut = .live(observer: .noop, featureStore: store)

        XCTAssertFalse(sut.isFeatureEnabled(.voiceOver))
    }

    func test_isFeatureEnabledWhenFeatureNotInFeatureStore() {

        let store: FeatureStore = .live
        XCTAssertNil(store.get(.voiceOver))

        sut = .live(observer: .noop, featureStore: store)

        XCTAssertFalse(sut.isFeatureEnabled(.voiceOver))
    }
}
