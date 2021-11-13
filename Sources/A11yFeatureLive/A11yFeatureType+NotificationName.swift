//
//  A11yFeatureType+NotificationName.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import UIKit
import A11yFeature

extension A11yFeatureType {

    var notificationName: Notification.Name {
        switch self {
        case .voiceOver: return UIAccessibility.voiceOverStatusDidChangeNotification
        case .boldText: return UIAccessibility.boldTextStatusDidChangeNotification
        case .largerText: return UIContentSizeCategory.didChangeNotification
        case .switchControl: return UIAccessibility.switchControlStatusDidChangeNotification
        case .greyscale: return UIAccessibility.grayscaleStatusDidChangeNotification
        case .invertColours: return UIAccessibility.invertColorsStatusDidChangeNotification
        case .onOffLabels: return UIAccessibility.onOffSwitchLabelsDidChangeNotification
        case .reduceTransparency: return UIAccessibility.reduceTransparencyStatusDidChangeNotification
        case .reduceMotion: return UIAccessibility.reduceMotionStatusDidChangeNotification
        case .differentiateWithoutColour: return UIAccessibility.differentiateWithoutColorDidChangeNotification
        case .assistiveTouch: return UIAccessibility.assistiveTouchStatusDidChangeNotification
        case .shakeToUndo: return UIAccessibility.shakeToUndoDidChangeNotification
        case .darkerSystemColours: return UIAccessibility.darkerSystemColorsStatusDidChangeNotification
        case .buttonShapes:
            if #available(iOS 14.0, *) {
                return UIAccessibility.buttonShapesEnabledStatusDidChangeNotification
            } else {
                return .unsupportedA11yFeatureNotification
            }
        case .speakScreen: return UIAccessibility.speakScreenStatusDidChangeNotification
        case .speakSelection: return UIAccessibility.speakSelectionStatusDidChangeNotification
        case .hearingDevicePairedEar: return UIAccessibility.hearingDevicePairedEarDidChangeNotification
        case .guidedAccess: return UIAccessibility.guidedAccessStatusDidChangeNotification
        case .preferCrossFadeTransitions:
            if #available(iOS 14.0, *) {
                return UIAccessibility.prefersCrossFadeTransitionsStatusDidChange
            } else {
                return .unsupportedA11yFeatureNotification
            }
        }
    }
}

extension Notification.Name {

    static let unsupportedA11yFeatureNotification = Notification.Name("UnsupportedA11yFature")
}
