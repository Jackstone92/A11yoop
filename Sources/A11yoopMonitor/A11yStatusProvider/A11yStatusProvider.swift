//
//  Interface.swift
//  Created by Jack Stone in 2021.
//

import Foundation

/// Provides the current status of a given accessibility feature.
struct A11yStatusProvider {

    /// Returns the current status for a given accessibility feature, identified by its type.
    ///
    /// - Parameter type: The type of accessibility feature, whose current status should be determined.
    ///
    /// - Returns: The current status for the specified accessibility feature.
    ///
    let getStatus: (_ type: A11yFeatureType) -> A11yStatus
}
