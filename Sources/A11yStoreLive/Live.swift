//
//  Store+FeatureStore.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature
import A11yStore

public typealias FeatureStore = Store<A11yFeatureType, A11yFeature, A11yStatus>

extension FeatureStore {

    /// The live accessibility feature store instance, which uses a `DataStore` as its underlying storage solution.
    ///
    /// This store supports the following operations:
    ///
    /// - **get**: Returns an accessibility feature from the store that is stored against a corresponding feature type, if at all present in the store.
    ///
    /// - **getAll**: Returns all accessibility features that are present in the store. These are sorted by their corresponding accessibility feature type descriptions.
    ///
    /// - **insert**: Inserts a new accessibility feature into the store against a specified feature type.
    ///            Note that these should be unique and subsequent insertions against the same feature type will cause the accessibility feature to be overwritten.
    ///
    /// - **Update**: Updates the status of an accessibility feature in the store for a given feature type.
    ///             If no accessibility feature is currently stored against the provided feature type then nothing will be updated.
    ///
    /// - **Remove**: Removes an accessibility feature that is currently stored against a given feature type.
    ///
    public static var live: Self {

        let dataStore = DataStore<Key, Value>()

        return Self(
            get: {
                await dataStore.get(forKey: $0)
            },
            getAll: {
                await dataStore.getAll()
                    .sorted(by: { $0.type.description < $1.type.description })
            },
            insert: {
                await dataStore.insert($0, forKey: $1)
            },
            update: {
                await dataStore.update(property: \.status, to: $0, forKey: $1)
            },
            remove: {
                await dataStore.remove(forKey: $0)
            }
        )
    }
}
