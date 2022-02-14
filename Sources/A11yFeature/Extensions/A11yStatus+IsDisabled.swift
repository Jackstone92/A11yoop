//
//  A11yStatus+IsDisabled.swift
//  Created by Jack Stone in 2021.
//

import Foundation

extension A11yStatus {

    /// Whether or not the accessibility feature is considered to be disabled.
    public var isDisabled: Bool {
        guard case .disabled = self else { return false }
        return true
    }
}
