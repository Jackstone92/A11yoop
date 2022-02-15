//
//  Main.swift
//  Created by Jack Stone in 2021.
//

import SwiftUI
import A11yoopMonitor

struct Main: View {

    @StateObject var viewModel: MainViewModel

    var body: some View {
        NavigationView {
            VStack {
                A11yFeatureStatusList(features: viewModel.features, lastUpdated: viewModel.lastUpdated)
                    .navigationTitle(
                        Text("A11yoop Preview")
                            .accessibilityLabel("Allyoop Preview")
                    )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main(viewModel: MainViewModel(featureTypes: A11yFeatureType.allCases))
    }
}
