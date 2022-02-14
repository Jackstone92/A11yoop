//
//  Bool+AsA11yStatusAdapterTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import A11yFeature

final class Bool_AsA11yStatusAdapterTests: XCTestCase {

    func test_asA11yStatusWhenTrue() {

        let value = true

        XCTAssertEqual(value.asA11yStatus(), .enabled)
    }

    func test_asA11yStatusWhenFalse() {

        let value = false

        XCTAssertEqual(value.asA11yStatus(), .disabled)
    }
}
