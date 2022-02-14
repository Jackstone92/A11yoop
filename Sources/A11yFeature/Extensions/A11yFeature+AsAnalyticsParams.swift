//
//  A11yFeature+AsAnalyticsParams.swift
//  Created by Jack Stone in 2021.
//

import Foundation

extension Sequence where Element == A11yFeature {

    /// An adapter that returns a dictionary representation of accessibility features in a format commonly supported by analytics SDK APIs.
    ///
    /// - Parameter prefix: An optional prefix to apply to every param key that is outputted in order to prevent name collisions.
    ///
    /// - Returns: The dictionary representation.
    ///
    public func asAnalyticsParams(prefixedBy prefix: String? = nil) -> [String: Any] {
        reduce(into: [String: Any]()) { $0[formatKey(using: $1, prefixedBy: prefix)] = $1.status.description }
    }

    private func formatKey(using feature: A11yFeature, prefixedBy prefix: String?) -> String {
        guard let prefix = prefix else {
            return feature.type.description
        }

        return [prefix, feature.type.description].joined(separator: " ")
    }
}
