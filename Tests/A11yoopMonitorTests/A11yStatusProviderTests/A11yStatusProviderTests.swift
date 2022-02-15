//
//  A11yStatusProviderTests.swift
//  Created by Jack Stone in 2021.
//

import XCTest
@testable import A11yoopMonitor

final class A11yStatusProviderTests: XCTestCase {

    private var sut: A11yStatusProvider!

    override func setUp() {
        super.setUp()
        sut = .live
    }

    func test_getStatusForVoiceOver() {

        XCTAssertEqual(sut.getStatus(.voiceOver), UIAccessibility.isVoiceOverRunning.asA11yStatus())
    }

    func test_getStatusForBoldText() {

        XCTAssertEqual(sut.getStatus(.boldText), UIAccessibility.isBoldTextEnabled.asA11yStatus())
    }

    func test_getStatusForLargerText() {

        let expectedContentSize = UIScreen.main.traitCollection.preferredContentSizeCategory.asContentSize()

        XCTAssertEqual(sut.getStatus(.largerText), .contentSize(expectedContentSize))
    }

    func test_getStatusForSwitchControl() {

        XCTAssertEqual(sut.getStatus(.switchControl), UIAccessibility.isSwitchControlRunning.asA11yStatus())
    }

    func test_getStatusForGreyscale() {

        XCTAssertEqual(sut.getStatus(.greyscale), UIAccessibility.isGrayscaleEnabled.asA11yStatus())
    }

    func test_getStatusForInvertColours() {

        XCTAssertEqual(sut.getStatus(.invertColours), UIAccessibility.isInvertColorsEnabled.asA11yStatus())
    }

    func test_getStatusForOnOffLabels() {

        XCTAssertEqual(sut.getStatus(.onOffLabels), UIAccessibility.isOnOffSwitchLabelsEnabled.asA11yStatus())
    }

    func test_getStatusForReduceTransparency() {

        XCTAssertEqual(sut.getStatus(.reduceTransparency), UIAccessibility.isReduceTransparencyEnabled.asA11yStatus())
    }

    func test_getStatusForReduceMotion() {

        XCTAssertEqual(sut.getStatus(.reduceMotion), UIAccessibility.isReduceMotionEnabled.asA11yStatus())
    }

    func test_getStatusForDifferentiateWithoutColour() {

        XCTAssertEqual(sut.getStatus(.differentiateWithoutColour), UIAccessibility.shouldDifferentiateWithoutColor.asA11yStatus())
    }

    func test_getStatusForAssistiveTouch() {

        XCTAssertEqual(sut.getStatus(.assistiveTouch), UIAccessibility.isAssistiveTouchRunning.asA11yStatus())
    }

    func test_getStatusForShakeToUndo() {

        XCTAssertEqual(sut.getStatus(.shakeToUndo), UIAccessibility.isShakeToUndoEnabled.asA11yStatus())
    }

    func test_getStatusForDarkerSystemColours() {

        XCTAssertEqual(sut.getStatus(.darkerSystemColours), UIAccessibility.isDarkerSystemColorsEnabled.asA11yStatus())
    }

    @available(iOS 14.0, *)
    func test_getStatusForButtonShapes() {

        XCTAssertEqual(sut.getStatus(.buttonShapes), UIAccessibility.buttonShapesEnabled.asA11yStatus())
    }

    func test_getStatusForSpeakScreen() {

        XCTAssertEqual(sut.getStatus(.speakScreen), UIAccessibility.isSpeakScreenEnabled.asA11yStatus())
    }

    func test_getStatusForSpeakSelection() {

        XCTAssertEqual(sut.getStatus(.speakSelection), UIAccessibility.isSpeakSelectionEnabled.asA11yStatus())
    }

    func test_getStatusForHearingDevicePairedEar() {

        XCTAssertEqual(sut.getStatus(.hearingDevicePairedEar), (!UIAccessibility.hearingDevicePairedEar.isEmpty).asA11yStatus())
    }

    func test_getStatusForGuidedAccess() {

        XCTAssertEqual(sut.getStatus(.guidedAccess), UIAccessibility.isGuidedAccessEnabled.asA11yStatus())
    }

    @available(iOS 14.0, *)
    func test_getStatusForPrefersCrossFadeTransitions() {

        XCTAssertEqual(sut.getStatus(.preferCrossFadeTransitions), UIAccessibility.prefersCrossFadeTransitions.asA11yStatus())
    }
}
