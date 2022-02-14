//
//  Interface.swift
//  Created by Jack Stone in 2021.
//

import Foundation
import A11yFeature

/// Provides the current status of a given accessibility feature.
public class A11yStatusProvider {

    /// Returns the current status for a given accessibility feature, identified by its type.
    ///
    /// - Parameter type: The type of accessibility feature, whose current status should be determined.
    ///
    /// - Returns: The current status for the specified accessibility feature.
    ///
    public let getStatus: (_ type: A11yFeatureType) -> A11yStatus

    public required init(getStatus: @escaping (A11yFeatureType) -> A11yStatus) {
        self.getStatus = getStatus
    }
}
