//
//  Interface.swift
//  Created by Jack Stone in 2021.
//

import Foundation
import Combine

/// Handles how accessibility feature status changes are observed.
struct A11yStatusObserver {

    /// Sets up the mechanism for observing a list of accessibility features and notifying the relevant emitters whenever any of the features' statuses change.
    ///
    /// - Parameter features: The list of accessibility features to observe.
    /// - Parameter emitters: The list of emitters to notify when any of the features' statuses change.
    ///
    let observeFeatures: (_ features: [A11yFeature], _ emitters: [A11yStatusEmitter]) -> Void

    /// Provides the ability to query whether or not a particular accessibility feature is currently enabled or not, by its type.
    ///
    /// - Parameter featureType: The type of accessibility to query whether or not it is currently enabled.
    ///
    /// - Returns: A boolean value that indicates whether or not the accessibility feature is currently enabled.
    ///
    let isFeatureEnabled: (_ featureType: A11yFeatureType) -> A11yStatus
}
