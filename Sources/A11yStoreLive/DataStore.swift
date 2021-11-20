//
//  DataStore.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

final class DataStore<Key: Hashable, Value> {

    var data = [Key: Value]()
}
