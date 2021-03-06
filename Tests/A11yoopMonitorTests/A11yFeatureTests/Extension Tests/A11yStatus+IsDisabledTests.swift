//
//  A11yStatus+IsDisabledTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import A11yoopMonitor

final class A11yStatus_IsDisabledTests: XCTestCase {

    func test_isDisabledWhenTrue() {

        let disabled: A11yStatus = .disabled

        XCTAssertTrue(disabled.isDisabled)
    }

    func test_isDisabledWhenFalse() {

        let enabled: A11yStatus = .enabled
        let contentSize: A11yStatus = .contentSize(.medium)
        let notSupported: A11yStatus = .notSupported

        XCTAssertFalse(enabled.isDisabled)
        XCTAssertFalse(contentSize.isDisabled)
        XCTAssertFalse(notSupported.isDisabled)
    }
}
