//
//  Bool+AsA11yStatus.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature

extension Bool {

    public func asA11yStatus() -> A11yStatus {
        switch self {
        case true:  return .enabled
        case false: return .disabled
        }
    }
}
