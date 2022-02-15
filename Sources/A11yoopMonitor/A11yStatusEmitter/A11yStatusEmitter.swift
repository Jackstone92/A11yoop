//
//  Interface.swift
//  Created by Jack Stone in 2021.
//

import Foundation

/// Provides a mechanism to emit status changes for a given accessibility feature.
///
/// This struct can be extended in order to define configurations that process status changes in whatever way you require.
///
public struct A11yStatusEmitter {

    /// Invoked when an accessibility feature status change is detected.
    ///
    /// - Parameter feature: The feature whose status has changed.
    ///
    public let emit: (_ feature: A11yFeature) -> Void

    public init(emit: @escaping (A11yFeature) -> Void) {
        self.emit = emit
    }
}
