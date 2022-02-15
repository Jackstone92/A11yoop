//
//  Live.swift
//  Created by Jack Stone in 2021.
//

import os.log

extension A11yStatusEmitter {

    public typealias LogHandler = (_ type: OSLogType,
                                   _ log: OSLog,
                                   _ message: StaticString,
                                   _ featureDescription: CVarArg,
                                   _ statusDescription: CVarArg) -> Void

    private static let defaultLog = OSLog(subsystem: "com.jackstone.A11yoop", category: "A11yoop")

    public static var defaultLogHandler: LogHandler = { type, log, message, featureDescription, statusDescription in
        os_log(message, log: log, type: type, featureDescription, statusDescription)
    }

    /// A status emitter configuration that prints any accessibility feature status changes to system logs.
    ///
    /// - Parameter level: The log level at which to log accessibility feature status changes.
    /// - Parameter handler: A log handler that receives corresponding logging parameters to log.
    ///                      By default, these details are logged using `os_log`.
    ///
    ///  - Returns: The log status emitter instance.
    ///
    public static func log(level: OSLogType = .default, handler: @escaping LogHandler = defaultLogHandler) -> Self {
        Self { feature in
            emit(feature.status, for: feature.type, at: level, logHandler: handler)
        }
    }

    private static func emit(
        _ status: A11yStatus,
        for featureType: A11yFeatureType,
        at level: OSLogType,
        logHandler: LogHandler
    ) {
        logHandler(
            level,
            defaultLog,
            "\"%{public}@\" accessibility feature status was updated to \"%{public}@\"",
            featureType.description,
            status.description.lowercased()
        )
    }
}
