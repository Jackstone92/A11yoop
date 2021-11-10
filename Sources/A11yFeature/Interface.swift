//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine

public struct A11yFeature {

    public typealias ObservationResult = AnyPublisher<A11yFeatureObservation, Never>

    public let type: A11yFeatureType
    public var status: A11yStatus
    public let observeChanges: () -> ObservationResult

    public init(
        type: A11yFeatureType,
        status: A11yStatus,
        observeChanges: @escaping () -> ObservationResult
    ) {
        self.type = type
        self.status = status
        self.observeChanges = observeChanges
    }
}

extension A11yFeature: Equatable {

    public static func == (lhs: A11yFeature, rhs: A11yFeature) -> Bool {
        lhs.type == rhs.type && lhs.status == rhs.status
    }
}
