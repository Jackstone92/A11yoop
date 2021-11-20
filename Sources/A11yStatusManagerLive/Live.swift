//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yStatusManager
import A11yStatusEmitter
import A11yStore
import A11yStoreLive
import A11yStatusProvider
import A11yStatusProviderLive
import A11yFeature

extension A11yStatusManager {

    public static func live(
        featureStore: FeatureStore = .live,
        statusProvider: A11yStatusProvider = .live,
        notificationCenter: NotificationCenter = .default
    ) -> Self {

        var subscriptions = Set<AnyCancellable>()

        return Self(
            observeFeatures: { features, emitters in
                features.forEach { featureStore.insert($0, $0.type) }

                subscribe(
                    to: features,
                    featureStore: featureStore,
                    statusProvider: statusProvider,
                    notificationCenter: notificationCenter,
                    emitters: emitters,
                    subscriptions: &subscriptions
                )
            },
            isFeatureEnabled: { featureType in
                guard let feature = featureStore.get(featureType) else {
                    return false
                }

                return feature.status == .enabled
            }
        )
    }

    private static func subscribe(
        to features: [A11yFeature],
        featureStore: FeatureStore,
        statusProvider: A11yStatusProvider,
        notificationCenter: NotificationCenter,
        emitters: [A11yStatusEmitter],
        subscriptions: inout Set<AnyCancellable>
    ) {
        features
            .map { ($0, notificationCenter.publisher(for: $0.type.notificationName, object: nil)) }
            .forEach { feature, publisher in
                publisher.sink { _ in
                    let updatedStatus = statusProvider.getStatus(feature.type)
                    featureStore.update(updatedStatus, feature.type)

                    guard let feature = featureStore.get(feature.type) else { return }

                    emitters.forEach { $0.emit(feature) }
                }
                .store(in: &subscriptions)
            }
    }
}
