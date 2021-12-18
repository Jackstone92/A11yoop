//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yMonitor
import A11yStatusEmitter
import A11yStatusEmitterLive
import A11yStatusObserver
import A11yStatusObserverLive
import A11yStatusProvider
import A11yStatusProviderLive
import A11yFeature

extension A11yMonitor {

    /// The live monitor instance that allows for accessibility features to be monitored.
    ///
    /// - Parameter featureTypes: The list of accessibility features whose status should be observed, identified by feature type.
    ///
    /// - Parameter emitters: The list of emitters to notify when any of the features' statuses change.
    ///
    /// - Parameter statusObserver: The status observer instance that handles the observation of accessibility feature status changes.
    ///
    /// - Parameter statusProvider: The status provider instance that handles that derives current statuses for accessibility features.
    ///
    /// - Returns: The live monitor instance.
    ///
    public static func live(
        featureTypes: [A11yFeatureType] = A11yFeatureType.allCases,
        emitters: [A11yStatusEmitter] = [.log()],
        statusObserver: A11yStatusObserver = .live(),
        statusProvider: A11yStatusProvider = .live
    ) -> Self {

        let features = featureTypes.map(.asA11yFeature(using: statusProvider))
        let featuresSubject = CurrentValueSubject<[A11yFeature], Never>(features)
        statusObserver.observeFeatures(features, emitters)

        return Self(
            featuresSubject: featuresSubject,
            isFeatureEnabled: { featureType in
                await statusObserver.isFeatureEnabled(featureType)
            }
        )
    }
}
