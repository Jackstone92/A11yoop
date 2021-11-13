//
//  A11yStatus+DescriptionTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yFeature

final class A11yStatus_DescriptionTests: XCTestCase {

    private typealias sut = A11yStatus

    func test_descriptionForEnabled() {

        XCTAssertEqual(sut.enabled.description, "Enabled")
    }

    func test_descriptionForDisabled() {

        XCTAssertEqual(sut.disabled.description, "Disabled")
    }

    func test_descriptionForContentSize() {

        XCTAssertEqual(sut.contentSize(.large).description, ContentSize.large.description)
    }
}
