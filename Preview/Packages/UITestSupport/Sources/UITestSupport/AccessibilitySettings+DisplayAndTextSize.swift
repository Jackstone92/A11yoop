//
//  AccessibilitySettings+DisplayAndTextSize.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum DisplayAndTextSize: Equatable, DrillDownable {
        case boldText(enabled: Bool)
        case largerText(LargerText)
        case buttonShapes(enabled: Bool)
        case onOffLabels(enabled: Bool)
        case reduceTransparency(enabled: Bool)
        case increaseContrast(enabled: Bool)
        case differentiateWithoutColor(enabled: Bool)
        case smartInvert(enabled: Bool)

        public var label: String {
            switch self {
            case .boldText:                     return "Bold Text"
            case .largerText:                   return "Larger Text"
            case .buttonShapes:                 return "Button Shapes"
            case .onOffLabels:                  return "On/Off Labels"
            case .reduceTransparency:           return "Reduce Transparency"
            case .increaseContrast:             return "Increase Contrast"
            case .differentiateWithoutColor:    return "Differentiate Without Color"
            case .smartInvert:                  return "Smart Invert"
            }
        }

        public var value: Any {
            switch self {
            case .boldText(let enabled):                    return enabled
            case .largerText(let largerText):               return largerText
            case .buttonShapes(let enabled),
                 .onOffLabels(let enabled),
                 .reduceTransparency(let enabled),
                 .increaseContrast(let enabled),
                 .differentiateWithoutColor(let enabled),
                 .smartInvert(let enabled):                 return enabled
            }
        }
    }
}

extension AccessibilitySettings.DisplayAndTextSize {

    public enum LargerText: Equatable, DrillDownable {
        case largerAccessibilitySizes(enabled: Bool)
        case slider(sliderValue: Double)

        public var label: String {
            switch self {
            case .largerAccessibilitySizes: return "Larger Accessibility Sizes"
            case .slider:                   return ""
            }
        }

        public var value: Any {
            switch self {
            case .largerAccessibilitySizes(let enabled):    return enabled
            case .slider(let sliderValue):                  return sliderValue
            }
        }
    }
}
