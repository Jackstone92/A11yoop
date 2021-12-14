//
//  Main.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import SwiftUI
import A11yFeature

struct Main: View {

    @StateObject var viewModel: MainViewModel

    var body: some View {
        NavigationView {
            VStack {
                A11yFeatureStatusList(features: viewModel.features, lastUpdated: viewModel.lastUpdated)
                    .navigationTitle("A11yoop Preview")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main(viewModel: MainViewModel(featureTypes: A11yFeatureType.allCases))
    }
}
