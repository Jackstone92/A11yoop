//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import UIKit
import A11yFeature
import A11yStatusProvider

extension A11yStatusProvider {

    /// The live status provider instance.
    public static var live: Self {
        Self(getStatus: getStatus)
    }

    private static func getStatus(for featureType: A11yFeatureType) -> A11yStatus {
        switch featureType {
        case .voiceOver:
            return UIAccessibility.isVoiceOverRunning.asA11yStatus()

        case .boldText:
            return UIAccessibility.isBoldTextEnabled.asA11yStatus()

        case .largerText:
            let contentSize = UIScreen.main.traitCollection.preferredContentSizeCategory.asContentSize()
            return .contentSize(contentSize)

        case .switchControl:
            return UIAccessibility.isSwitchControlRunning.asA11yStatus()

        case .greyscale:
            return UIAccessibility.isGrayscaleEnabled.asA11yStatus()

        case .invertColours:
            return UIAccessibility.isInvertColorsEnabled.asA11yStatus()

        case .onOffLabels:
            return UIAccessibility.isOnOffSwitchLabelsEnabled.asA11yStatus()

        case .reduceTransparency:
            return UIAccessibility.isReduceTransparencyEnabled.asA11yStatus()

        case .reduceMotion:
            return UIAccessibility.isReduceMotionEnabled.asA11yStatus()

        case .differentiateWithoutColour:
            return UIAccessibility.shouldDifferentiateWithoutColor.asA11yStatus()

        case .assistiveTouch:
            return UIAccessibility.isAssistiveTouchRunning.asA11yStatus()

        case .shakeToUndo:
            return UIAccessibility.isShakeToUndoEnabled.asA11yStatus()

        case .darkerSystemColours:
            return UIAccessibility.isDarkerSystemColorsEnabled.asA11yStatus()

        case .buttonShapes:
            guard #available(iOS 14.0, *) else { return .disabled }
            return UIAccessibility.buttonShapesEnabled.asA11yStatus()

        case .speakScreen:
            return UIAccessibility.isSpeakScreenEnabled.asA11yStatus()

        case .speakSelection:
            return UIAccessibility.isSpeakSelectionEnabled.asA11yStatus()

        case .hearingDevicePairedEar:
            return (!UIAccessibility.hearingDevicePairedEar.isEmpty).asA11yStatus()

        case .guidedAccess:
            return UIAccessibility.isGuidedAccessEnabled.asA11yStatus()

        case .preferCrossFadeTransitions:
            guard #available(iOS 14.0, *) else { return .disabled }
            return UIAccessibility.prefersCrossFadeTransitions.asA11yStatus()
        }
    }
}
