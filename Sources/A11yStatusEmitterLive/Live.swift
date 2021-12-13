//
//  Live.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import os.log
import A11yFeature
import A11yStatusEmitter

extension A11yStatusEmitter {

    public typealias LogHandler = (_ type: OSLogType,
                                   _ log: OSLog,
                                   _ message: StaticString,
                                   _ args: [CVarArg]) -> Void

    private static let defaultLog = OSLog(subsystem: "com.jackstone.A11yoop", category: "A11yoop")

    public static var defaultLogHandler: LogHandler = { type, log, message, args in
        os_log(message, log: log, type: type, args)
    }

    /// A status emitter configuration that prints any accessibility feature status changes to system logs.
    ///
    /// - Parameter handler: A log handler that receives corresponding logging parameters to log.
    ///                      By default, these details are logged using `os_log`.
    ///
    ///  - Returns: The log status emitter instance.
    ///
    public static func log(handler: @escaping LogHandler = defaultLogHandler) -> Self {

        return Self { feature in
            emit(feature.status, for: feature.type, logHandler: handler)
        }
    }

    private static func emit(_ status: A11yStatus, for featureType: A11yFeatureType, logHandler: LogHandler) {
        logHandler(.default, defaultLog, "%{public}@ updated status to %{public}@", [featureType.description, status.description.lowercased()])
    }
}
