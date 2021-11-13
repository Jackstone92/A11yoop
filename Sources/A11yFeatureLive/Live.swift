//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature
import A11yStatusProvider

extension A11yFeature {

    public static func live(
        type: A11yFeatureType,
        statusProvider: A11yStatusProvider,
        notificationCenter: NotificationCenter
    ) -> Self {
        Self(
            type: type,
            status: getStatus(for: type, using: statusProvider),
            observeChanges: { observeChanges(for: type, statusProvider: statusProvider, notificationCenter: notificationCenter) }
        )
    }

    private static func getStatus(for type: A11yFeatureType, using statusProvider: A11yStatusProvider) -> A11yStatus {
        statusProvider.getStatus(type)
    }

    private static func observeChanges(
        for type: A11yFeatureType,
        statusProvider: A11yStatusProvider,
        notificationCenter: NotificationCenter
    ) -> ObservationResult {
        SubscriptionFactory.make(
            with: notificationCenter,
            notificationName: type.notificationName,
            type: type,
            status: getStatus(for: type, using: statusProvider)
        )
    }
}
