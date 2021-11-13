//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature

public class A11yoopMonitor {

    public let features: [A11yFeature]
    public let isFeatureEnabled: (_ feature: A11yFeatureType) -> Bool

    public required init(features: [A11yFeature], isFeatureEnabled: @escaping (A11yFeatureType) -> Bool) {
        self.features = features
        self.isFeatureEnabled = isFeatureEnabled
    }
}
