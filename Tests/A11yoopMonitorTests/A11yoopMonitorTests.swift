//
//  A11yoopMonitorTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import CombineSchedulers
import A11yFeature
import A11yStatusEmitter
import A11yMonitor
import A11yStatusProvider
@testable import A11yoopMonitor

final class A11yoopMonitorTests: XCTestCase {

    private var sut: A11yoopMonitor!

    private var notificationCenter: NotificationCenter!
    private let queue = DispatchQueue.immediate.eraseToAnyScheduler()

    override func setUp() {
        super.setUp()
        notificationCenter = NotificationCenter()
    }

    // MARK: - Initialisation
    func test_passesSpecifiedFeatureTypesToUnderlyingMonitor() {

        let featureTypes: [A11yFeatureType] = [.voiceOver, .darkerSystemColours, .greyscale]

        sut = A11yoopMonitor(featureTypes: featureTypes, queue: queue)

        let underlyingObservedFeatureTypes = sut._monitor.featuresSubject.value.map(\.type)

        XCTAssertEqual(underlyingObservedFeatureTypes, featureTypes)
    }

    func test_passesSpecifiedEmittersToUnderlyingMonitor() {

        var output = [A11yFeature]()

        let spy = A11yStatusEmitter { output.append($0) }

        sut = A11yoopMonitor(emitters: [spy], queue: queue)

        NotificationCenter.default.post(name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)

        XCTAssertEqual(output.map(\.type), [.voiceOver])
    }

    func test_defaultFeatureTypes() {

        sut = A11yoopMonitor(queue: queue)

        let underlyingObservedFeatureTypes = sut._monitor.featuresSubject.value.map(\.type)

        XCTAssertEqual(underlyingObservedFeatureTypes, A11yFeatureType.allCases)
    }

    // MARK: - allFeatures tests
    func test_featuresReturnsListOfCurrentlyObservedA11yFeatures() {

        let features = [
            A11yFeature(type: .voiceOver, status: .enabled),
            A11yFeature(type: .greyscale, status: .disabled),
            A11yFeature(type: .largerText, status: .contentSize(.accessibilityExtraLarge)),
            A11yFeature(type: .buttonShapes, status: .notSupported)
        ]

        sut = A11yoopMonitor(featureTypes: [], queue: queue)

        XCTAssertTrue(sut._monitor.featuresSubject.value.isEmpty)
        XCTAssertTrue(sut.allFeatures.isEmpty)

        sut._monitor.featuresSubject.send(features)

        XCTAssertEqual(sut.allFeatures, features)
    }

    // MARK: - enabledFeatures tests
    func test_enabledFeaturesOnlyReturnsFeaturesThatAreEnabled() {

        let statusProvider = A11yStatusProvider { type in
            switch type {
            case .voiceOver:    return .enabled
            case .buttonShapes: return .notSupported
            case .largerText:   return .contentSize(.medium)
            case .boldText:     return .disabled
            default:            XCTFail(); return .notSupported
            }
        }

        sut = A11yoopMonitor(
            monitor: .live(
                featureTypes: [.voiceOver, .buttonShapes, .largerText, .boldText],
                emitters: [],
                statusObserver: .live(
                    featureStore: .live,
                    statusProvider: statusProvider,
                    notificationCenter: notificationCenter,
                    queue: queue
                ),
                statusProvider: statusProvider
            )
        )

        XCTAssertEqual(
            sut.enabledFeatures,
            [A11yFeature(type: .voiceOver, status: .enabled), A11yFeature(type: .largerText, status: .contentSize(.medium))]
        )
    }

    // MARK: - disabledFeatures tests
    func test_disabledFeaturesOnlyReturnsFeaturesThatAreDisabled() {

        let statusProvider = A11yStatusProvider { type in
            switch type {
            case .voiceOver:    return .enabled
            case .buttonShapes: return .notSupported
            case .largerText:   return .contentSize(.medium)
            case .boldText:     return .disabled
            default:            XCTFail(); return .notSupported
            }
        }

        sut = A11yoopMonitor(
            monitor: .live(
                featureTypes: [.voiceOver, .buttonShapes, .largerText, .boldText],
                emitters: [],
                statusObserver: .live(
                    featureStore: .live,
                    statusProvider: statusProvider,
                    notificationCenter: notificationCenter,
                    queue: queue
                ),
                statusProvider: statusProvider
            )
        )

        XCTAssertEqual(sut.disabledFeatures, [A11yFeature(type: .boldText, status: .disabled)])
    }

    // MARK: - unsupportedFeatures tests
    func test_unsupportedFeaturesOnlyReturnsFeaturesThatAreUnsupported() {

        let statusProvider = A11yStatusProvider { type in
            switch type {
            case .voiceOver:    return .enabled
            case .buttonShapes: return .notSupported
            case .largerText:   return .contentSize(.medium)
            case .boldText:     return .disabled
            default:            XCTFail(); return .notSupported
            }
        }

        sut = A11yoopMonitor(
            monitor: .live(
                featureTypes: [.voiceOver, .buttonShapes, .largerText, .boldText],
                emitters: [],
                statusObserver: .live(
                    featureStore: .live,
                    statusProvider: statusProvider,
                    notificationCenter: notificationCenter,
                    queue: queue
                ),
                statusProvider: statusProvider
            )
        )

        XCTAssertEqual(sut.unsupportedFeatures, [A11yFeature(type: .buttonShapes, status: .notSupported)])
    }

    // MARK: - isFeatureEnabled tests
    func test_isFeatureEnabledInvokesUnderlyingMonitor() {

        var output = [A11yFeatureType]()

        let spy = A11yMonitor(
            featuresSubject: .init([]),
            isFeatureEnabled: {
                output.append($0)
                return .disabled
            }
        )

        sut = A11yoopMonitor(monitor: spy)

        _ = sut.isFeatureEnabled(.assistiveTouch)

        XCTAssertEqual(output, [.assistiveTouch])
    }
}
