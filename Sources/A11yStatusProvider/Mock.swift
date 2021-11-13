//
//  Mock.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import A11yFeature

extension A11yStatusProvider {

    public static var enabled: Self {
        Self { _ in .enabled }
    }

    public static var disabled: Self {
        Self { _ in .disabled }
    }
}
