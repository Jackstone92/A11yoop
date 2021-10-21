//
//  Store+FeatureStore.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yCore
import A11yStore

public typealias FeatureStore = Store<A11yFeatureType, A11yStatus>

extension FeatureStore {

    public static var live: Self {

        var data = [Key: Value]()

        return Self(
            get: {
                data[$0]
            },
            insert: {
                assert(data[$1] == nil, "Unable to insert as value already exists for \($1)")
                data[$1] = $0
            },
            update: {
                assert(data[$1] != nil, "Value to be updated for \($1) does not exist")
                data[$1] = $0
            },
            remove: {
                assert(data[$0] != nil, "Value to be removed for \($0) does not exist")
                data.removeValue(forKey: $0)
            }
        )
    }
}
