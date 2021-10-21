//
//  VoiceOver.swift
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

    private static let type: A11yFeatureType = .voiceOver

    public static var voiceOver: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isVoiceOverRunning

        #elseif os(OSX)

            return NSWorkspace.shared.isVoiceOverEnabled

        #elseif os(watchOS)

            return WKAccessibilityIsVoiceOverRunning()

        #endif
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {

        #if os(iOS) || os(tvOS)

        return NotificationCenter.default
            .publisher(for: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)
            .map { _ in (.voiceOver, isEnabled.asA11yStatus) }
            .eraseToAnyPublisher()

        #elseif os(OSX)

        return NSWorkspace.shared.publisher(for: \.isVoiceOverEnabled)
            .map { (.voiceOver, $0.asA11yStatus) }
            .eraseToAnyPublisher()

        #elseif os(watchOS)

        return NotificationCenter.default
            .publisher(for: NSNotification.Name(rawValue: WKAccessibilityVoiceOverStatusChanged), object: nil)
            .map { _ in (.voiceOver, isEnabled.asA11yStatus) }
            .eraseToAnyPublisher()

        #endif
    }
}
