//
//  A11yStatus+IsDisabled.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension A11yStatus {

    /// Whether or not the accessibility feature is considered to be disabled.
    public var isDisabled: Bool {
        guard case .disabled = self else { return false }
        return true
    }
}
