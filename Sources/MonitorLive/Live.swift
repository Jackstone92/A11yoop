//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import Monitor
import A11yStatusEmitter
import A11yStatusEmitterLive
import A11yStatusObserver
import A11yStatusObserverLive
import A11yStatusProvider
import A11yStatusProviderLive
import A11yFeature

extension Monitor {

    public static func live(
        featureTypes: [A11yFeatureType] = A11yFeatureType.allCases,
        statusManager: A11yStatusObserver = .live(),
        emitters: [A11yStatusEmitter] = [.log()],
        statusProvider: A11yStatusProvider = .live
    ) -> Self {

        let features = featureTypes.map(.asA11yFeature(using: statusProvider))
        let featuresSubject = CurrentValueSubject<[A11yFeature], Never>(features)
        statusManager.observeFeatures(features, emitters)

        return Self(
            featuresSubject: featuresSubject,
            isFeatureEnabled: { featureType in
                statusManager.isFeatureEnabled(featureType)
            }
        )
    }
}
