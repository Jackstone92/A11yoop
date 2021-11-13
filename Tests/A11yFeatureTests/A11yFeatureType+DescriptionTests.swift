//
//  A11yFeatureType+DescriptionTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import A11yFeature

final class A11yFeatureType_DescriptionTests: XCTestCase {

    private typealias sut = A11yFeatureType

    func test_descriptionForVoiceOver() {

        XCTAssertEqual(sut.voiceOver.description, "VoiceOver")
    }

    func test_descriptionForBoldText() {

        XCTAssertEqual(sut.boldText.description, "Bold Text")
    }

    func test_descriptionForLargerText() {

        XCTAssertEqual(sut.largerText.description, "Larger Text")
    }

    func test_descriptionForSwitchControl() {

        XCTAssertEqual(sut.switchControl.description, "Switch Control")
    }

    func test_descriptionForGreyscale() {

        XCTAssertEqual(sut.greyscale.description, "Greyscale")
    }

    func test_descriptionForInvertColours() {

        XCTAssertEqual(sut.invertColours.description, "Invert Colours")
    }

    func test_descriptionForOnOffLabels() {

        XCTAssertEqual(sut.onOffLabels.description, "On/Off Labels")
    }

    func test_descriptionForReduceTransparency() {

        XCTAssertEqual(sut.reduceTransparency.description, "Reduce Transparency")
    }

    func test_descriptionForReduceMotion() {

        XCTAssertEqual(sut.reduceMotion.description, "Reduce Motion")
    }

    func test_descriptionForDifferentiateWithoutColour() {

        XCTAssertEqual(sut.differentiateWithoutColour.description, "Differentiate Without Colour")
    }

    func test_descriptionForAssistiveTouch() {

        XCTAssertEqual(sut.assistiveTouch.description, "Assistive Touch")
    }

    func test_descriptionForShakeToUndo() {

        XCTAssertEqual(sut.shakeToUndo.description, "Shake to Undo")
    }

    func test_descriptionForDarkerSystemColours() {

        XCTAssertEqual(sut.darkerSystemColours.description, "Darker System Colours")
    }

    func test_descriptionForButtonShapes() {

        XCTAssertEqual(sut.buttonShapes.description, "Button Shapes")
    }

    func test_descriptionForSpeakScreen() {

        XCTAssertEqual(sut.speakScreen.description, "Speak Screen")
    }

    func test_descriptionForSpeakSelection() {

        XCTAssertEqual(sut.speakSelection.description, "Speak Selection")
    }

    func test_descriptionForHearingDevicePairedEar() {

        XCTAssertEqual(sut.hearingDevicePairedEar.description, "Hearing Device Paired Ear")
    }

    func test_descriptionForGuidedAccess() {

        XCTAssertEqual(sut.guidedAccess.description, "Guided Access")
    }

    func test_descriptionForPreferCrossFadeTransitions() {

        XCTAssertEqual(sut.preferCrossFadeTransitions.description, "Prefer Cross-Fade Transitions")
    }
}
