//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public final class Store<Key: Hashable, Value> {

    public let get: (_ key: Key) -> Value?
    public let insert: (_ value: Value, _ key: Key) -> Void
    public let remove: (_ key: Key) -> Void

    public init(
        get: @escaping (Key) -> Value?,
        insert: @escaping (Value, Key) -> Void,
        remove: @escaping (Key) -> Void
    ) {
        self.get = get
        self.insert = insert
        self.remove = remove
    }
}
