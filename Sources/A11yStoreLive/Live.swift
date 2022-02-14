//
//  Store+FeatureStore.swift
//  Created by Jack Stone in 2021.
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

        let queue = DispatchQueue(label: "A11yStore.queue", attributes: .concurrent)
        var _data = [Key: Value]()

        return Self(
            get: { key in
                queue.sync(flags: .barrier) {
                    _data[key]
                }
            },
            getAll: {
                queue.sync(flags: .barrier) {
                    _data.keys
                        .compactMap { _data[$0] }
                        .sorted(by: { $0.type.description < $1.type.description })
                }
            },
            insert: { value, key in
                queue.sync(flags: .barrier) {
                    _data[key] = value
                }
            },
            update: { value, key in
                queue.sync(flags: .barrier) {
                    _data[key]?.status = value
                }
            },
            remove: { key in
                queue.sync(flags: .barrier) {
                    _data.removeValue(forKey: key)
                }
            }
        )
    }
}
