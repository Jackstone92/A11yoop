//
//  A11yStatus+isNotSupported.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension A11yStatus {

    /// Whether or not the accessibility feature is considered to be not supported.
    public var isNotSupported: Bool {
        guard case .notSupported = self else { return false }
        return true
    }
}
