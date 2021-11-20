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
        let feature = A11yFeature(type: type, status: .disabled)

        sut.insert(feature, type)

        let value = sut.get(type)

        XCTAssertEqual(value, feature)
    }

    func test_getWhenDoesNotExist() {

        XCTAssertNil(sut.get(.voiceOver))
    }

    // MARK: - getAll tests
    func test_getAllWhenPopulated() {

        let feature1 = A11yFeature(type: .voiceOver, status: .disabled)
        let feature2 = A11yFeature(type: .assistiveTouch, status: .disabled)
        let feature3 = A11yFeature(type: .boldText, status: .disabled)

        [feature1, feature2, feature3].forEach { sut.insert($0, $0.type) }

        let expectedSortedFeatures = [feature2, feature3, feature1]

        XCTAssertEqual(sut.getAll(), expectedSortedFeatures)
    }

    func test_getAllWhenValuesDoNotExist() {

        XCTAssertTrue(sut.getAll().isEmpty)
    }

    // MARK: - insert tests
    func test_insert() {

        let type: A11yFeatureType = .voiceOver
        let feature = A11yFeature(type: type, status: .disabled)

        sut.insert(feature, type)

        let value = sut.get(type)

        XCTAssertEqual(value, feature)
    }

    // MARK: - update tests
    func test_update() {

        let type: A11yFeatureType = .voiceOver
        let enabledFeature = A11yFeature(type: type, status: .enabled)

        sut.insert(enabledFeature, type)

        XCTAssertEqual(sut.get(type), enabledFeature)

        sut.update(.disabled, type)

        let expectedDisabledFeature = A11yFeature(type: type, status: .disabled)

        XCTAssertEqual(sut.get(type), expectedDisabledFeature)
    }

    // MARK: - remove tests
    func test_remove() throws {

        let type: A11yFeatureType = .voiceOver
        let feature = A11yFeature(type: type, status: .enabled)

        sut.insert(feature, type)

        XCTAssertNotNil(sut.remove(type))

        XCTAssertNil(sut.get(type))
    }

    func test_cannotRemoveWhenValueDoesNotExist() {

        XCTAssertNil(sut.remove(.voiceOver))
    }
}
