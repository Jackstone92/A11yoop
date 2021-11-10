//
//  VoiceOver.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature
import UIKit

extension A11yFeature {

    private static let type: A11yFeatureType = .voiceOver

    public static var voiceOver: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        UIAccessibility.isVoiceOverRunning
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> A11yFeature.ObservationResult {
        SubscriptionFactory.make(
            with: Self.notificationCenter,
            notificationName: UIAccessibility.voiceOverStatusDidChangeNotification,
            type: type,
            status: status
        )
    }
}
