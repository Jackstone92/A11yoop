//
//  Mock.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yStatusEmitter

extension A11yStatusEmitter {

    /// A status emitter designed for testing purposes, which should never be invoked.
    /// If it is, it will result in an `XCTFail`.
    public static var notInvoked: Self {
        Self { _ in XCTFail() }
    }

    /// A stub status emitter designed for testing purposes.
    public static var noop: Self {
        Self { _ in }
    }
}
