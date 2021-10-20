//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yCore
import A11yStatusManager
import A11yStatusEmitter
import A11yStatusObserver
import A11yStatusObserverLive
import A11yStore
import A11yStoreLive

extension A11yStatusManager {

    public static func live(
        observer: A11yStatusObserver = .live,
        featureStore: FeatureStore = .live
    ) -> Self {

        var subscriptions = Set<AnyCancellable>()

        return Self(
            observeFeatures: { features, emitter in
                features.forEach { featureStore.insert($0.status, $0.type) }

                subscribe(
                    to: features,
                    using: observer,
                    featureStore: featureStore,
                    emitter: emitter,
                    subscriptions: &subscriptions
                )
            },
            isFeatureEnabled: { featureType in
                guard let status = featureStore.get(featureType) else {
                    return false
                }

                return status == .enabled
            }
        )
    }

    private static func subscribe(
        to features: [A11yFeature],
        using observer: A11yStatusObserver,
        featureStore: FeatureStore,
        emitter: A11yStatusEmitter,
        subscriptions: inout Set<AnyCancellable>
    ) {
        features.forEach {
            subscribe(
                to: $0,
                using: observer,
                featureStore: featureStore,
                emitter: emitter,
                subscriptions: &subscriptions
            )
        }
    }

    private static func subscribe(
        to feature: A11yFeature,
        using observer: A11yStatusObserver,
        featureStore: FeatureStore,
        emitter: A11yStatusEmitter,
        subscriptions: inout Set<AnyCancellable>
    ) {
        observer.observeChanges(feature, featureStore, emitter)
            .store(in: &subscriptions)
    }
}
