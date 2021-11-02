//
//  A11yStoreTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yFeature
import A11yStore
import A11yStoreLive

final class A11yStoreTests: XCTestCase {

    private var sut: FeatureStore!

    override func setUp() {
        super.setUp()
        sut = .live
    }

    // MARK: - get tests
    func test_getWhenExists() {

        let type: A11yFeatureType = .voiceOver
        let status: A11yStatus = .disabled

        sut.insert(status, type)

        let value = sut.get(type)

        XCTAssertEqual(value, status)
    }

    func test_getWhenDoesNotExist() {

        XCTAssertNil(sut.get(.voiceOver))
    }

    // MARK: - insert tests
    func test_insert() {

        let type: A11yFeatureType = .voiceOver
        let status: A11yStatus = .disabled

        sut.insert(status, type)

        let value = sut.get(type)

        XCTAssertEqual(value, status)
    }

    // MARK: - update tests
    func test_update() {

        sut.insert(.enabled, .voiceOver)

        XCTAssertEqual(sut.get(.voiceOver), .enabled)

        sut.update(.disabled, .voiceOver)

        XCTAssertEqual(sut.get(.voiceOver), .disabled)
    }

    // MARK: - remove tests
    func test_remove() throws {

        sut.insert(.enabled, .voiceOver)

        XCTAssertEqual(sut.get(.voiceOver), .enabled)

        XCTAssertNotNil(sut.remove(.voiceOver))

        XCTAssertNil(sut.get(.voiceOver))
    }

    func test_cannotRemoveWhenValueDoesNotExist() {

        XCTAssertNil(sut.remove(.voiceOver))
    }
}
