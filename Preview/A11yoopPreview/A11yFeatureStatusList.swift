//
//  A11yFeatureStatusList.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import SwiftUI
import A11yFeature

struct A11yFeatureStatusList: View {

    let features: [A11yFeature]

    var body: some View {
        List {
            Section("Enabled features") {
                ForEach(features.filter { $0.status != .disabled }) { feature in
                    A11yFeatureStatusRow(feature: feature)
                }
            }

            Section("Disabled features") {
                ForEach(features.filter { $0.status == .disabled }) { feature in
                    A11yFeatureStatusRow(feature: feature)
                }
            }
        }
    }
}

struct A11yFeatureStatusList_Previews: PreviewProvider {
    static var previews: some View {
        A11yFeatureStatusList(
            features: [
                A11yFeature(type: .guidedAccess, status: .enabled),
                A11yFeature(type: .voiceOver, status: .disabled)
            ]
        )
    }
}
