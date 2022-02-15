//
//  Interface.swift
//  Created by Jack Stone in 2021.
//

import Foundation
import Combine

/// Monitors updates to accessibility features that are currently being observed and provides an interface to query the current status of a given accessibility feature.
struct A11yMonitor {

    /// A list of accessibility features that are currently being observed.
    let featuresSubject: CurrentValueSubject<[A11yFeature], Never>

    /// Provides the ability to query whether or not a particular accessibility feature is currently enabled or not, by its type.
    ///
    /// - Parameter featureType: The type of accessibility to query whether or not it is currently enabled.
    ///
    /// - Returns: A boolean value that indicates whether or not the accessibility feature is currently enabled.
    ///
    let isFeatureEnabled: (_ feature: A11yFeatureType) -> A11yStatus
}
