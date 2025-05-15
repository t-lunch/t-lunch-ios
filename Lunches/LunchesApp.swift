//
//  LunchesApp.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

@main
struct LunchesApp: App {
    private var viewModelFactory: ViewModelFactory = .makeLive()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModelFactory.makeContentViewModel())
        }
    }
}
