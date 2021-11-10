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

    /// Enhances text contrast.
    case darkerSystemColours

    /// Creates outlines around interface elements that can be tapped.
    case buttonShapes

    /// Reads out the content of the current screen.
    case speakScreen

    /// Reads out selected content.
    case speakSelection

    /// Pairing status of a hearing aid.
    case hearingDevicePairedEar

    /// Keeps people in a single app and allows them to control which features are available.
    case guidedAccess

    /// Reduces the motion of user interface controls that slide in when appearing and disappearing.
    case preferCrossFadeTransitions
}

// MARK: - CustomStringConvertible conformance
extension A11yFeatureType: CustomStringConvertible {

    public var description: String {
        switch self {
        case .voiceOver: return "VoiceOver"
        case .boldText: return "Bold Text"
        case .largerText: return "Larger Text"
        case .switchControl: return "Switch Control"
        case .greyscale: return "Greyscale"
        case .invertColors: return "Invert Colours"
        case .onOffLabels: return "On/Off Labels"
        case .reduceTransparency: return "Reduce Transparency"
        case .reduceMotion: return "Reduce Motion"
        case .differentiateWithoutColour: return "Differentiate Without Colour"
        case .assistiveTouch: return "Assistive Touch"
        case .shakeToUndo: return "Shake to Undo"
        case .darkerSystemColours: return "Darker System Colours"
        case .buttonShapes: return "Button Shapes"
        case .speakScreen: return "Speak Screen"
        case .speakSelection: return "Speak Selection"
        case .hearingDevicePairedEar: return "Hearing Device Paired Ear"
        case .guidedAccess: return "Guided Access"
        case .preferCrossFadeTransitions: return "Prefer Cross-Fade Transitions"
        }
    }
}
