//
//  A11yStatusEmitterTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import os.log
import A11yFeature
import A11yStatusEmitter
import A11yStatusEmitterLive

final class A11yStatusEmitterTests: XCTestCase {

    private typealias LogHandler = A11yStatusEmitter.LogHandler

    private var sut: A11yStatusEmitter!

    func test_emitFormatting() {

        var emitted = [(type: OSLogType,
                        log: OSLog,
                        message: StaticString,
                        args: [CVarArg])]()
        var didEmit = false
        let featureToEmit = A11yFeature(type: .voiceOver, status: .enabled)

        sut = .log { type, log, message, args in
            emitted.append((type, log, message, args))
            didEmit = true
        }

        sut.emit(featureToEmit)

        XCTAssertTrue(didEmit)
        XCTAssertEqual(emitted.count, 1)
        XCTAssertEqual(emitted.first?.type, .default)
        XCTAssertEqual(emitted.first?.log, OSLog(subsystem: "com.jackstone.A11yoop", category: "A11yoop"))
    }
}
