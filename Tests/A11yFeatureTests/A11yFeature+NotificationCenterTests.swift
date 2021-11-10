//
//  A11yFeature+NotificationCenterTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yFeature
@testable import A11yFeatureLive

final class A11yFeature_NotificationCenterTests: XCTestCase {

    func test_defaultInstance() {

        let sut = A11yFeature.notificationCenter

        XCTAssertIdentical(sut, NotificationCenter.default)
    }
}
