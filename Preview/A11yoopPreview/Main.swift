//
//  Main.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import SwiftUI
import A11yFeature

struct Main: View {

    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            A11yFeatureStatusList(features: viewModel.features)
                .navigationTitle("A11yoop Preview")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main(viewModel: MainViewModel(featureTypes: A11yFeatureType.allCases))
    }
}
