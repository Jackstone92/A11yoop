//
//  A11yoopMonitorTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yFeature
import A11yStatusManager
import A11yStatusProvider
import A11yStatusEmitter
import A11yoopMonitor
import A11yoopMonitorLive
import A11yStatusEmitterTestSupport

final class A11yoopMonitorTests: XCTestCase {

    private var sut: A11yoopMonitor!

    private let featureTypes: [A11yFeatureType] = [.assistiveTouch, .guidedAccess, .speakSelection, .voiceOver]

    func test_statusManagerObservesFeaturesOnInitialisation() {

        var output = [A11yFeature]()
        var didInvokeStatusManager = false

        let spy = A11yStatusManager(
            observeFeatures: { features, _ in
                output.append(contentsOf: features)
                didInvokeStatusManager = true
            },
            isFeatureEnabled: { _ in XCTFail(); return false }
        )

        sut = .live(
            featureTypes: featureTypes,
            statusManager: spy,
            emitters: [.noop],
            statusProvider: .enabled
        )

        XCTAssertTrue(didInvokeStatusManager)
        XCTAssertEqual(output.map { $0.type }, featureTypes)
    }

    func test_isFeatureEnabledInvokesStatusManagerWithFeatureType() {

        var output = [A11yFeatureType]()
        var didInvokeStatusManager = false

        let spy = A11yStatusManager(
            observeFeatures: { _, _ in },
            isFeatureEnabled: { type in
                output.append(type)
                didInvokeStatusManager = true
                return true
            }
        )

        sut = .live(
            featureTypes: featureTypes,
            statusManager: spy,
            emitters: [.noop],
            statusProvider: .enabled
        )

        XCTAssertTrue(sut.isFeatureEnabled(try XCTUnwrap(featureTypes.first)))

        XCTAssertTrue(didInvokeStatusManager)
        XCTAssertEqual(output, [try XCTUnwrap(featureTypes.first)])
    }
}
