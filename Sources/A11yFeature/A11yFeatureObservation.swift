//
//  A11yFeatureObservation.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine

public struct A11yFeatureObservation: Equatable {

    public let type: A11yFeatureType
    public let status: A11yStatus

    public init(type: A11yFeatureType, status: A11yStatus) {
        self.type = type
        self.status = status
    }
}
