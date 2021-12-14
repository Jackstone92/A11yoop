//
//  A11yFeature+AsAnalyticsParams.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension Sequence where Element == A11yFeature {

    /// An adapter that returns a dictionary representation of accessibility features in a format commonly supported by analytics SDK APIs.
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
