//
//  Store+FeatureStore.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature
import A11yStore

public typealias FeatureStore = Store<A11yFeatureType, A11yStatus>

public enum FeatureStoreError: Swift.Error, Equatable {
    case insertError(key: A11yFeatureType)
    case updateError(key: A11yFeatureType)
    case removeError(key: A11yFeatureType)
}

extension FeatureStore {

    public static var live: Self {

        var data = [Key: Value]()

        return Self(
            get: {
                data[$0]
            },
            insert: {
                guard data[$1] == nil else {
                    throw FeatureStoreError.insertError(key: $1)
                }

                data[$1] = $0
            },
            update: {
                guard data[$1] != nil else {
                    throw FeatureStoreError.updateError(key: $1)
                }

                data[$1] = $0
            },
            remove: {
                guard data[$0] != nil else {
                    throw FeatureStoreError.removeError(key: $0)
                }

                data.removeValue(forKey: $0)
            }
        )
    }
}

extension FeatureStoreError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .insertError(let key): return "Unable to insert as value already exists for \(key)"
        case .updateError(let key): return "Value to be updated for \(key) does not exist"
        case .removeError(let key): return "Value to be removed for \(key) does not exist"
        }
    }
}
