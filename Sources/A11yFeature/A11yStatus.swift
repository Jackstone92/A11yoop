//
//  A11yStatus.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

/// The status of a particular accessibility feature.
public enum A11yStatus: Equatable {

    /// The accessibility feature is enabled.
    case enabled

    /// The accessibility feature is disabled.
    case disabled

    /// The accessibility feature is enabled, using a particular content size.
    case contentSize(ContentSize)
}

extension A11yStatus: CustomStringConvertible {

    public var description: String {
        switch self {
        case .enabled:  return "Enabled"
        case .disabled: return "Disabled"
        case .contentSize(let size): return size.description
        }
    }
}
