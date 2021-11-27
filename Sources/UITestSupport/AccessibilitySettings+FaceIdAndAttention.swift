//
//  AccessibilitySettings+FaceIdAndAttention.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum FaceIdAndAttention: Equatable {
        case attentionAwareFeatures(enabled: Bool)

        public var label: String {
            switch self {
            case .attentionAwareFeatures:   return "Attention Aware Features"
            }
        }
    }
}
