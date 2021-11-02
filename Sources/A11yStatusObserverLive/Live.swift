//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yFeature
import A11yStatusObserver
import A11yStatusEmitter
import A11yStoreLive

extension A11yStatusObserver {

    public static var live: Self {
        Self { feature, store, emitter in
            feature.observeChanges()
                .sink { onChangeObserved(for: $0, whereStatusChangedTo: $1, store: store, emitter: emitter) }
        }
    }

    private static func onChangeObserved(
        for type: A11yFeatureType,
        whereStatusChangedTo status: A11yStatus,
        store: FeatureStore,
        emitter: A11yStatusEmitter
    ) {
        updateStore(with: status, for: type, using: store)
        emitter.emit(status, type)
    }

    private static func updateStore(
        with status: A11yStatus,
        for type: A11yFeatureType,
        using store: FeatureStore
    ) {
        store.update(status, type)
    }
}
