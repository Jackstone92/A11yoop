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

    /// Displays on/off labels for UISwitch controls.
    case onOffLabels

    /// Removes transparency from layers to make them readable for users with visual impairments.
    case reduceTransparency

    /// Reduces animations to help users with motion sickness and epilepsy issues.
    case reduceMotion

    /// Helps colour blind users to differentiate settings differently.
    case differentiateWithoutColour

    /// Helps people with motor skill impairments perform certain actions or gestures by using a single tap.
    case assistiveTouch

    /// Undos the last command by shaking the phone.
    case shakeToUndo

    /// Enables people to control their devices using an external keyboard.
    case fullKeyboardAccess

    /// Enhances text contrast.
    case darkerSystemColours

    /// Creates outlines around interface elements that can be tapped.
    case buttonShapes

    /// Reads out the content of the current screen.
    case speakScreen
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
        case .onOffLabels: return "On/Off Labels"
        case .reduceTransparency: return "Reduce Transparency"
        case .reduceMotion: return "Reduce Motion"
        case .differentiateWithoutColour: return "Differentiate Without Colour"
        case .assistiveTouch: return "Assistive Touch"
        case .shakeToUndo: return "Shake to Undo"
        case .fullKeyboardAccess: return "Full Keyboard Access"
        case .darkerSystemColours: return "Darker System Colours"
        case .buttonShapes: return "Button Shapes"
        case .speakScreen: return "Speak Screen"
        }
    }
}
