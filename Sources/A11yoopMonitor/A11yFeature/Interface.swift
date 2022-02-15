//
//  Interface.swift
//  Created by Jack Stone in 2021.
//

import Foundation
import Combine

/// A accessibility feature representation.
public struct A11yFeature: Identifiable {

    public let id = UUID()

    /// The type of accessibility feature.
    public let type: A11yFeatureType

    /// The current status of the accessibility feature.
    public var status: A11yStatus

    /// Instantiates a representation of an accessibility feature, specified by a type and an initial status.
    ///
    /// - Parameter type: The type of accessibility feature.
    /// - Parameter status: The initial status of the accessibility feature. This can then be subsequently updated.
    ///
    public init(type: A11yFeatureType, status: A11yStatus) {
        self.type = type
        self.status = status
    }
}

extension A11yFeature: Equatable {

    // Ignore `id` property and derive equatability by type and status only.
    public static func == (lhs: A11yFeature, rhs: A11yFeature) -> Bool {
        lhs.type == rhs.type && lhs.status == rhs.status
    }
}
