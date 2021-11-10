//
//  A11yStatusObserverTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import A11yStatusObserver
import A11yStatusObserverLive
import A11yStatusEmitter
import A11yStoreLive
import A11yFeature
import A11yStoreTestSupport
import A11yStatusEmitterTestSupport

final class A11yStatusObserverTests: XCTestCase {

    private var sut: A11yStatusObserver!
    private var subscriptions: Set<AnyCancellable>!

    private let type: A11yFeatureType = .voiceOver
    private let fromStatus: A11yStatus = .disabled
    private let toStatus: A11yStatus = .enabled

    override func setUp() {
        super.setUp()
        sut = .live
        subscriptions = Set<AnyCancellable>()
    }

    func test_observeChangesDoesNotUpdateStoreIfNoChangesObserved() {

        let feature = A11yFeature(
            type: .voiceOver,
            status: .disabled,
            observeChanges: { Empty().eraseToAnyPublisher() }
        )

        sut.observeChanges(feature, .notInvoked, .notInvoked)
            .store(in: &subscriptions)
    }

    func test_observeChangesUpdatesStoreIfChangesObserved() throws {

        var storeUpdateData: (A11yStatus, A11yFeatureType)?

        let feature = A11yFeature(
            type: type,
            status: fromStatus,
            observeChanges: { Just(A11yFeatureObservation(type: self.type, status: self.toStatus)).eraseToAnyPublisher() }
        )

        let storeSpy = FeatureStore(
            get: { _ in XCTFail(); return nil },
            insert: { _, _ in XCTFail() },
            update: { storeUpdateData = ($0, $1) },
            remove: { _ in XCTFail(); return nil }
        )

        sut.observeChanges(feature, storeSpy, .noop)
            .store(in: &subscriptions)

        let (status, type) = try XCTUnwrap(storeUpdateData)

        XCTAssertEqual(status, toStatus)
        XCTAssertEqual(type, self.type)
    }

    func test_observeChangesDoesNotEmitIfNoChangesObserved() {

        let feature = A11yFeature(
            type: .voiceOver,
            status: .disabled,
            observeChanges: { Empty().eraseToAnyPublisher() }
        )

        sut.observeChanges(feature, .notInvoked, .notInvoked)
            .store(in: &subscriptions)
    }

    func test_observeChangesEmitsIfChangesObserved() throws {

        var emitData: (A11yStatus, A11yFeatureType)?

        let feature = A11yFeature(
            type: .voiceOver,
            status: .disabled,
            observeChanges: { Just(A11yFeatureObservation(type: self.type, status: self.toStatus)).eraseToAnyPublisher() }
        )

        let emitterSpy = A11yStatusEmitter { emitData = ($0, $1) }

        sut.observeChanges(feature, .noop, emitterSpy)
            .store(in: &subscriptions)

        let (status, type) = try XCTUnwrap(emitData)

        XCTAssertEqual(status, toStatus)
        XCTAssertEqual(type, self.type)
    }
}
