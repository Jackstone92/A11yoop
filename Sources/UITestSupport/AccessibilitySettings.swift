//
//  AccessibilitySettings.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public enum AccessibilitySettings: Equatable {
    case displayAndTextSize(DisplayAndTextSize)
    case motion(Motion)
    case spokenContent(SpokenContent)
    case touch(Touch)
    case faceIdAndAttention(FaceIdAndAttention)
    case keyboards(Keyboards)

    public var label: String {
        switch self {
        case .displayAndTextSize:   return "Display & Text Size"
        case .motion:               return "Motion"
        case .spokenContent:        return "Spoken Content"
        case .touch:                return "Touch"
        case .faceIdAndAttention:   return "Face ID & Attention"
        case .keyboards:            return "Keyboards"
        }
    }
}
