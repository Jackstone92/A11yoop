//
//  MainViewModel.swift
//  Created by Jack Stone in 2021.
//

import Foundation
import Combine
import A11yFeature
import A11yoopMonitor

final class MainViewModel: ObservableObject {

    @Published var features = [A11yFeature]()
    @Published var lastUpdated: Date!

    private var monitor: A11yoopMonitor!

    init(featureTypes: [A11yFeatureType] = A11yFeatureType.allCases) {
        monitor = A11yoopMonitor(
            featureTypes: featureTypes,
            emitters: [
                .init(emit: { emittedFeature in
                    let updatedFeatures = self.features.map { feature -> A11yFeature in
                        guard feature.type == emittedFeature.type else {
                            return feature
                        }

                        return A11yFeature(type: feature.type, status: emittedFeature.status)
                    }
                    
                    self.features = updatedFeatures
                    self.lastUpdated = Date()
                }),
                .log()
            ]
        )

        // Set initial features
        features = monitor.allFeatures
        lastUpdated = Date()
    }
}
