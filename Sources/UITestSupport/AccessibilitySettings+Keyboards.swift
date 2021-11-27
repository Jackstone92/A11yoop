//
//  AccessibilitySettings+Keyboards.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum Keyboards: Equatable {
        case fullKeyboardAccess(FullKeyboardAccess)
        case keyRepeat(KeyRepeat)
        case stickyKeys(StickyKeys)
        case slowKeys(SlowKeys)
        case showLowercaseKeys(enabled: Bool)

        public var label: String {
            switch self {
            case .fullKeyboardAccess:   return "Full Keyboard Access"
            case .keyRepeat:            return "Key Repeat"
            case .stickyKeys:           return "Sticky Keys"
            case .slowKeys:             return "Slow Keys"
            case .showLowercaseKeys:    return "Show Lowercase Keys"
            }
        }
    }
}

extension AccessibilitySettings.Keyboards {

    public enum FullKeyboardAccess: Equatable {
        case fullKeyboardAccess(enabled: Bool)
        case commands(Commands)
        case autoHide(AutoHide)
        case increaseSize(enabled: Bool)
        case highContrast(enabled: Bool)
        case colour(value: String)

        public var label: String {
            switch self {
            case .fullKeyboardAccess:   return "Full Keyboard Access"
            case .commands:             return "Commands"
            case .autoHide:             return "Auto-Hide"
            case .increaseSize:         return "Increase Size"
            case .highContrast:         return "High Contrast"
            case .colour:               return "Color"
            }
        }
    }
}

extension AccessibilitySettings.Keyboards.FullKeyboardAccess {

    public typealias Commands = [String: String]
}

extension AccessibilitySettings.Keyboards {

    public enum AutoHide: Equatable {
        case autoHide(enabled: Bool)
        case seconds(stepperValue: Double)

        public var label: String {
            switch self {
            case .autoHide(let enabled):        return "Auto-Hide"
            case .seconds(let stepperValue):    return "\(stepperValue) Seconds"
            }
        }
    }
}

extension AccessibilitySettings.Keyboards {

    public enum KeyRepeat: Equatable {
        case keyRepeat(enabled: Bool)
        case keyRepeatInterval(stepperValue: Double)
        case delayUntilRepeat(stepperValue: Double)

        public var label: String {
            switch self {
            case .keyRepeat:                            return "Key Repeat"
            case .keyRepeatInterval(let stepperValue):  return "\(stepperValue) Seconds"
            case .delayUntilRepeat(let stepperValue):   return "\(stepperValue) Seconds"
            }
        }
    }
}

extension AccessibilitySettings.Keyboards {

    public enum StickyKeys: Equatable {
        case stickyKeys(enabled: Bool)
        case toggleWithShiftKey(enabled: Bool)
        case sound(enabled: Bool)

        public var label: String {
            switch self {
            case .stickyKeys:           return "Sticky Keys"
            case .toggleWithShiftKey:   return "Toggle With Shift Key"
            case .sound:                return "Sound"
            }
        }
    }
}


extension AccessibilitySettings.Keyboards {

    public enum SlowKeys: Equatable {
        case slowKeys(enabled: Bool)

        public var label: String {
            switch self {
            case .slowKeys:     return "Slow Keys"
            }
        }
    }
}
