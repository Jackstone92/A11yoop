//
//  FeatureMapped.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature
import A11yFeatureLive
import A11yStatusProvider

struct FeatureMapped<T, U> {
    let mapped: (T) -> U
}

extension FeatureMapped where T == A11yFeatureType, U == A11yFeature {

    static func asA11yFeature(using statusProvider: A11yStatusProvider, notificationCenter: NotificationCenter) -> Self {
        Self { featureType in .live(type: featureType, statusProvider: statusProvider, notificationCenter: notificationCenter) }
    }
}

extension Sequence where Element == A11yFeatureType {

    func map<T>(_ featureMapped: FeatureMapped<Element, T>) -> [T] {
        return self.map { featureMapped.mapped($0) }
    }
}
