//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import A11yCore

public struct A11yStatusEmitter {

    public let emit: (_ status: A11yStatus, _ featureType: A11yFeatureType) -> Void

    public init(emit: @escaping (A11yStatus, A11yFeatureType) -> Void) {
        self.emit = emit
    }
}
