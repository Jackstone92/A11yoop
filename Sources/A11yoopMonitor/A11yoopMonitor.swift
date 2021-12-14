//
//  A11yoopMonitor.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Monitor
import MonitorLive
import A11yFeature
import A11yStatusObserver
import A11yStatusEmitter
import A11yStatusProvider

/// Allows accessibility features that users have enabled on their iOS devices to be tracked as they are enabled and disabled.
public final class A11yoopMonitor {

    let _monitor: Monitor

    /// A list of accessibility features that are currently being monitored. These contain up-to-date statuses for each accessibility feature.
    public var features: [A11yFeature] { _monitor.featuresSubject.value }

    /// Initialises the `A11yoopMonitor` with a list of accessibility feature types to observe and a series of emitters that will process status changes to any observed accessibility feature.
    ///
    /// - Parameter featureTypes: The list of accessibility feature types to observe. If unspecified, all available feature types will be observed.
    /// - Parameter emitters: The list of emitters that will process status changes to any observed accessibility features. If unspecified, changes will be logged to the console.
    ///
    public init(
        featureTypes: [A11yFeatureType] = A11yFeatureType.allCases,
        emitters: [A11yStatusEmitter] = [.log()]
    ) {
        _monitor = .live(
            featureTypes: featureTypes,
            emitters: emitters,
            statusObserver: .live(),
            statusProvider: .live
        )
    }

    /// Queries whether or not a particular accessibility feature is currently enabled or not (specified by its type).
    ///
    /// - Parameter featureType: The type of accessibility to query whether or not it is currently enabled.
    ///
    /// - Returns: A boolean value that indicates whether or not the accessibility feature is currently enabled.
    ///
    public func isFeatureEnabled(_ featureType: A11yFeatureType) -> Bool {
        _monitor.isFeatureEnabled(featureType)
    }
}
