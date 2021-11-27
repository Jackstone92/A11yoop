//
//  AccessibilitySettings+SpokenContent.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

extension AccessibilitySettings {

    public enum SpokenContent: Equatable {
        case speakSelection(enabled: Bool)
        case pronunciations(Pronunciations)

        var label: String {
            switch self {
            case .speakSelection: return "Speak Selection"
            case .pronunciations: return "Pronunciations"
            }
        }
    }
}

extension AccessibilitySettings.SpokenContent {

    public struct Pronunciations: Equatable {

        public struct Replacement: Equatable {

            public var phrase: String
            public var substitution: String
            public var languages: String
            public var voice: String
            public var ignoreCase: Bool
            public var applyToAllApps: Bool

            public init(
                phrase: String,
                substitution: String,
                languages: String,
                voice: String,
                ignoreCase: Bool,
                applyToAllApps: Bool
            ) {
                self.phrase = phrase
                self.substitution = substitution
                self.languages = languages
                self.voice = voice
                self.ignoreCase = ignoreCase
                self.applyToAllApps = applyToAllApps
            }
        }

        public var replacements: [Replacement]

        public init(replacements: [AccessibilitySettings.SpokenContent.Pronunciations.Replacement]) {
            self.replacements = replacements
        }
    }
}
