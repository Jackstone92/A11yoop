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

    @Published var features = [A11yFeature]()

    private var monitor: A11yoopMonitor!

    init(featureTypes: [A11yFeatureType] = A11yFeatureType.allCases) {
        self.monitor = .live(
            featureTypes: featureTypes,
            statusManager: .live(
                featureStore: .live,
                notificationCenter: .default
            ),
            emitters: [
                .init(emit: { emittedFeature in
                    let updatedFeatures = self.features.map { feature -> A11yFeature in
                        guard feature.type == emittedFeature.type else {
                            return feature
                        }

                        return A11yFeature(type: feature.type, status: emittedFeature.status)
                    }
                    
                    self.features = updatedFeatures
                })
            ],
            statusProvider: .live
        )

        // Set initial features
        features = monitor.featuresSubject.value
    }
}
