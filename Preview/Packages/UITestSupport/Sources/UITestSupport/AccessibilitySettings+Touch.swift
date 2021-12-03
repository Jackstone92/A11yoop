//
//  AccessibilitySettings+Touch.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum Touch: Equatable, DrillDownable {
        case assistiveTouch(enabled: Bool)
        case shakeToUndo(enabled: Bool)

        public var label: String {
            switch self {
            case .assistiveTouch:   return "AssistiveTouch"
            case .shakeToUndo:      return "Shake to Undo"
            }
        }

        public var value: Any {
            switch self {
            case .assistiveTouch(let enabled),
                 .shakeToUndo(let enabled):     return enabled
            }
        }
    }
}

extension AccessibilitySettings.Touch {

    public enum AssistiveTouch: Equatable, DrillDownable {
        case mousePointerDwellControl(enabled: Bool)
        case mousePointerDwellAutoRevert(AutoRevert)
        case mousePointerDwellTolerance(Tolerance)
        case mousePointerDwellHotCorners(HotCorners)
        case seconds(stepperValue: Double)

        public var label: String {
            switch self {
            case .mousePointerDwellControl:     return "MOUSE_POINTER_DWELL_CONTROL"
            case .mousePointerDwellAutoRevert:  return "MOUSE_POINTER_DWELL_AUTOREVERT"
            case .mousePointerDwellTolerance:   return "MOUSE_POINTER_DWELL_TOLERANCE"
            case .mousePointerDwellHotCorners:  return "MOUSE_POINTER_DWELL_HOT_CORNERS"
            case .seconds(let stepperValue):    return "\(stepperValue) Seconds"
            }
        }

        public var value: Any {
            switch self {
            case .mousePointerDwellControl(let enabled):        return enabled
            case .mousePointerDwellAutoRevert(let autoRevert):  return autoRevert
            case .mousePointerDwellTolerance(let tolerance):    return tolerance
            case .mousePointerDwellHotCorners(let hotCorners):  return hotCorners
            case .seconds(let stepperValue):                    return stepperValue
            }
        }
    }
}

extension AccessibilitySettings.Touch.AssistiveTouch {

    public enum AutoRevert: Equatable, DrillDownable {
        case mousePointerDwellAuto(enabled: Bool)
        case tocar(selected: Bool)
        case pausarPermanencia(selected: Bool)

        public var label: String {
            switch self {
            case .mousePointerDwellAuto:    return "MOUSE_POINTER_DWELL_AUTOREVERT_FOOTER"
            case .tocar:                    return "Tocar"
            case .pausarPermanencia:        return "Pausar Permanencia"
            }
        }

        public var value: Any {
            switch self {
            case .mousePointerDwellAuto(let enabled):   return enabled
            case .tocar(let selected),
                 .pausarPermanencia(let selected):      return selected
            }
        }
    }

    public enum Tolerance: Equatable, DrillDownable {
        case dwellMovementToleranceFooter(sliderValue: Double)

        public var label: String {
            switch self {
            case .dwellMovementToleranceFooter:     return "DWELL_MOVEMENT_TOLERANCE_FOOTER"
            }
        }

        public var value: Any {
            switch self {
            case .dwellMovementToleranceFooter(let sliderValue):    return sliderValue
            }
        }
    }

    public struct HotCorners: Equatable {
        public var topLeft: String
        public var topRight: String
        public var bottomLeft: String
        public var bottomRight: String

        public init(
            topLeft: String,
            topRight: String,
            bottomLeft: String,
            bottomRight: String
        ) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomLeft = bottomLeft
            self.bottomRight = bottomRight
        }
    }
}
