//
//  Bool+AsA11yStatus.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension Bool {

    /// An adapter that converts a boolean value to an `A11yStatus` that is either `enabled` or `disabled`.
    public func asA11yStatus() -> A11yStatus {
        switch self {
        case true:  return .enabled
        case false: return .disabled
        }
    }
}
