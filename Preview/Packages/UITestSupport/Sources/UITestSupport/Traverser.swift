//
//  Traverser.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public struct Traverser {

    public init() {}

    public func traverse(_ start: DrillDownable, step: @escaping (LabelIdentifiable) -> Void) -> DrillDownableValue? {
        var traversal = start

        while traversal.next != nil {
            step(traversal)
            traversal = traversal.next!
        }

        return DrillDownableValue(traversal.value)
    }
}
