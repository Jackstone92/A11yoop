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
                guard data[$1] == nil else { return }
                data[$1] = $0
            },
            remove: {
                data.removeValue(forKey: $0)
            }
        )
    }
}
