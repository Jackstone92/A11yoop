//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import os.log
import A11yCore
import A11yStatusEmitter

extension A11yStatusEmitter {

    private static let defaultLog = OSLog(subsystem: "com.jackstone.A11yoop", category: "A11yoop")

    public static var log: Self {
        Self(emit: emit)
    }

    private static func emit(_ status: A11yStatus, for featureType: A11yFeatureType) {
        os_log(.default, "%@ updated status to %@", featureType.description, status.description.lowercased())
    }
}
