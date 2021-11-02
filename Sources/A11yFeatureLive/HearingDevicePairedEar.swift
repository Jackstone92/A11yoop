//
//  HearingDevicePairedEar.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature
import UIKit

extension A11yFeature {

    private static let type: A11yFeatureType = .hearingDevicePairedEar

    public static var hearingDevicePairedEar: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        !UIAccessibility.hearingDevicePairedEar.isEmpty
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {
        SubscriptionFactory.make(
            with: .default,
            notificationName: UIAccessibility.hearingDevicePairedEarDidChangeNotification,
            type: type,
            status: status
        )
    }
}
