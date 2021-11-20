//
//  ObservationResult+Stub.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine

extension A11yFeature.ObservationResult {

    public static func stub(with feature: A11yFeature = A11yFeature(type: .voiceOver, status: .disabled)) -> Self {
        Just(feature).eraseToAnyPublisher()
    }
}
