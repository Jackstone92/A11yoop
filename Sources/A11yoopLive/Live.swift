//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yCore
import A11yoop
import A11yStatusEmitter
import A11yStatusEmitterLive
import A11yStatusManager
import A11yStatusManagerLive
import A11yFeature

extension A11yoop {

    public static func live(
        featureTypes: [A11yFeatureType] = A11yFeatureType.allCases,
        statusManager: A11yStatusManager = .live(),
        emitter: A11yStatusEmitter = .log
    ) -> Self {

        let features = featureTypes.map(.asA11yFeature)
        statusManager.observeFeatures(features, emitter)

        return Self(
            isFeatureEnabled: { featureType in
                statusManager.isFeatureEnabled(featureType)
            }
        )
    }
}
