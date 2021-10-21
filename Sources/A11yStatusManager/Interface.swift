//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yCore
import A11yStatusEmitter
import A11yFeature

public struct A11yStatusManager {

    public let observeFeatures: (_ features: [A11yFeature], _ emitter: A11yStatusEmitter) -> Void
    public let isFeatureEnabled: (_ feature: A11yFeatureType) -> Bool

    public init(
        observeFeatures: @escaping (_ features: [A11yFeature], _ emitter: A11yStatusEmitter) -> Void,
        isFeatureEnabled: @escaping (_ feature: A11yFeatureType) -> Bool
    ) {
        self.observeFeatures = observeFeatures
        self.isFeatureEnabled = isFeatureEnabled
    }
}
