//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature

public class A11yStatusProvider {

    public let getStatus: (_ type: A11yFeatureType) -> A11yStatus

    public required init(getStatus: @escaping (A11yFeatureType) -> A11yStatus) {
        self.getStatus = getStatus
    }
}
