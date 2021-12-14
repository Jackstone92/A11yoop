//
//  Mock.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature

extension A11yStatusProvider {

    /// A stubbed status provider instance that always returns `.enabled` when `getStatus(_:)` is invoked.
    public static var enabled: Self {
        Self { _ in .enabled }
    }

    /// A stubbed status provider instance that always returns `.disabled` when `getStatus(_:)` is invoked.
    public static var disabled: Self {
        Self { _ in .disabled }
    }
}
