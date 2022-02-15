//
//  Mock.swift
//  Created by Jack Stone in 2021.
//

import Foundation

extension A11yStatusProvider {

    /// A stubbed status provider instance that always returns `.enabled` when `getStatus(_:)` is invoked.
    static var enabled: Self {
        Self { _ in .enabled }
    }

    /// A stubbed status provider instance that always returns `.disabled` when `getStatus(_:)` is invoked.
    static var disabled: Self {
        Self { _ in .disabled }
    }
}
