//
//  UIContentSizeCategory+AsContentSizeTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
@testable import A11yoopMonitor

final class UIContentSizeCategory_AsContentSizeTests: XCTestCase {

    private typealias sut = UIContentSizeCategory

    func test_asContentSizeForExtraSmall() {

        XCTAssertEqual(sut.extraSmall.asContentSize(), .extraSmall)
    }

    func test_asContentSizeForSmall() {

        XCTAssertEqual(sut.small.asContentSize(), .small)
    }

    func test_asContentSizeForMedium() {

        XCTAssertEqual(sut.medium.asContentSize(), .medium)
    }

    func test_asContentSizeForLarge() {

        XCTAssertEqual(sut.large.asContentSize(), .large)
    }

    func test_asContentSizeForExtraLarge() {

        XCTAssertEqual(sut.extraLarge.asContentSize(), .extraLarge)
    }

    func test_asContentSizeForExtraExtraLarge() {

        XCTAssertEqual(sut.extraExtraLarge.asContentSize(), .extraExtraLarge)
    }

    func test_asContentSizeForExtraExtraExtraLarge() {

        XCTAssertEqual(sut.extraExtraExtraLarge.asContentSize(), .extraExtraExtraLarge)
    }

    func test_asContentSizeForAccessibilityMedium() {

        XCTAssertEqual(sut.accessibilityMedium.asContentSize(), .accessibilityMedium)
    }

    func test_asContentSizeForAccessibilityLarge() {

        XCTAssertEqual(sut.accessibilityLarge.asContentSize(), .accessibilityLarge)
    }

    func test_asContentSizeForAccessibilityExtraLarge() {

        XCTAssertEqual(sut.accessibilityExtraLarge.asContentSize(), .accessibilityExtraLarge)
    }

    func test_asContentSizeForAccessibilityExtraExtraLarge() {

        XCTAssertEqual(sut.accessibilityExtraExtraLarge.asContentSize(), .accessibilityExtraExtraLarge)
    }

    func test_asContentSizeForAccessibilityExtraExtraExtraLarge() {

        XCTAssertEqual(sut.accessibilityExtraExtraExtraLarge.asContentSize(), .accessibilityExtraExtraExtraLarge)
    }

    func test_asContentSizeForUnknown() {

        XCTAssertEqual(sut(rawValue: "Unknown").asContentSize(), .unknown)
    }
}
