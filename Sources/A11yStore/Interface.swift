//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public final class Store<Key: Hashable, Value> {

    public let get: (_ key: Key) -> Value?
    public let insert: (_ value: Value, _ key: Key) throws -> Void
    public let update: (Value, Key) throws -> Void
    public let remove: (_ key: Key) throws -> Void

    public init(
        get: @escaping (Key) -> Value?,
        insert: @escaping (Value, Key) throws -> Void,
        update: @escaping (Value, Key) throws -> Void,
        remove: @escaping (Key) throws -> Void
    ) {
        self.get = get
        self.insert = insert
        self.update = update
        self.remove = remove
    }
}
