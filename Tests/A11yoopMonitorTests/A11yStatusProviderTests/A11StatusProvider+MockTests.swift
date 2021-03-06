//
//  A11StatusProvider+MockTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
@testable import A11yoopMonitor

final class A11StatusProvider_MockTests: XCTestCase {

    func test_enabledMockReturnsEnabled() {

        let sut: A11yStatusProvider = .enabled

        XCTAssertEqual(sut.getStatus(.assistiveTouch), .enabled)
    }

    func test_disabledMockReturnsDisabled() {

        let sut: A11yStatusProvider = .disabled

        XCTAssertEqual(sut.getStatus(.assistiveTouch), .disabled)
    }
}
