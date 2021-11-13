//
//  A11StatusProvider+MockTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yStatusProvider
import A11yStatusProviderLive

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
