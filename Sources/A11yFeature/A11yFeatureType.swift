//
//  A11yFeatureType.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public enum A11yFeatureType: Hashable, CaseIterable {

    /// The screen reader available on Apple platforms.
    case voiceOver

    /// Increases legibility by making fonts heavier.
    case boldText

    /// Increases legibility by making fonts bigger.
    case largerText

    /// Allows users with limited mobility to control their device with the help of ability switches and other adaptive devices.
    case switchControl

    /// Makes the display more readable for colour blind people by using grey tones instead of colours.
    case greyscale

    /// Helps people with low vision, colour blindness, or sensitivity to brightness to read the display content.
    case invertColors

    /// Increases contrast.
    case increaseContrast
}

extension A11yFeatureType: CustomStringConvertible {

    public var description: String {
        switch self {
        case .voiceOver:    return "VoiceOver"
        case .boldText:     return "Bold Text"
        case .largerText:   return "Larger Text"
        case .switchControl: return "Switch Control"
        case .greyscale: return "Greyscale"
        case .invertColors: return "Invert Colours"
        case .increaseContrast: return "Increase Contrast"
        }
    }
}
