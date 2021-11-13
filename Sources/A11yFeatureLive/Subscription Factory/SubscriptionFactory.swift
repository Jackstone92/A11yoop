//
//  SubscriptionFactory.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yFeature

struct SubscriptionFactory {

    static func make(
        with notificationCenter: NotificationCenter,
        notificationName: NSNotification.Name,
        type: A11yFeatureType,
        status: A11yStatus
    ) -> A11yFeature.ObservationResult {

        notificationCenter
            .publisher(for: notificationName)
            .map { _ in A11yFeatureObservation(type: type, status: status) }
            .eraseToAnyPublisher()
    }
}
