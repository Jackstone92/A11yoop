//
//  A11yStatusManagerTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import A11yFeature
import A11yStore
import A11yStoreLive
import A11yStatusEmitter
import A11yStatusManager
import A11yStatusManagerLive
import A11yStoreTestSupport
import A11yStatusEmitterTestSupport

final class A11yStatusManagerTests: XCTestCase {

    private var sut: A11yStatusManager!
    private var notificationCenter: NotificationCenter!
    private var subscriptions: Set<AnyCancellable>!

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

        sut = .live(featureStore: storeSpy, notificationCenter: notificationCenter)

        sut.observeFeatures(features, .init([]), .noop)

        XCTAssertEqual(output.map { $0.feature.status }, [.disabled])
        XCTAssertEqual(output.map { $0.type }, [.voiceOver])
    }

    func test_observeFeaturesInvokesSubjectOnFeatureStatusChange() {

        let features = [A11yFeature(type: .voiceOver, status: .disabled)]
        var output = [A11yFeature]()

        let subject = CurrentValueSubject<[A11yFeature], Never>([])

        subject
            .dropFirst()
            .sink { output.append(contentsOf: $0) }
            .store(in: &subscriptions)

        sut = .live(featureStore: .live, notificationCenter: notificationCenter)

        sut.observeFeatures(features, subject, .noop)

        notificationCenter.post(name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)

        XCTAssertEqual(output, features)
    }

    func test_observeFeaturesInvokesEmitterOnFeatureStatusChange() {

        let features = [A11yFeature(type: .voiceOver, status: .disabled)]
        var output = [A11yFeature]()

        let emitterSpy = A11yStatusEmitter { output.append($0) }

        sut = .live(featureStore: .live, notificationCenter: notificationCenter)

        sut.observeFeatures(features, .init([]), emitterSpy)

        notificationCenter.post(name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)

        XCTAssertEqual(output, features)
    }

    // MARK: - isFeatureEnabled tests
    func test_isFeatureEnabledWhenFeatureEnabled() {

        let store: FeatureStore = .live
        let enabledVoiceoverFeature = A11yFeature(type: .voiceOver, status: .enabled)
        store.insert(enabledVoiceoverFeature, .voiceOver)

        sut = .live(featureStore: store, notificationCenter: notificationCenter)

        XCTAssertTrue(sut.isFeatureEnabled(.voiceOver))
    }

    func test_isFeatureEnabledWhenFeatureDisabled() {

        let store: FeatureStore = .live
        let disabledVoiceoverFeature = A11yFeature(type: .voiceOver, status: .disabled)
        store.insert(disabledVoiceoverFeature, .voiceOver)

        sut = .live(featureStore: store, notificationCenter: notificationCenter)

        XCTAssertFalse(sut.isFeatureEnabled(.voiceOver))
    }

    func test_isFeatureEnabledWhenFeatureNotInFeatureStore() {

        let store: FeatureStore = .live
        XCTAssertNil(store.get(.voiceOver))

        sut = .live(featureStore: store, notificationCenter: notificationCenter)

        XCTAssertFalse(sut.isFeatureEnabled(.voiceOver))
    }
}
