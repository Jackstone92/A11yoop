//
//  A11yStatus+isNotSupported.swift
//  Created by Jack Stone in 2021.
//

import Foundation

extension A11yStatus {

    /// Whether or not the accessibility feature is considered to be not supported.
    public var isNotSupported: Bool {
        guard case .notSupported = self else { return false }
        return true
    }
}
