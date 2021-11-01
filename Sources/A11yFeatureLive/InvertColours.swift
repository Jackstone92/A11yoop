//
//  InvertColours.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature

#if os(iOS) || os(tvOS)

    import UIKit

#elseif os(OSX)

    import AppKit

#else

    import Foundation

#endif

extension A11yFeature {

    private static let type: A11yFeatureType = .invertColors

    public static var invertColours: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isInvertColorsEnabled

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldInvertColors

        #else

            return false

        #endif
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {

        #if os(iOS) || os(tvOS)

            return NotificationCenter.default
                .publisher(for: UIAccessibility.invertColorsStatusDidChangeNotification)
                .map { _ in (type, status) }
                .eraseToAnyPublisher()

        #elseif os(OSX)

            return NotificationCenter.default
                .publisher(for: NSWorkspace.accessibilityDisplayOptionsDidChangeNotification)
                .map { _ in (type, status) }
                .eraseToAnyPublisher()

        #else

            return Empty().eraseToAnyPublisher()

        #endif
    }
}