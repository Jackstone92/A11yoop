//
//  IncreaseContrast.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature

#if os(OSX)

    import AppKit

#else

    import Foundation

#endif

extension A11yFeature {

    private static let type: A11yFeatureType = .increaseContrast

    public static var increaseContrast: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        #if os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldIncreaseContrast

        #else

            return false

        #endif
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {

        #if os(OSX)

            return NotificationCenter.default
                .publisher(for: NSWorkspace.accessibilityDisplayOptionsDidChangeNotification)
                .map { _ in (type, status) }
                .eraseToAnyPublisher()

        #else

            return Empty().eraseToAnyPublisher()

        #endif
    }
}
