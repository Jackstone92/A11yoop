//
//  FullKeyboardAccess.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature

#if os(iOS) || os(tvOS) || os(watchOS)

    import UIKit

#elseif os(OSX)

    import AppKit

#else

    import Foundation

#endif

extension A11yFeature {

    private static let type: A11yFeatureType = .fullKeyboardAccess

    public static var fullKeyboardAccess: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        #if os(OSX)

            return NSApplication.shared.isFullKeyboardAccessEnabled

        #else

            return false

        #endif
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {
        return Empty().eraseToAnyPublisher()
    }
}
