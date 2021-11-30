//
//  Traverser.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public struct Traverser {

    public func traverse(_ start: DrillDownable, step: (LabelIdentifiable) -> Void) -> DrillDownable {
        var traversal = start
        step(traversal)

        while true {
            guard traversal.next != nil else { break }

            traversal = traversal.next!
            step(traversal)
        }

        return traversal
    }

    public init() {}
}
