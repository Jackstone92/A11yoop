//
//  HearingDevicePairedEar.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature

#if os(iOS)

    import UIKit

#else

    import Foundation

#endif

extension A11yFeature {

    private static let type: A11yFeatureType = .hearingDevicePairedEar

    public static var hearingDevicePairedEar: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return !UIAccessibility.hearingDevicePairedEar.isEmpty

        #else

            return false

        #endif
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {

        #if os(iOS) || os(tvOS)

            return NotificationCenter.default
                .publisher(for: UIAccessibility.hearingDevicePairedEarDidChangeNotification)
                .map { _ in (type, status) }
                .eraseToAnyPublisher()

        #else

            return Empty().eraseToAnyPublisher()

        #endif
    }
}
