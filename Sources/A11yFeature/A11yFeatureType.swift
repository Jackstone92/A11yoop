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
}

extension A11yFeatureType: CustomStringConvertible {

    public var description: String {
        switch self {
        case .voiceOver:    return "VoiceOver"
        case .boldText:     return "Bold Text"
        }
    }
}
