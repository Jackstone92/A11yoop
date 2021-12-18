//
//  A11yoopPreviewApp.swift
//  Copyright © 2021 Notonthehighstreet Enterprises Limited. All rights reserved.
//

import SwiftUI

@main
struct A11yoopPreviewApp: App {
    var body: some Scene {
        WindowGroup {
            Main(viewModel: MainViewModel())
        }
    }
}
