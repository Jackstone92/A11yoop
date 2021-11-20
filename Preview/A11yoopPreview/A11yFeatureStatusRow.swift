//
//  A11yFeatureStatusRow.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import SwiftUI
import Combine
import A11yFeature

struct A11yFeatureStatusRow: View {

    let feature: A11yFeature

    var body: some View {
        VStack(alignment: .leading) {
            Text(feature.type.description)
                .fontWeight(.bold)

            Spacer()

            Text(feature.status.description)
        }
        .opacity(feature.status == .disabled ? 0.3 : 1)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct A11yFeatureStatusRow_Previews: PreviewProvider {
    static var previews: some View {
        A11yFeatureStatusRow(feature: A11yFeature(type: .voiceOver, status: .enabled))
            .previewLayout(.fixed(width: 300, height: 124))
    }
}
