//
//  SubscriptionFactory.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yFeature

struct SubscriptionFactory {

    static func make(
        with notificationCenter: NotificationCenter = .default,
        notificationName: NSNotification.Name,
        type: A11yFeatureType,
        status: A11yStatus
    ) -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {

        notificationCenter
            .publisher(for: notificationName)
            .map { _ in (type, status) }
            .eraseToAnyPublisher()
    }
}
