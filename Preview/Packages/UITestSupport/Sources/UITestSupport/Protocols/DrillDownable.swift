//
//  DrillDownable.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation

public protocol DrillDownable: LabelIdentifiable {
    var next: DrillDownable? { get }
    var value: Any { get }
}

extension DrillDownable {

    public var next: DrillDownable? { value as? DrillDownable }
}
