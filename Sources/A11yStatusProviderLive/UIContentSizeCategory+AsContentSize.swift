//
//  UIContentSizeCategory+AsContentSize.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import UIKit
import A11yFeature

extension UIContentSizeCategory {

    /// An adapter that converts a `UIContentSizeCategory` value to a `ContentSize` value.
    func asContentSize() -> ContentSize {
        switch self {
        case .extraSmall: return .extraSmall
        case .small: return .small
        case .medium: return .medium
        case .large: return .large
        case .extraLarge: return .extraLarge
        case .extraExtraLarge: return .extraExtraLarge
        case .extraExtraExtraLarge: return .extraExtraExtraLarge
        case .accessibilityMedium: return .accessibilityMedium
        case .accessibilityLarge: return .accessibilityLarge
        case .accessibilityExtraLarge: return .accessibilityExtraLarge
        case .accessibilityExtraExtraLarge: return .accessibilityExtraExtraLarge
        case .accessibilityExtraExtraExtraLarge: return .accessibilityExtraExtraExtraLarge
        default: return .unknown
        }
    }
}
