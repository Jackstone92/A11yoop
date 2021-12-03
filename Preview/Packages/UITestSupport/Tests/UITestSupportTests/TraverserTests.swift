//
//  TraverserTests.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import XCTest
import UITestSupport

final class TraverserTests: XCTestCase {

    private var sut: Traverser!

    override func setUp() {
        super.setUp()
        sut = Traverser()
    }

    func test_traverseTraversesNestedDrillDownables() {

        var output = [LabelIdentifiable]()

        let level3 = MockDrillDownable(next: nil, label: "level3", value: true)
        let level2 = MockDrillDownable(next: level3, label: "level2", value:  level3)
        let level1 = MockDrillDownable(next: level2, label: "level1", value: level2)
        let root = MockDrillDownable(next: level1, label: "root", value: level1)

        let value = sut.traverse(root, step: { output.append($0) })

        XCTAssertEqual(try XCTUnwrap(value), try XCTUnwrap(DrillDownableValue(level3.value)))
        XCTAssertEqual(
            output.map(\.label),
            [root.label, level1.label, level2.label]
        )
    }

    func test_traverseStopsWhenNextIsNil() {

        var output = [LabelIdentifiable]()

        let root = MockDrillDownable(next: nil, label: "root", value: true)

        let value = sut.traverse(root, step: { output.append($0) })

        XCTAssertEqual(try XCTUnwrap(value), DrillDownableValue.toggleable(true))
        XCTAssertTrue(output.isEmpty)
    }


    func test_traverseReturnsNilForUnexpectedDrillDownableValue() {

        let root = MockDrillDownable(next: nil, label: "root", value: "Unexpected DrillDownableValue type")

        let value = sut.traverse(root, step: { _ in })

        XCTAssertNil(value)
    }
}

// MARK: - Test helpers
private struct MockDrillDownable: DrillDownable {

    var label: String { _label }
    var next: DrillDownable? { _next }
    var value: Any { _value }

    private let _label: String
    private let _next: DrillDownable?
    private let _value: Any

    init(next: DrillDownable?, label: String, value: Any) {
        self._next = next
        self._label = label
        self._value = value
    }
}
