//
//  ReduceMotion.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature

#if os(iOS) || os(tvOS)

    import UIKit

#elseif os(OSX)

    import AppKit

#elseif os(watchOS)

    import WatchKit

#endif

extension A11yFeature {

    private static let type: A11yFeatureType = .reduceMotion

    public static var reduceMotion: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isReduceMotionEnabled

        #elseif os(OSX)

            return NSWorkspace.shared.accessibilityDisplayShouldReduceMotion

        #elseif os(watchOS)

            return WKAccessibilityIsReduceMotionEnabled()

        #endif
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {
        #if os(iOS) || os(tvOS)

            return NotificationCenter.default
                .publisher(for: UIAccessibility.reduceMotionStatusDidChangeNotification)
                .map { _ in (type, status) }
                .eraseToAnyPublisher()

        #elseif os(watchOS)

            return NotificationCenter.default
                .publisher(for: .WKAccessibilityReduceMotionStatusDidChange)
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
