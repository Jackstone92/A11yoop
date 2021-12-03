//
//  DrillDownableValueTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import UITestSupport

final class DrillDownableValueTests: XCTestCase {

    private typealias sut = DrillDownableValue

    private typealias Commands = AccessibilitySettings.Keyboards.FullKeyboardAccess.Commands
    private typealias Pronunciations = AccessibilitySettings.SpokenContent.Pronunciations
    private typealias AutoRevert = AccessibilitySettings.Touch.AssistiveTouch.AutoRevert
    private typealias Tolerance = AccessibilitySettings.Touch.AssistiveTouch.Tolerance
    private typealias HotCorners = AccessibilitySettings.Touch.AssistiveTouch.HotCorners

    func test_initWithDrillDownableValue() {

        let drillDownableValue = DrillDownableValue.toggleable(false)

        let value = sut.init(drillDownableValue)

        XCTAssertEqual(value, drillDownableValue)
    }

    func test_initWithBool() {

        let bool = true

        let value = sut.init(bool)

        XCTAssertEqual(value, .toggleable(bool))
    }

    func test_initWithDouble() {

        let double: Double = 0.99

        let value = sut.init(double)

        XCTAssertEqual(value, .slideable(double))
    }

    func test_initWithCommands() {

        let commands: Commands = ["test key": "test value"]

        let value = sut.init(commands)

        XCTAssertEqual(value, .commands(commands))
    }

    func test_initWithPronunciations() {

        let pronunciations = Pronunciations(
            replacements: [
                .init(
                    phrase: "phrase",
                    substitution: "substitution",
                    languages: "languages",
                    voice: "voice",
                    ignoreCase: true,
                    applyToAllApps: false
                )
            ]
        )

        let value = sut.init(pronunciations)

        XCTAssertEqual(value, .pronunciations(pronunciations))
    }

    func test_initWithAutoRevert() {

        let autoRevert = AutoRevert.mousePointerDwellAuto(enabled: true)

        let value = sut.init(autoRevert)

        XCTAssertEqual(value, .autoRevert(autoRevert))
    }

    func test_initWithTolerance() {

        let tolerance = Tolerance.dwellMovementToleranceFooter(sliderValue: 99.999)

        let value = sut.init(tolerance)

        XCTAssertEqual(value, .tolerance(tolerance))
    }

    func test_initWithHotCorners() {

        let hotCorners = HotCorners(
            topLeft: "topLeft",
            topRight: "topRight",
            bottomLeft: "bottomLeft",
            bottomRight: "bottomRight"
        )

        let value = sut.init(hotCorners)

        XCTAssertEqual(value, .hotCorners(hotCorners))
    }
}
