//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yoopMonitor
import A11yStatusEmitter
import A11yStatusEmitterLive
import A11yStatusManager
import A11yStatusManagerLive
import A11yStatusProvider
import A11yStatusProviderLive
import A11yFeature

extension A11yoopMonitor {

    public static func live(
        featureTypes: [A11yFeatureType] = A11yFeatureType.allCases,
        statusManager: A11yStatusManager = .live(),
        emitter: A11yStatusEmitter = .log(),
        statusProvider: A11yStatusProvider = .live,
        notificationCenter: NotificationCenter = .default
    ) -> Self {

        let features = featureTypes.map(.asA11yFeature(using: statusProvider, notificationCenter: notificationCenter))
        statusManager.observeFeatures(features, emitter)

        return Self(
            features: features,
            isFeatureEnabled: { featureType in
                statusManager.isFeatureEnabled(featureType)
            }
        )
    }
}
