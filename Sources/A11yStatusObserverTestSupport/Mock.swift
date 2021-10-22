//
//  Mock.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import Combine
import A11yStatusObserver

extension A11yStatusObserver {

    public static var notInvoked: Self {
        Self { _, _, _ in
            XCTFail()
            return AnyCancellable({})
        }
    }

    public static var noop: Self {
        Self { _, _, _ in AnyCancellable({}) }
    }
}
