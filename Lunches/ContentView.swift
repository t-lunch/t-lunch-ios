//
//  ContentView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if !viewModel.isLoggedIn {
                LoginView()
            } else {
                MainView()
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
