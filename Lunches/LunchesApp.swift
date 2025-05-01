//
//  LunchesApp.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

@main
struct LunchesApp: App {
    var viewModelFactory: ViewModelFactory = .makePreview()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModelFactory.makeContentViewModel())
        }
    }
}
