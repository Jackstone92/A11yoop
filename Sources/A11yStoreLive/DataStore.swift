//
//  DataStore.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

/// A data store that can be used as the underlying storage for an `A11yStore`.
final class DataStore<Key: Hashable, Value> {

    var data = [Key: Value]()
}
