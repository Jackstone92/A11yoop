//
//  Store+FeatureStore.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature
import A11yStore

public typealias FeatureStore = Store<A11yFeatureType, A11yFeature, A11yStatus>

extension FeatureStore {

    public static var live: Self {

        let dataStore = DataStore<Key, Value>()

        return Self(
            get: {
                dataStore.data[$0]
            },
            getAll: {
                dataStore.data.keys
                    .compactMap { dataStore.data[$0] }
                    .sorted(by: { $0.type.description < $1.type.description })
            },
            insert: {
                dataStore.data[$1] = $0
            },
            update: {
                dataStore.data[$1]?.status = $0
            },
            remove: {
                dataStore.data.removeValue(forKey: $0)
            }
        )
    }
}
