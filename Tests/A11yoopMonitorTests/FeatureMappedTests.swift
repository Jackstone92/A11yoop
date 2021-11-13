//
//  FeatureMappedTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import A11yFeature
@testable import A11yFeatureLive
import A11yStatusProvider
import A11yoopMonitor
@testable import A11yoopMonitorLive

final class FeatureMappedTests: XCTestCase {

    private var statusProvider: A11yStatusProvider!
    private var notificationCenter: NotificationCenter!
    private var subscriptions: Set<AnyCancellable>!

    private let featureType: A11yFeatureType = .assistiveTouch

    override func setUp() {
        super.setUp()
        statusProvider = .enabled
        notificationCenter = NotificationCenter()
        subscriptions = Set<AnyCancellable>()
    }

    func test_asA11yFeaturePassesType() {

        let sut = FeatureMapped.asA11yFeature(using: statusProvider, notificationCenter: notificationCenter).mapped(featureType)

        XCTAssertEqual(sut.type, featureType)
    }

    func test_asA11yFeaturePassesStatusProviderInstance() {

        var didInvokeStatusProvider = false

        let spy = A11yStatusProvider { type in
            XCTAssertEqual(type, self.featureType)
            didInvokeStatusProvider = true
            return .enabled
        }

        let sut = FeatureMapped.asA11yFeature(using: spy, notificationCenter: notificationCenter).mapped(featureType)

        XCTAssertEqual(sut.status, .enabled)

        XCTAssertTrue(didInvokeStatusProvider)
    }

    func test_asA11yFeaturePassesNotificationCenterInstance() {

        var output = [A11yFeatureObservation]()

        let sut = FeatureMapped.asA11yFeature(using: statusProvider, notificationCenter: notificationCenter).mapped(featureType)

        sut.observeChanges()
            .sink { output.append($0) }
            .store(in: &subscriptions)

        XCTAssertTrue(output.isEmpty)

        notificationCenter.post(name: featureType.notificationName, object: nil)

        XCTAssertEqual(output.count, 1)
    }

    func test_mapSequenceOfFeatureMappedElements() {

        let featureTypes: [A11yFeatureType] = [.assistiveTouch, .guidedAccess, .preferCrossFadeTransitions]

        let sut = featureTypes.map(.asA11yFeature(using: statusProvider, notificationCenter: notificationCenter))

        XCTAssertEqual(sut.map { $0.type }, featureTypes)
    }
}
