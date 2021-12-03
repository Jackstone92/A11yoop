//
//  DrillDownableValue.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public enum DrillDownableValue: Equatable {
    case toggleable(Bool)
    case slideable(Double)
    case commands(AccessibilitySettings.Keyboards.FullKeyboardAccess.Commands)
    case pronunciations(AccessibilitySettings.SpokenContent.Pronunciations)
    case autoRevert(AccessibilitySettings.Touch.AssistiveTouch.AutoRevert)
    case tolerance(AccessibilitySettings.Touch.AssistiveTouch.Tolerance)
    case hotCorners(AccessibilitySettings.Touch.AssistiveTouch.HotCorners)
}

extension DrillDownableValue {

    public init?(_ value: Any) {
        switch value {
        case let value as DrillDownableValue: self = value
        case let value as Bool: self = .toggleable(value)
        case let value as Double: self = .slideable(value)
        case let value as AccessibilitySettings.Keyboards.FullKeyboardAccess.Commands: self = .commands(value)
        case let value as AccessibilitySettings.SpokenContent.Pronunciations: self = .pronunciations(value)
        case let value as AccessibilitySettings.Touch.AssistiveTouch.AutoRevert: self = .autoRevert(value)
        case let value as AccessibilitySettings.Touch.AssistiveTouch.Tolerance: self = .tolerance(value)
        case let value as AccessibilitySettings.Touch.AssistiveTouch.HotCorners: self = .hotCorners(value)
        default: return nil
        }
    }
}
