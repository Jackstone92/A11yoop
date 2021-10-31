//
//  A11yStatus.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public enum A11yStatus: Equatable {
    case enabled
    case disabled
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
