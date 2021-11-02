//
//  Mock.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yStoreLive

extension FeatureStore {

    public static var notInvoked: Self {
        Self(
            get: { _ in XCTFail(); return nil },
            insert: { _, _ in XCTFail() },
            update: { _, _ in XCTFail() },
            remove: { _ in XCTFail(); return nil }
        )
    }

    public static var noop: Self {
        Self(
            get: { _ in return nil },
            insert: { _, _ in },
            update: { _, _ in },
            remove: { _ in return nil }
        )
    }
}
