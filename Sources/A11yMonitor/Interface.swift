//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yFeature

/// Monitors updates to accessibility features that are currently being observed and provides an interface to query the current status of a given accessibility feature.
public struct A11yMonitor {

    /// A list of accessibility features that are currently being observed.
    public let featuresSubject: CurrentValueSubject<[A11yFeature], Never>

    /// Provides the ability to query whether or not a particular accessibility feature is currently enabled or not, by its type.
    ///
    /// - Parameter featureType: The type of accessibility to query whether or not it is currently enabled.
    ///
    /// - Returns: A boolean value that indicates whether or not the accessibility feature is currently enabled.
    ///
    public let isFeatureEnabled: (_ feature: A11yFeatureType) -> A11yStatus

    public init(
        featuresSubject: CurrentValueSubject<[A11yFeature], Never>,
        isFeatureEnabled: @escaping (A11yFeatureType) -> A11yStatus
    ) {
        self.featuresSubject = featuresSubject
        self.isFeatureEnabled = isFeatureEnabled
    }
}
