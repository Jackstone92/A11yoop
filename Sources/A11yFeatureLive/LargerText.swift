//
//  LargerText.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Combine
import A11yFeature
import UIKit

extension A11yFeature {

    private static let type: A11yFeatureType = .largerText

    public static var largerText: Self {
        Self(type: type, status: status, observeChanges: observeChanges)
    }

    private static var status: A11yStatus {
        let contentSize = UIScreen.main.traitCollection.preferredContentSizeCategory.asContentSize()

        return .contentSize(contentSize)
    }

    private static func observeChanges() -> AnyPublisher<(A11yFeatureType, A11yStatus), Never> {
        SubscriptionFactory.make(
            with: .default,
            notificationName: UIContentSizeCategory.didChangeNotification,
            type: type,
            status: status
        )
    }
}

#if os(iOS) || os(tvOS)

private extension UIContentSizeCategory {

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

#endif

#if os(watchOS)

    extension CGFloat {

        func asContentSize() -> ContentSize {
            switch self {
            case 14.0:  return .extraSmall
            case 15.0:  return .small
            case 16.0:  return .large
            case 17.0:  return .extraLarge
            case 18.0:  return .extraExtraLarge
            case 19.0:  return .extraExtraExtraLarge
            default:    return .unknown
            }
        }
    }

#endif
