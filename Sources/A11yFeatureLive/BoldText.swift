//
//  BoldText.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#else
    import Foundation
#endif

extension A11yFeature {

    private static let type: A11yFeatureType = .boldText

    public static var boldText: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var isEnabled: Bool {
        #if os(iOS) || os(tvOS)

            return UIAccessibility.isBoldTextEnabled

        #elseif os(watchOS)

            let referenceFont = UIFont.preferredFont(forTextStyle: .body)
            let isBoldText = referenceFont.fontName.localizedCaseInsensitiveContains("bold")
            return isBoldText

        #else
            return false

        #endif
    }

    private static var status: A11yStatus { isEnabled.asA11yStatus() }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {

        #if os(iOS) || os(tvOS)

            return NotificationCenter.default
                .publisher(for: UIAccessibility.boldTextStatusDidChangeNotification)
                .map { _ in (type, status) }
                .eraseToAnyPublisher()

        #else

            return Empty().eraseToAnyPublisher()

        #endif
    }
}
