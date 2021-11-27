//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine

public struct A11yFeature: Identifiable {

    public let id = UUID()

    public let type: A11yFeatureType
    public var status: A11yStatus

    public init(type: A11yFeatureType, status: A11yStatus) {
        self.type = type
        self.status = status
    }
}

extension A11yFeature: Equatable {

    public static func == (lhs: A11yFeature, rhs: A11yFeature) -> Bool {
        lhs.type == rhs.type && lhs.status == rhs.status
    }
}
