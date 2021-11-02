//
//  ButtonShapes.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature
import UIKit

extension A11yFeature {

    private static let type: A11yFeatureType = .buttonShapes

    public static var buttonShapes: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        guard #available(iOS 14.0, *) else { return false }
        return UIAccessibility.buttonShapesEnabled
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {
        guard #available(iOS 14.0, *) else { return Empty().eraseToAnyPublisher() }

        return SubscriptionFactory.make(
            with: .default,
            notificationName: UIAccessibility.buttonShapesEnabledStatusDidChangeNotification,
            type: type,
            status: status
        )
    }
}
