//
//  MainViewModel.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import Foundation
import Combine
import CombineSchedulers
import A11yFeature
import A11yoopMonitor

final class MainViewModel: ObservableObject {

    @Published var features = [A11yFeature]()
    @Published var lastUpdated: Date!

    private var monitor: A11yoopMonitor!
    private let queue = DispatchQueue.global(qos: .background).eraseToAnyScheduler()

    init(featureTypes: [A11yFeatureType] = A11yFeatureType.allCases) {
        monitor = A11yoopMonitor(
            featureTypes: featureTypes,
            emitters: [
                .init { emittedFeature in
                    DispatchQueue.main.async {
                        self.onFeatureStatusChange(emittedFeature)
                    }
                }
            ],
            queue: queue
        )

        // Set initial features
        features = monitor.allFeatures
        lastUpdated = Date()
    }

    private func onFeatureStatusChange(_ emittedFeature: A11yFeature) {
        let updatedFeatures = features.map { feature -> A11yFeature in
            guard feature.type == emittedFeature.type else {
                return feature
            }

            return A11yFeature(type: feature.type, status: emittedFeature.status)
        }

        features = updatedFeatures
        lastUpdated = Date()
    }
}
