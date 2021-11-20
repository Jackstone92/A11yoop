//
//  Mock.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yStatusEmitter

extension A11yStatusEmitter {

    public static var notInvoked: Self {
        Self { _ in XCTFail() }
    }

    public static var noop: Self {
        Self { _ in }
    }
}
