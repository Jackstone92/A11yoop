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
    func test_getWhenExists() async {

        let type: A11yFeatureType = .voiceOver
        let feature = A11yFeature(type: type, status: .disabled)

        await sut.insert(feature, type)

        let value = await sut.get(type)

        XCTAssertEqual(value, feature)
    }

    func test_getWhenDoesNotExist() async {

        let feature = await sut.get(.voiceOver)
        XCTAssertNil(feature)
    }

    // MARK: - getAll tests
    func test_getAllWhenPopulated() async {

        let feature1 = A11yFeature(type: .voiceOver, status: .disabled)
        let feature2 = A11yFeature(type: .assistiveTouch, status: .disabled)
        let feature3 = A11yFeature(type: .boldText, status: .disabled)

        [feature1, feature2, feature3].forEach { feature in
            Task { await sut.insert(feature, feature.type) }
        }

        let expectedSortedFeatures = [feature2, feature3, feature1]

        let allFeatures = await sut.getAll()
        XCTAssertEqual(allFeatures, expectedSortedFeatures)
    }

    func test_getAllWhenValuesDoNotExist() async {

        let allFeatures = await sut.getAll()
        XCTAssertTrue(allFeatures.isEmpty)
    }

    // MARK: - insert tests
    func test_insert() async {

        let type: A11yFeatureType = .voiceOver
        let feature = A11yFeature(type: type, status: .disabled)

        await sut.insert(feature, type)

        let value = await sut.get(type)

        XCTAssertEqual(value, feature)
    }

    // MARK: - update tests
    func test_update() async {

        let type: A11yFeatureType = .voiceOver
        let enabledFeature = A11yFeature(type: type, status: .enabled)

        await sut.insert(enabledFeature, type)

        let feature = await sut.get(type)
        XCTAssertEqual(feature, enabledFeature)

        await sut.update(.disabled, type)

        let expectedDisabledFeature = A11yFeature(type: type, status: .disabled)

        let updatedFeature = await sut.get(type)
        XCTAssertEqual(updatedFeature, expectedDisabledFeature)
    }

    // MARK: - remove tests
    func test_remove() async {

        let type: A11yFeatureType = .voiceOver
        let feature = A11yFeature(type: type, status: .enabled)

        await sut.insert(feature, type)

        let removedFeature = await sut.remove(type)
        XCTAssertNotNil(removedFeature)

        let attemptedFeature = await sut.get(type)
        XCTAssertNil(attemptedFeature)
    }

    func test_cannotRemoveWhenValueDoesNotExist() async {

        let removedFeature = await sut.remove(.voiceOver)
        XCTAssertNil(removedFeature)
    }
}
