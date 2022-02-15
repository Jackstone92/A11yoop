//
//  A11yStatus+IsEnabled.swift
//  Created by Jack Stone in 2021.
//

import Foundation

extension A11yStatus {

    /// Whether or not the accessibility feature is considered to be enabled.
    public var isEnabled: Bool {
        if case .enabled = self {
            return true
        }

        if case .contentSize = self {
            return true
        }

        return false
    }
}
