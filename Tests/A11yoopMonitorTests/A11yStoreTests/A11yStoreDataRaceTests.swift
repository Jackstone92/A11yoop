//
//  A11yStoreDataRaceTests.swift
//  Created by Jack Stone in 2022.
//

import XCTest
@testable import A11yoopMonitor

final class A11yStoreDataRaceTests: XCTestCase {

    private var sut: FeatureStore!
    private var group: DispatchGroup!

    private let type: A11yFeatureType = .boldText
    private lazy var feature = A11yFeature(type: type, status: .disabled)

    override func setUp() {
        super.setUp()

        sut = .live
        group = DispatchGroup()
    }

    func test_preventGetDataRace() {

        sut.insert(feature, type)

        XCTAssertNotNil(sut.get(type))

        assert {
            let status = self.sut.get(self.type)?.status

            self.sut.update(status == .disabled ? .enabled : .disabled, self.type)
        }
    }

    func test_preventGetAllDataRace() {

        sut.insert(feature, type)

        XCTAssertNotNil(sut.get(type))

        assert {
            let status = self.sut.getAll().first?.status

            self.sut.update(status == .disabled ? .enabled : .disabled, self.type)
        }
    }

    func test_preventInsertDataRace() {

        assert {
            let randomType = A11yFeatureType.allCases.randomElement()!
            let feature = A11yFeature(type: randomType, status: .disabled)

            self.sut.insert(feature, randomType)
        }
    }

    func test_preventUpdateDataRace() {

        sut.insert(feature, type)

        XCTAssertNotNil(sut.get(type))

        assert {
            let status = self.sut.get(self.type)?.status

            self.sut.update(status == .disabled ? .enabled : .disabled, self.type)
        }
    }

    func test_preventRemoveDataRace() {

        A11yFeatureType.allCases.forEach {
            sut.insert(A11yFeature(type: $0, status: .disabled), $0)
        }

        XCTAssertFalse(sut.getAll().isEmpty)

        assert {
            let randomType = A11yFeatureType.allCases.randomElement()!

            _ = self.sut.remove(randomType)
        }
    }

    private func assert(_ closure: @escaping () -> Void) {

        (0..<1000).forEach { _ in
            group.enter()

            DispatchQueue.global().async {
                let sleepVal = arc4random() % 1000
                usleep(sleepVal)

                closure()

                self.group.leave()
            }
        }

        let result = group.wait(timeout: .now() + 5)

        XCTAssertEqual(result, .success)
    }
}
