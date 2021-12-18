//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import CombineSchedulers
import A11yStatusObserver
import A11yStatusEmitter
import A11yStore
import A11yStoreLive
import A11yStatusProvider
import A11yStatusProviderLive
import A11yFeature

extension A11yStatusObserver {

    /// The live status observer implementation that allows for accessibility feature status changes to be observed.
    ///
    /// - Parameter featureStore: The backing in-memory storage solution, which maintains the up-to-date list of
    ///                           observed accessibility features and their current statuses.
    ///
    /// - Parameter statusProvider: The provider that derives the current accessibility feature status.
    ///
    /// - Parameter notificationCenter: The notification centre instance to use in order to observe accessibility
    ///                                 feature status changes.
    ///
    /// - Parameter queue: The queue on which the emitters will process any accessibility feature status changes.
    ///
    /// - Returns: The live status observer instance.
    ///
    public static func live(
        featureStore: FeatureStore = .live,
        statusProvider: A11yStatusProvider = .live,
        notificationCenter: NotificationCenter = .default,
        queue: AnySchedulerOf<DispatchQueue> = .main
    ) -> Self {

        var subscriptions = Set<AnyCancellable>()

        return Self(
            observeFeatures: { features, emitters in
                features.forEach { feature in
                    Task {
                        await featureStore.insert(feature, feature.type)
                    }
                }

                subscribe(
                    to: features,
                    featureStore: featureStore,
                    statusProvider: statusProvider,
                    notificationCenter: notificationCenter,
                    emitters: emitters,
                    queue: queue,
                    subscriptions: &subscriptions
                )
            },
            isFeatureEnabled: { featureType in
                guard let feature = await featureStore.get(featureType) else {
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
        queue: AnySchedulerOf<DispatchQueue>,
        subscriptions: inout Set<AnyCancellable>
    ) {
        features
            .map { ($0, notificationCenter.publisher(for: $0.type.notificationName, object: nil)) }
            .forEach { feature, publisher in

                publisher
                    .receive(on: queue)
                    .sink { _ in
                        Task {
                            await updateFeatureStatus(of: feature, featureStore: featureStore, statusProvider: statusProvider, emitters: emitters)
                        }
                    }
                    .store(in: &subscriptions)
            }
    }

    private static func updateFeatureStatus(
        of feature: A11yFeature,
        featureStore: FeatureStore,
        statusProvider: A11yStatusProvider,
        emitters: [A11yStatusEmitter]
    ) async {

        let updatedStatus = statusProvider.getStatus(feature.type)

        await featureStore.update(updatedStatus, feature.type)

        guard let feature = await featureStore.get(feature.type) else { return }

        emitters.forEach { $0.emit(feature) }
    }
}
