//
//  A11yStatus+DescriptionTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import A11yoopMonitor

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

    func test_descriptionForNotSupported() {

        XCTAssertEqual(sut.notSupported.description, "Not Supported")
    }

    func test_descriptionForNotMonitored() {

        XCTAssertEqual(sut.notMonitored.description, "Not Monitored")
    }
}
