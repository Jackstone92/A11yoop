//
//  FeatureMapped.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature
import A11yFeatureLive

struct FeatureMapped<T, U> {
    let mapped: (T) -> U
}

extension FeatureMapped where T == A11yFeatureType, U == A11yFeature {

    static var asA11yFeature: Self {
        Self { featureType in
            switch featureType {
            case .voiceOver: return .voiceOver
            case .boldText:  return .boldText
            case .largerText: return .largerText
            case .switchControl: return .switchControl
            case .greyscale: return .greyscale
            case .invertColors: return .invertColours
            case .increaseContrast: return .increaseContrast
            }
        }
    }
}

extension Sequence where Element == A11yFeatureType {

    func map<T>(_ featureMapped: FeatureMapped<Element, T>) -> [T] {
        return self.map { featureMapped.mapped($0) }
    }
}
