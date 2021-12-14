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

public final class A11yoopMonitor {

    let _monitor: Monitor

    public var features: [A11yFeature] { _monitor.featuresSubject.value }

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

    public func isFeatureEnabled(_ featureType: A11yFeatureType) -> Bool {
        _monitor.isFeatureEnabled(featureType)
    }
}
