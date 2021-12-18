//
//  DataStore.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

/// A data store that can be used as the underlying storage for an `A11yStore`.
actor DataStore<Key: Hashable, Value> {

    private var data = [Key: Value]()

    func get(forKey key: Key) -> Value? {
        data[key]
    }

    func getAll() -> [Value] {
        data.keys.compactMap { data[$0] }
    }

    func insert(_ value: Value, forKey key: Key) {
        data[key] = value
    }

    func update<T>(property: WritableKeyPath<Value, T>, to value: T, forKey key: Key) {
        data[key]?[keyPath: property] = value
    }

    func remove(forKey key: Key) -> Value? {
        data.removeValue(forKey: key)
    }
}
