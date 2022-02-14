//
//  Mapper.swift
//  Created by Jack Stone in 2021.
//

import Foundation
import A11yFeature
import A11yStatusProvider

/// Provides a generic way of mapping from one type to another.
struct Mapper<T, U> {
    let map: (T) -> U
}

extension Mapper where T == A11yFeatureType, U == A11yFeature {

    /// An adapter that converts a feature type into an accessibility feature representation whose current status has been derived.
    ///
    /// - Parameter statusProvider: The provider that derives the current accessibility feature status.
    ///
    /// - Returns: The accessibility feature representation.
    ///
    static func asA11yFeature(using statusProvider: A11yStatusProvider) -> Self {
        Self { featureType in
            let status = statusProvider.getStatus(featureType)

            return A11yFeature(type: featureType, status: status)
        }
    }
}

extension Sequence where Element == A11yFeatureType {

    /// A convenience transform method that converts a sequence of feature types into a sequence of accessibility feature representations (complete with up-to-date statuses).
    ///
    /// - Parameter mapper: The protocol witness to use in order to facilitate the transform.
    ///
    /// - Returns: The transformed sequence of accessibility feature representations.
    ///
    func map<T>(_ mapper: Mapper<Element, T>) -> [T] {
        return self.map { mapper.map($0) }
    }
}
