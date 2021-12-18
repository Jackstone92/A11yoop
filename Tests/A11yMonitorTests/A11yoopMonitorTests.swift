//
//  A11yoopMonitorTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yFeature
import A11yStatusObserver
import A11yStatusProvider
import A11yStatusEmitter
import A11yMonitor
import A11yMonitorLive

final class A11yoopMonitorTests: XCTestCase {

    private var sut: A11yMonitor!

    private let featureTypes: [A11yFeatureType] = [.assistiveTouch, .guidedAccess, .speakSelection, .voiceOver]

    func test_statusManagerObservesFeaturesOnInitialisation() {

        var output = [A11yFeature]()
        var didInvokeStatusManager = false

        let spy = A11yStatusObserver(
            observeFeatures: { features, _ in
                output.append(contentsOf: features)
                didInvokeStatusManager = true
            },
            isFeatureEnabled: { _ in XCTFail(); return false }
        )

        sut = .live(
            featureTypes: featureTypes,
            emitters: [.noop],
            statusObserver: spy,
            statusProvider: .enabled
        )

        XCTAssertTrue(didInvokeStatusManager)
        XCTAssertEqual(output.map { $0.type }, featureTypes)
    }

    func test_isFeatureEnabledInvokesStatusManagerWithFeatureType() {

        var output = [A11yFeatureType]()
        var didInvokeStatusManager = false

        let spy = A11yStatusObserver(
            observeFeatures: { _, _ in },
            isFeatureEnabled: { type in
                output.append(type)
                didInvokeStatusManager = true
                return true
            }
        )

        sut = .live(
            featureTypes: featureTypes,
            emitters: [.noop],
            statusObserver: spy,
            statusProvider: .enabled
        )

        XCTAssertTrue(sut.isFeatureEnabled(try XCTUnwrap(featureTypes.first)))

        XCTAssertTrue(didInvokeStatusManager)
        XCTAssertEqual(output, [try XCTUnwrap(featureTypes.first)])
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
