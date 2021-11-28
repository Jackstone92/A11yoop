//
//  AccessibilitySettings+Motion.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum Motion: Equatable, DrillDownable {
        case reduceMotion(enabled: Bool)
        case preferCrossFadeTransitions(enabled: Bool)
        case autoPlayMessageEffects(enabled: Bool)
        case autoPlayVideoPreviews(enabled: Bool)

        public var label: String {
            switch self {
            case .reduceMotion:                 return "Reduce Motion"
            case .preferCrossFadeTransitions:   return "Prefer Cross-Fade Transitions"
            case .autoPlayMessageEffects:       return "Auto-Play Message Effects"
            case .autoPlayVideoPreviews:        return "Auto-Play Video Previews"
            }
        }

        public var next: DrillDownable? { associatedValue as? DrillDownable }

        private var associatedValue: Any {
            switch self {
            case .reduceMotion(let enabled),
                 .preferCrossFadeTransitions(let enabled),
                 .autoPlayMessageEffects(let enabled),
                 .autoPlayVideoPreviews(let enabled):       return enabled
            }
        }
    }
}
