//
//  BoldText.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature
import UIKit

extension A11yFeature {

    private static let type: A11yFeatureType = .boldText

    public static var boldText: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        UIAccessibility.isBoldTextEnabled
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {
        NotificationCenter.default
            .publisher(for: UIAccessibility.boldTextStatusDidChangeNotification)
            .map { _ in (type, status) }
            .eraseToAnyPublisher()
    }
}
