//
//  A11yStoreTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yCore
import A11yStore
import A11yStoreLive

final class A11yStoreTests: XCTestCase {

    private var sut: FeatureStore!

    override func setUp() {
        super.setUp()
        sut = .live
    }

    // MARK: - get tests
    func test_getWhenExists() throws {

        let type: A11yFeatureType = .voiceOver
        let status: A11yStatus = .disabled

        try sut.insert(status, type)

        let value = sut.get(type)

        XCTAssertEqual(value, status)
    }

    func test_getWhenDoesNotExist() {

        XCTAssertNil(sut.get(.voiceOver))
    }

    // MARK: - insert tests
    func test_insert() throws {

        let type: A11yFeatureType = .voiceOver
        let status: A11yStatus = .disabled

        try sut.insert(status, type)

        let value = sut.get(type)

        XCTAssertEqual(value, status)
    }

    func test_cannotInsertIfValueAlreadyExistsForKey() throws {

        let type: A11yFeatureType = .voiceOver
        let status: A11yStatus = .disabled

        try sut.insert(status, type)

        let value = sut.get(type)

        XCTAssertEqual(value, status)

        XCTAssertThrowsError(try sut.insert(.enabled, type))
    }

    // MARK: - update tests
    func test_update() throws {

        try sut.insert(.enabled, .voiceOver)

        XCTAssertEqual(sut.get(.voiceOver), .enabled)

        try sut.update(.disabled, .voiceOver)

        XCTAssertEqual(sut.get(.voiceOver), .disabled)
    }

    func test_cannotUpdateIfValueDoesNotAlreadyExistForKey() {

        XCTAssertNil(sut.get(.voiceOver))

        XCTAssertThrowsError(try sut.update(.enabled, .voiceOver))
    }

    // MARK: - remove tests
    func test_remove() throws {

        try sut.insert(.enabled, .voiceOver)

        XCTAssertEqual(sut.get(.voiceOver), .enabled)

        try sut.remove(.voiceOver)

        XCTAssertNil(sut.get(.voiceOver))
    }

    func test_cannotRemoveWhenValueDoesNotExist() {

        XCTAssertThrowsError(try sut.remove(.voiceOver))
    }
}
