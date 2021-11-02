//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public final class Store<Key: Hashable, Value> {

    public let get: (_ key: Key) -> Value?
    public let insert: (_ value: Value, _ key: Key) -> Void
    public let update: (Value, Key) -> Void
    public let remove: (_ key: Key) -> Value?

    public init(
        get: @escaping (Key) -> Value?,
        insert: @escaping (Value, Key) -> Void,
        update: @escaping (Value, Key) -> Void,
        remove: @escaping (Key) -> Value?
    ) {
        self.get = get
        self.insert = insert
        self.update = update
        self.remove = remove
    }
}
