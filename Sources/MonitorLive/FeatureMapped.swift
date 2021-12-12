//
//  FeatureMapped.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature
import A11yStatusProvider

struct FeatureMapped<T, U> {
    let mapped: (T) -> U
}

extension FeatureMapped where T == A11yFeatureType, U == A11yFeature {

    static func asA11yFeature(using statusProvider: A11yStatusProvider) -> Self {
        Self { featureType in
            let status = statusProvider.getStatus(featureType)

            return A11yFeature(type: featureType, status: status)
        }
    }
}

extension Sequence where Element == A11yFeatureType {

    func map<T>(_ featureMapped: FeatureMapped<Element, T>) -> [T] {
        return self.map { featureMapped.mapped($0) }
    }
}
