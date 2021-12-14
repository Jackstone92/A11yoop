//
//  Mock.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yStoreLive

extension FeatureStore {

    /// An accessibility feature store designed for testing purposes, which should never be invoked.
    /// If it is, it will result in an `XCTFail`.
    public static var notInvoked: Self {
        Self(
            get: { _ in XCTFail(); return nil },
            getAll: { XCTFail(); return [] },
            insert: { _, _ in XCTFail() },
            update: { _, _ in XCTFail() },
            remove: { _ in XCTFail(); return nil }
        )
    }

    /// A stub accessibility feature store designed for testing purposes.
    public static var noop: Self {
        Self(
            get: { _ in return nil },
            getAll: { return [] },
            insert: { _, _ in },
            update: { _, _ in },
            remove: { _ in return nil }
        )
    }
}
