//
//  PreferCrossFadeTransitions.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature
import UIKit

extension A11yFeature {

    private static let type: A11yFeatureType = .preferCrossFadeTransitions

    public static var preferCrossFadeTransitions: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        guard #available(iOS 14.0, tvOS 14.0, *) else { return false }

        return UIAccessibility.prefersCrossFadeTransitions
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> A11yFeature.ObservationResult {
        guard #available(iOS 14.0, tvOS 14.0, *) else { return Empty().eraseToAnyPublisher() }

        return SubscriptionFactory.make(
            with: Self.notificationCenter,
            notificationName: UIAccessibility.prefersCrossFadeTransitionsStatusDidChange,
            type: type,
            status: status
        )
    }
}
