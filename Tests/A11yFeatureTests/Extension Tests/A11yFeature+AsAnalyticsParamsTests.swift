//
//  A11yFeature+AsAnalyticsParamsTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import A11yFeature

final class A11yFeature_AsAnalyticsParamsTests: XCTestCase {

    func test_asAnalyticsParams() {

        let features = [
            A11yFeature(type: .voiceOver, status: .enabled),
            A11yFeature(type: .boldText, status: .disabled),
            A11yFeature(type: .largerText, status: .contentSize(.accessibilityExtraExtraExtraLarge))
        ]

        let expected: [String: Any] = [
            "Bold Text": "Disabled",
            "Larger Text": "Accessibility Extra Extra Extra Large",
            "VoiceOver": "Enabled"
        ]

        XCTAssertDictionariesEqual(features.asAnalyticsParams(), expected)
    }

    func test_asAnalyticsParamsWithPrefix() {

        let features = [A11yFeature(type: .boldText, status: .disabled)]

        let expected = ["A11yoop Bold Text": "Disabled"]

        XCTAssertDictionariesEqual(features.asAnalyticsParams(prefixedBy: "A11yoop"), expected)
    }

    func test_asAnalyticsParamsWhenEmpty() {

        let emptyFeatures = [A11yFeature]()

        XCTAssertTrue(emptyFeatures.asAnalyticsParams().isEmpty)
    }
}

fileprivate extension Dictionary where Value: Any {

    /// Returns a Boolean value indicating whether two dictionaries are equal.
    ///
    /// Compares two dictionaries that have heterogeneous value types by attempting to
    /// cast the values to AnyHashable and if that succeeds compares using Equatable conformance.
    ///
    /// Returns false if any of the values do not have Hashable conformance.
    ///
    /// - Parameters:
    ///   - lhs: A dictionary to compare.
    ///   - rhs: Another dictionary to compare.
    static func == (lhs: Dictionary, rhs: Dictionary) -> Bool {

        guard lhs.keys == rhs.keys else { return false }

        for key in lhs.keys {
            guard let lhsValue = lhs[key] as? AnyHashable, let rhsValue = rhs[key] as? AnyHashable else {
                return false
            }

            guard lhsValue == rhsValue else {
                return false
            }
        }

        return true
    }

    static func != (lhs: Dictionary, rhs: Dictionary) -> Bool {
        return (lhs == rhs) == false
    }
}

/// Asserts that two dictionaries are equal.
/// Will fail if any of the values do not have Hashable conformance.
func XCTAssertDictionariesEqual(
    _ expression1: [String: Any],
    _ expression2: [String: Any],
    file: StaticString = #file,
    line: UInt = #line
) {

    if expression1 != expression2 {
        let message = "(\"\(expression1)\") is not equal to (\"\(expression2)\")"
        XCTFail("XCTAssertDictionariesEqual failed: \(message)", file: file, line: line)
    }
}
