//
//  AccessibilitySettings+Keyboards.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum Keyboards: Equatable, DrillDownable {
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

        public var next: DrillDownable? { associatedValue as? DrillDownable }

        private var associatedValue: Any {
            switch self {
            case .fullKeyboardAccess(let fullKeyboardAccess):   return fullKeyboardAccess
            case .keyRepeat(let keyRepeat):                     return keyRepeat
            case .stickyKeys(let stickyKeys):                   return stickyKeys
            case .slowKeys(let slowKeys):                       return slowKeys
            case .showLowercaseKeys(let enabled):               return enabled
            }
        }
    }
}

extension AccessibilitySettings.Keyboards {

    public enum FullKeyboardAccess: Equatable, DrillDownable {
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

        public var next: DrillDownable? { associatedValue as? DrillDownable }

        private var associatedValue: Any {
            switch self {
            case .commands(let commands):           return commands
            case .autoHide(let autoHide):           return autoHide
            case .colour(let value):                return value
            case .fullKeyboardAccess(let enabled),
                 .increaseSize(let enabled),
                 .highContrast(let enabled):        return enabled
            }
        }
    }
}

extension AccessibilitySettings.Keyboards.FullKeyboardAccess {

    public typealias Commands = [String: String]
}

extension AccessibilitySettings.Keyboards {

    public enum AutoHide: Equatable, DrillDownable {
        case autoHide(enabled: Bool)
        case seconds(stepperValue: Double)

        public var label: String {
            switch self {
            case .autoHide:                     return "Auto-Hide"
            case .seconds(let stepperValue):    return "\(stepperValue) Seconds"
            }
        }

        public var next: DrillDownable? { associatedValue as? DrillDownable }

        private var associatedValue: Any {
            switch self {
            case .autoHide(let enabled):        return enabled
            case .seconds(let stepperValue):    return stepperValue
            }
        }
    }
}

extension AccessibilitySettings.Keyboards {

    public enum KeyRepeat: Equatable, DrillDownable {
        case keyRepeat(enabled: Bool)
        case keyRepeatInterval(stepperValue: Double)
        case delayUntilRepeat(stepperValue: Double)

        public var label: String {
            switch self {
            case .keyRepeat:                            return "Key Repeat"
            case .keyRepeatInterval(let stepperValue),
                 .delayUntilRepeat(let stepperValue):   return "\(stepperValue) Seconds"
            }
        }

        public var next: DrillDownable? { associatedValue as? DrillDownable }

        private var associatedValue: Any {
            switch self {
            case .keyRepeat(let enabled):
                return enabled
            case .keyRepeatInterval(let stepperValue),
                 .delayUntilRepeat(let stepperValue):
                return stepperValue
            }
        }
    }
}

extension AccessibilitySettings.Keyboards {

    public enum StickyKeys: Equatable, DrillDownable {
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

        public var next: DrillDownable? { associatedValue as? DrillDownable }

        private var associatedValue: Any {
            switch self {
            case .stickyKeys(let enabled),
                 .toggleWithShiftKey(let enabled),
                 .sound(let enabled):
                return enabled
            }
        }
    }
}


extension AccessibilitySettings.Keyboards {

    public enum SlowKeys: Equatable, DrillDownable {
        case slowKeys(enabled: Bool)

        public var label: String {
            switch self {
            case .slowKeys:     return "Slow Keys"
            }
        }

        public var next: DrillDownable? { associatedValue as? DrillDownable }

        private var associatedValue: Any {
            switch self {
            case .slowKeys(let enabled): return enabled
            }
        }
    }
}
