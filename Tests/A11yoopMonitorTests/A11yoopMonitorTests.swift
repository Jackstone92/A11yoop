//
//  A11yoopMonitorTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yFeature
import A11yStatusEmitter
import Monitor
@testable import A11yoopMonitor

final class A11yoopMonitorTests: XCTestCase {

    private var sut: A11yoopMonitor!

    // MARK: - Initialisation
    func test_passesSpecifiedFeatureTypesToUnderlyingMonitor() {

        let featureTypes: [A11yFeatureType] = [.voiceOver, .darkerSystemColours, .greyscale]

        sut = A11yoopMonitor(featureTypes: featureTypes)

        let underlyingObservedFeatureTypes = sut._monitor.featuresSubject.value.map(\.type)

        XCTAssertEqual(underlyingObservedFeatureTypes, featureTypes)
    }

    func test_passesSpecifiedEmittersToUnderlyingMonitor() {

        var output = [A11yFeature]()

        let spy = A11yStatusEmitter { output.append($0) }

        sut = A11yoopMonitor(emitters: [spy])

        NotificationCenter.default.post(name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)

        XCTAssertEqual(output.map(\.type), [.voiceOver])
    }

    func test_defaultFeatureTypes() {

        sut = A11yoopMonitor()

        let underlyingObservedFeatureTypes = sut._monitor.featuresSubject.value.map(\.type)

        XCTAssertEqual(underlyingObservedFeatureTypes, A11yFeatureType.allCases)
    }

    // MARK: - features tests
    func test_featuresReturnsListOfCurrentlyObservedA11yFeatures() {

        let features = [
            A11yFeature(type: .voiceOver, status: .enabled),
            A11yFeature(type: .greyscale, status: .disabled),
            A11yFeature(type: .largerText, status: .contentSize(.accessibilityExtraLarge)),
            A11yFeature(type: .buttonShapes, status: .notSupported)
        ]

        sut = A11yoopMonitor(featureTypes: [])

        XCTAssertTrue(sut._monitor.featuresSubject.value.isEmpty)
        XCTAssertTrue(sut.features.isEmpty)

        sut._monitor.featuresSubject.send(features)

        XCTAssertEqual(sut.features, features)
    }

    // MARK: - isFeatureEnabled tests
    func test_isFeatureEnabledInvokesMonitor() {

        var output = [A11yFeatureType]()

        let spy = Monitor(
            featuresSubject: .init([]),
            isFeatureEnabled: {
                output.append($0)
                return false
            }
        )

        sut = A11yoopMonitor(monitor: spy)

        _ = sut.isFeatureEnabled(.assistiveTouch)

        XCTAssertEqual(output, [.assistiveTouch])
    }
}
