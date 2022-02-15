//
//  ContentSize+DescriptionTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import A11yoopMonitor

final class ContentSize_DescriptionTests: XCTestCase {

    private typealias sut = ContentSize

    func test_descriptionForUnknown() {

        XCTAssertEqual(sut.unknown.description, "Unknown")
    }

    func test_descriptionForExtraSmall() {

        XCTAssertEqual(sut.extraSmall.description, "Extra Small")
    }

    func test_descriptionForSmall() {

        XCTAssertEqual(sut.small.description, "Small")
    }

    func test_descriptionForMedium() {

        XCTAssertEqual(sut.medium.description, "Medium")
    }

    func test_descriptionForLarge() {

        XCTAssertEqual(sut.large.description, "Large")
    }

    func test_descriptionForExtraLarge() {

        XCTAssertEqual(sut.extraLarge.description, "Extra Large")
    }

    func test_descriptionForExtraExtraLarge() {

        XCTAssertEqual(sut.extraExtraLarge.description, "Extra Extra Large")
    }

    func test_descriptionForExtraExtraExtraLarge() {

        XCTAssertEqual(sut.extraExtraExtraLarge.description, "Extra Extra Extra Large")
    }

    func test_descriptionForAccessibilityMedium() {

        XCTAssertEqual(sut.accessibilityMedium.description, "Accessibility Medium")
    }

    func test_descriptionForAccessibilityLarge() {

        XCTAssertEqual(sut.accessibilityLarge.description, "Accessibility Large")
    }

    func test_descriptionForAccessibilityExtraLarge() {

        XCTAssertEqual(sut.accessibilityExtraLarge.description, "Accessibility Extra Large")
    }

    func test_descriptionForAccessibilityExtraExtraLarge() {

        XCTAssertEqual(sut.accessibilityExtraExtraLarge.description, "Accessibility Extra Extra Large")
    }

    func test_descriptionForAccessibilityExtraExtraExtraLarge() {

        XCTAssertEqual(sut.accessibilityExtraExtraExtraLarge.description, "Accessibility Extra Extra Extra Large")
    }
}
