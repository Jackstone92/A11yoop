//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

/// A generic store interface that supports CRUD operations operating on keys, values and updatable properties on values.
public final class Store<Key: Hashable, Value, Updatable> {

    /// Returns the store's value for a given key, if a value is present in the store.
    public let get: (_ key: Key) async -> Value?

    /// Returns all values that are present in the store.
    public let getAll: () async -> [Value]

    /// Inserts a new value into the store for a given key.
    public let insert: (_ value: Value, _ key: Key) async -> Void

    /// Updates a property on a value in the store for a given key.
    public let update: (_ value: Updatable, _ key: Key) async -> Void

    /// Removes a value from the store for a given key.
    public let remove: (_ key: Key) async -> Value?

    public init(
        get: @escaping (Key) async -> Value?,
        getAll: @escaping () async -> [Value],
        insert: @escaping (Value, Key) async -> Void,
        update: @escaping (_ value: Updatable, _ key: Key) async -> Void,
        remove: @escaping (Key) async -> Value?
    ) {
        self.get = get
        self.getAll = getAll
        self.insert = insert
        self.update = update
        self.remove = remove
    }
}
