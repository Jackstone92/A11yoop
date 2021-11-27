//
//  AccessibilitySettings+DisplayAndTextSize.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum DisplayAndTextSize: Equatable {
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
    }
}

extension AccessibilitySettings.DisplayAndTextSize {

    public enum LargerText: Equatable {
        case largerAccessibilitySizes(enabled: Bool)
        case slider(sliderValue: Double)

        public var label: String {
            switch self {
            case .largerAccessibilitySizes: return "Larger Accessibility Sizes"
            case .slider:                   return ""
            }
        }
    }
}
