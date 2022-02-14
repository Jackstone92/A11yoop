//
//  Interface.swift
//  Created by Jack Stone in 2021.
//

import Foundation

/// A generic store interface that supports CRUD operations operating on keys, values and updatable properties on values.
public final class Store<Key: Hashable, Value, Updatable> {

    /// Returns the store's value for a given key, if a value is present in the store.
    public let get: (_ key: Key) -> Value?

    /// Returns all values that are present in the store.
    public let getAll: () -> [Value]

    /// Inserts a new value into the store for a given key.
    public let insert: (_ value: Value, _ key: Key) -> Void

    /// Updates a property on a value in the store for a given key.
    public let update: (_ value: Updatable, _ key: Key) -> Void

    /// Removes a value from the store for a given key.
    public let remove: (_ key: Key) -> Value?

    public init(
        get: @escaping (Key) -> Value?,
        getAll: @escaping () -> [Value],
        insert: @escaping (Value, Key) -> Void,
        update: @escaping (_ value: Updatable, _ key: Key) -> Void,
        remove: @escaping (Key) -> Value?
    ) {
        self.get = get
        self.getAll = getAll
        self.insert = insert
        self.update = update
        self.remove = remove
    }
}
