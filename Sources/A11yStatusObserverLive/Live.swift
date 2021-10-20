//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yStatusObserver
import A11yStatusEmitter

extension A11yStatusObserver {

    public static var live: Self {
        Self { feature, store, emitter in
            feature.observeChanges()
                .sink { type, status in
                    store.insert(status, type)
                    emitter.emit(status, type)
                }
        }
    }
}
