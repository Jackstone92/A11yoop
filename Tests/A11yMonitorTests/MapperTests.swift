//
//  MapperTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import A11yFeature
import A11yStatusProvider
import A11yMonitor
@testable import A11yMonitorLive

final class MapperTests: XCTestCase {

    private var statusProvider: A11yStatusProvider!
    private var subscriptions: Set<AnyCancellable>!

    private let featureType: A11yFeatureType = .assistiveTouch

    override func setUp() {
        super.setUp()
        statusProvider = .enabled
        subscriptions = Set<AnyCancellable>()
    }

    func test_asA11yFeaturePassesType() {

        let sut = Mapper.asA11yFeature(using: statusProvider).map(featureType)

        XCTAssertEqual(sut.type, featureType)
    }

    func test_asA11yFeaturePassesStatusProviderInstance() {

        var didInvokeStatusProvider = false

        let spy = A11yStatusProvider { type in
            XCTAssertEqual(type, self.featureType)
            didInvokeStatusProvider = true
            return .enabled
        }

        let sut = Mapper.asA11yFeature(using: spy).map(featureType)

        XCTAssertEqual(sut.status, .enabled)

        XCTAssertTrue(didInvokeStatusProvider)
    }

    func test_mapSequenceOfFeatureMappedElements() {

        let featureTypes: [A11yFeatureType] = [.assistiveTouch, .guidedAccess, .preferCrossFadeTransitions]

        let sut = featureTypes.map(.asA11yFeature(using: statusProvider))

        XCTAssertEqual(sut.map { $0.type }, featureTypes)
    }
}
