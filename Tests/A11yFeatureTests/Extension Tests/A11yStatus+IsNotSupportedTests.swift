//
//  A11yStatus+NotSupportedTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import A11yFeature

final class A11yStatus_IsNotSupportedTests: XCTestCase {

    func test_notSupportedWhenTrue() {

        let notSupported: A11yStatus = .notSupported

        XCTAssertTrue(notSupported.isNotSupported)
    }

    func test_notSupportedWhenFalse() {

        let enabled: A11yStatus = .enabled
        let contentSize: A11yStatus = .contentSize(.medium)
        let disabled: A11yStatus = .disabled

        XCTAssertFalse(enabled.isNotSupported)
        XCTAssertFalse(contentSize.isNotSupported)
        XCTAssertFalse(disabled.isNotSupported)
    }
}
