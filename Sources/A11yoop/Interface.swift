//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature

public struct A11yoop {

    public let isFeatureEnabled: (_ feature: A11yFeatureType) -> Bool

    public init(isFeatureEnabled: @escaping (A11yFeatureType) -> Bool) {
        self.isFeatureEnabled = isFeatureEnabled
    }
}
