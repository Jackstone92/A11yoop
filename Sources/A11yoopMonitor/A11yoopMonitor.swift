//
//  A11yoopMonitor.swift
//  Created by Jack Stone in 2021.
//

import Foundation
import CombineSchedulers
import A11yMonitor
import A11yMonitorLive
import A11yFeature
import A11yStatusObserver
import A11yStatusEmitter
import A11yStatusProvider

/// Allows accessibility features that users have enabled on their iOS devices to be tracked as they are enabled and disabled.
public struct A11yoopMonitor {

    /// A list of all accessibility features that are currently being monitored. These contain up-to-date statuses for each accessibility feature.
    public var allFeatures: [A11yFeature] { _monitor.featuresSubject.value }

    /// A list of accessibility features that are currently being monitored that are considered to be enabled. These contain up-to-date statuses for each accessibility feature.
    public var enabledFeatures: [A11yFeature] { allFeatures.filter(\.status.isEnabled) }

    /// A list of accessibility features that are currently being monitored that are considered to be disabled. These contain up-to-date statuses for each accessibility feature.
    public var disabledFeatures: [A11yFeature] { allFeatures.filter(\.status.isDisabled) }

    /// A list of accessibility features that are currently being monitored that are considered not to be supported. These contain up-to-date statuses for each accessibility feature.
    public var unsupportedFeatures: [A11yFeature] { allFeatures.filter(\.status.isNotSupported) }

    /// The internal underlying monitor instance.
    let _monitor: A11yMonitor

    /// Initialises the `A11yoopMonitor` with a list of accessibility feature types to observe and a series of emitters that will process status changes to any observed accessibility feature.
    ///
    /// - Parameter featureTypes: The list of accessibility feature types to observe. If unspecified, all available feature types will be observed.
    /// - Parameter emitters: The list of emitters that will process status changes to any observed accessibility features. If unspecified, changes will be logged to the console.
    /// - Parameter queue: The queue on which any accessibility feature status changes will be observed.
    ///
    public init(
        featureTypes: [A11yFeatureType] = A11yFeatureType.allCases,
        emitters: [A11yStatusEmitter] = [.log()],
        queue: AnySchedulerOf<DispatchQueue> = .main
    ) {
        self.init(
            monitor: .live(
                featureTypes: featureTypes,
                emitters: emitters,
                statusObserver: .live(queue: queue),
                statusProvider: .live
            )
        )
    }

    /// Internal initialiser that ensures the underlying monitor instance is configured correctly.
    init(monitor: A11yMonitor) {
        _monitor = monitor
    }

    /// Queries whether or not a particular accessibility feature is currently enabled or not (specified by its type).
    ///
    /// - Parameter featureType: The type of accessibility to query whether or not it is currently enabled.
    ///
    /// - Returns: A boolean value that indicates whether or not the accessibility feature is currently enabled.
    ///
    public func isFeatureEnabled(_ featureType: A11yFeatureType) -> A11yStatus {
        _monitor.isFeatureEnabled(featureType)
    }
}
