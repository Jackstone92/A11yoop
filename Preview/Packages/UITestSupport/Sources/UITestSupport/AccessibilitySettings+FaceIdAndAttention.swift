//
//  AccessibilitySettings+FaceIdAndAttention.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum FaceIdAndAttention: Equatable, DrillDownable {
        case attentionAwareFeatures(enabled: Bool)

        public var label: String {
            switch self {
            case .attentionAwareFeatures:   return "Attention Aware Features"
            }
        }

        public var value: Any {
            switch self {
            case .attentionAwareFeatures(let enabled): return enabled
            }
        }
    }
}
