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

        let level3 = MockDrillDownable(next: nil, label: "level3")
        let level2 = MockDrillDownable(next: level3, label: "level2")
        let level1 = MockDrillDownable(next: level2, label: "level1")
        let root = MockDrillDownable(next: level1, label: "root")

        let leaf = sut.traverse(root, step: { output.append($0) })

        XCTAssertEqual(leaf.label, level3.label)
        XCTAssertEqual(
            output.map(\.label),
            [root.label, level1.label, level2.label, level3.label]
        )
    }

    func test_traverseStopsWhenNextIsNil() {

        var output = [LabelIdentifiable]()

        let root = MockDrillDownable(next: nil, label: "root")

        let leaf = sut.traverse(root, step: { output.append($0) })

        XCTAssertEqual(leaf.label, root.label)
        XCTAssertEqual(output.map(\.label), [root.label])
    }
}

// MARK: - Test helpers
private struct MockDrillDownable: DrillDownable {

    var label: String { _label }
    var next: DrillDownable? { _next }

    private let _label: String
    private let _next: DrillDownable?

    init(next: DrillDownable?, label: String) {
        self._next = next
        self._label = label
    }
}
