//
//  A11yFeature+LiveTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import A11yFeature
import A11yStatusProvider
@testable import A11yFeatureLive

final class A11yFeature_LiveTests: XCTestCase {

    private var sut: A11yFeature!
    private var notificationCenter: NotificationCenter!
    private var subscriptions: Set<AnyCancellable>!

    private let type: A11yFeatureType = .assistiveTouch

    override func setUp() {
        super.setUp()

        notificationCenter = NotificationCenter()
        subscriptions = Set<AnyCancellable>()
    }

    func test_initialisedWithCorrectType() {

        sut = .live(type: type, statusProvider: .enabled, notificationCenter: notificationCenter)

        XCTAssertEqual(sut.type, type)
    }

    func test_statusInvokesStatusProvider() {

        var output = [A11yFeatureType]()
        var didInvokeStatusProvider = false

        let spy = A11yStatusProvider { type in
            output.append(type)
            didInvokeStatusProvider = true
            return .disabled
        }

        sut = .live(type: type, statusProvider: spy, notificationCenter: notificationCenter)

        XCTAssertEqual(sut.status, .disabled)

        XCTAssertTrue(didInvokeStatusProvider)
        XCTAssertEqual(output, [type])
    }

    func test_observeChangesDoesNotOutputUntilNotificationIsPosted() {

        var output = [A11yFeatureObservation]()

        sut = .live(type: type, statusProvider: .enabled, notificationCenter: notificationCenter)

        sut.observeChanges()
            .sink { output.append($0) }
            .store(in: &subscriptions)

        XCTAssertTrue(output.isEmpty)

        notificationCenter.post(name: type.notificationName, object: nil)

        XCTAssertEqual(output.count, 1)
    }

    func test_observeChangesUsesCorrectType() {

        var output = [A11yFeatureObservation]()

        sut = .live(type: type, statusProvider: .enabled, notificationCenter: notificationCenter)

        sut.observeChanges()
            .sink { output.append($0) }
            .store(in: &subscriptions)

        notificationCenter.post(name: type.notificationName, object: nil)

        XCTAssertEqual(try XCTUnwrap(output.first).type, type)
    }

    func test_observeChangesIsNotInvokedByIncorrectNotificationCenter() {

        var output = [A11yFeatureObservation]()

        sut = .live(type: type, statusProvider: .enabled, notificationCenter: notificationCenter)

        sut.observeChanges()
            .sink { output.append($0) }
            .store(in: &subscriptions)

        let otherNotificationCenter = NotificationCenter()

        otherNotificationCenter.post(name: type.notificationName, object: nil)

        XCTAssertTrue(output.isEmpty)
    }

    func test_observeChangesInvokesStatusProviderOnChangeAndReturnsCorrectStatus() {

        var output = [A11yFeatureObservation]()

        sut = .live(type: type, statusProvider: .enabled, notificationCenter: notificationCenter)

        sut.observeChanges()
            .sink { output.append($0) }
            .store(in: &subscriptions)

        notificationCenter.post(name: type.notificationName, object: nil)

        XCTAssertEqual(try XCTUnwrap(output.first).status, .enabled)
    }
}
