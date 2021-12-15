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

    private var sut: A11yStatusEmitter!

    func test_emitFormatting() {

        var emitted = [(type: OSLogType,
                        log: OSLog,
                        message: StaticString,
                        featureDescription: CVarArg,
                        statusDescription: CVarArg)]()
        let featureToEmit = A11yFeature(type: .voiceOver, status: .enabled)

        sut = .log { type, log, message, featureDescription, statusDescription in
            emitted.append((type, log, message, featureDescription, statusDescription))
        }

        sut.emit(featureToEmit)

        XCTAssertEqual(emitted.count, 1)
        XCTAssertEqual(emitted.first?.type, .default)
        XCTAssertEqual(emitted.first?.log, OSLog(subsystem: "com.jackstone.A11yoop", category: "A11yoop"))
        XCTAssertEqual(
            emitted.first?.message.description,
            "\"%{public}@\" accessibility feature status was updated to \"%{public}@\""
        )
    }

    func test_logLevelCanBeSpecified() {

        var output = [OSLogType]()
        let featureToEmit = A11yFeature(type: .voiceOver, status: .enabled)

        sut = .log(level: .info) { type, _, _, _, _ in output.append(type) }

        sut.emit(featureToEmit)

        XCTAssertEqual(output, [.info])
    }

    func test_usesDefaultLevelByDefault() {

        var output = [OSLogType]()
        let featureToEmit = A11yFeature(type: .voiceOver, status: .enabled)

        sut = .log { type, _, _, _, _ in output.append(type) }

        sut.emit(featureToEmit)

        XCTAssertEqual(output, [.default])
    }
}
