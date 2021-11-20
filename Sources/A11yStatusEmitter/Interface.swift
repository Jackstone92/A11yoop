//
//  Interface.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import A11yFeature

public struct A11yStatusEmitter {

    public let emit: (_ feature: A11yFeature) -> Void

    public init(emit: @escaping (A11yFeature) -> Void) {
        self.emit = emit
    }
}
