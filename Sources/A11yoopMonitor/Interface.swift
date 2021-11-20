//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yFeature

public class A11yoopMonitor {

    public let featuresSubject: CurrentValueSubject<[A11yFeature], Never>
    public let isFeatureEnabled: (_ feature: A11yFeatureType) -> Bool

    public required init(
        featuresSubject: CurrentValueSubject<[A11yFeature], Never>,
        isFeatureEnabled: @escaping (A11yFeatureType) -> Bool
    ) {
        self.featuresSubject = featuresSubject
        self.isFeatureEnabled = isFeatureEnabled
    }
}
