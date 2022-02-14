//
//  A11yFeatureType+NotificationNameTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
import A11yFeature
@testable import A11yStatusObserverLive

final class A11yFeatureType_NotificationNameTests: XCTestCase {

    private typealias sut = A11yFeatureType

    func test_notificationNameForVoiceOver() {

        XCTAssertEqual(sut.voiceOver.notificationName, UIAccessibility.voiceOverStatusDidChangeNotification)
    }

    func test_notificationNameForBoldText() {

        XCTAssertEqual(sut.boldText.notificationName, UIAccessibility.boldTextStatusDidChangeNotification)
    }

    func test_notificationNameForLargerText() {

        XCTAssertEqual(sut.largerText.notificationName, UIContentSizeCategory.didChangeNotification)
    }

    func test_notificationNameForSwitchControl() {

        XCTAssertEqual(sut.switchControl.notificationName, UIAccessibility.switchControlStatusDidChangeNotification)
    }

    func test_notificationNameForGreyscale() {

        XCTAssertEqual(sut.greyscale.notificationName, UIAccessibility.grayscaleStatusDidChangeNotification)
    }

    func test_notificationNameForInvertColours() {

        XCTAssertEqual(sut.invertColours.notificationName, UIAccessibility.invertColorsStatusDidChangeNotification)
    }

    func test_notificationNameForOnOffLabels() {

        XCTAssertEqual(sut.onOffLabels.notificationName, UIAccessibility.onOffSwitchLabelsDidChangeNotification)
    }

    func test_notificationNameForReduceTransparency() {

        XCTAssertEqual(sut.reduceTransparency.notificationName, UIAccessibility.reduceTransparencyStatusDidChangeNotification)
    }

    func test_notificationNameForReduceMotion() {

        XCTAssertEqual(sut.reduceMotion.notificationName, UIAccessibility.reduceMotionStatusDidChangeNotification)
    }

    func test_notificationNameForDifferentiateWithoutColour() {

        XCTAssertEqual(sut.differentiateWithoutColour.notificationName, UIAccessibility.differentiateWithoutColorDidChangeNotification)
    }

    func test_notificationNameForAssistiveTouch() {

        XCTAssertEqual(sut.assistiveTouch.notificationName, UIAccessibility.assistiveTouchStatusDidChangeNotification)
    }

    func test_notificationNameForShakeToUndo() {

        XCTAssertEqual(sut.shakeToUndo.notificationName, UIAccessibility.shakeToUndoDidChangeNotification)
    }

    func test_notificationNameForDarkerSystemColours() {

        XCTAssertEqual(sut.darkerSystemColours.notificationName, UIAccessibility.darkerSystemColorsStatusDidChangeNotification)
    }

    @available(iOS 14.0, *)
    func test_notificationNameForButtonShapesWhenSupported() {

        XCTAssertEqual(sut.buttonShapes.notificationName, UIAccessibility.buttonShapesEnabledStatusDidChangeNotification)
    }

    func test_notificationNameForButtonShapesWhenNotSupported() {

        if #available(iOS 14, *) {

            // Previous test will be run

        } else {

            XCTAssertEqual(sut.buttonShapes.notificationName, .unsupportedA11yFeatureNotification)
        }
    }

    func test_notificationNameForSpeakScreen() {

        XCTAssertEqual(sut.speakScreen.notificationName, UIAccessibility.speakScreenStatusDidChangeNotification)
    }

    func test_notificationNameForSpeakSelection() {

        XCTAssertEqual(sut.speakSelection.notificationName, UIAccessibility.speakSelectionStatusDidChangeNotification)
    }

    func test_notificationNameForHearingDevicePairedEar() {

        XCTAssertEqual(sut.hearingDevicePairedEar.notificationName, UIAccessibility.hearingDevicePairedEarDidChangeNotification)
    }

    func test_notificationNameForGuidedAccess() {

        XCTAssertEqual(sut.guidedAccess.notificationName, UIAccessibility.guidedAccessStatusDidChangeNotification)
    }

    @available(iOS 14.0, *)
    func test_notificationNameForPrefersCrossFadeTransitionsWhenSupported() {

        XCTAssertEqual(sut.preferCrossFadeTransitions.notificationName, UIAccessibility.prefersCrossFadeTransitionsStatusDidChange)
    }

    func test_notificationNameForPrefersCrossFadeTransitionsWhenNotSupported() {

        if #available(iOS 14.0, *) {

            // Previous test will be run

        } else {

            XCTAssertEqual(sut.preferCrossFadeTransitions.notificationName, .unsupportedA11yFeatureNotification)
        }
    }
}
