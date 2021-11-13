//
//  MainViewModel.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import A11yFeature
import A11yoopMonitor
import A11yoopMonitorLive

final class MainViewModel: ObservableObject {

    @Published var features: [A11yFeature]

    let monitor: A11yoopMonitor

    init(featureTypes: [A11yFeatureType] = A11yFeatureType.allCases) {
        self.monitor = .live(featureTypes: featureTypes)
        self.features = monitor.features
    }
}
