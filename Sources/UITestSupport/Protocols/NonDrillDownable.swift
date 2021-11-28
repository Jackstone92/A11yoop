//
//  NonDrillDownable.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

protocol NonDrillDownable {}

// MARK: - NonDrillDownable conformances
extension Bool: NonDrillDownable {}
extension Double: NonDrillDownable {}
extension AccessibilitySettings.Keyboards.FullKeyboardAccess.Commands: NonDrillDownable {}
extension AccessibilitySettings.SpokenContent.Pronunciations: NonDrillDownable {}
extension AccessibilitySettings.Touch.AssistiveTouch.AutoRevert: NonDrillDownable {}
extension AccessibilitySettings.Touch.AssistiveTouch.Tolerance: NonDrillDownable {}
extension AccessibilitySettings.Touch.AssistiveTouch.HotCorners: NonDrillDownable {}
