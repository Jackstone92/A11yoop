//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yCore
import A11yStatusEmitter
import A11yStore
import A11yStoreLive

public struct A11yStatusObserver {

    public let observeChanges: (_ feature: A11yFeature, _ store: FeatureStore, _ emitter: A11yStatusEmitter) -> AnyCancellable

    public init(
        observeChanges: @escaping (
            _ feature: A11yFeature,
            _ store: FeatureStore,
            _ emitter: A11yStatusEmitter
        ) -> AnyCancellable
    ) {
        self.observeChanges = observeChanges
    }
}
