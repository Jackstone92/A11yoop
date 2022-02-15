//
//  A11yStatus+IsEnabledTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import A11yoopMonitor

final class A11yStatus_IsEnabledTests: XCTestCase {

    func test_isEnabledWhenTrue() {

        let enabled: A11yStatus = .enabled

        XCTAssertTrue(enabled.isEnabled)
    }

    func test_isEnabledWhenContentSize() {

        let contentSize: A11yStatus = .contentSize(.medium)

        XCTAssertTrue(contentSize.isEnabled)
    }

    func test_isEnabledWhenFalse() {

        let disabled: A11yStatus = .disabled
        let notSupported: A11yStatus = .notSupported

        XCTAssertFalse(disabled.isEnabled)
        XCTAssertFalse(notSupported.isEnabled)
    }
}
