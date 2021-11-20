//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public final class Store<Key: Hashable, Value, Updatable> {

    public let get: (_ key: Key) -> Value?
    public let getAll: () -> [Value]
    public let insert: (_ value: Value, _ key: Key) -> Void
    public let update: (_ value: Updatable, _ key: Key) -> Void
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
