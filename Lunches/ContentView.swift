//
//  ContentView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    @ObservedObject var authManager: AuthManager
    var networkManager: LunchNetworkManagerProtocol
    
    init(appCoordinator: AppCoordinator) {
        authManager = appCoordinator.authManager
        networkManager = appCoordinator.networkManager
        _viewModel = StateObject(wrappedValue: ContentViewModel(authManager: appCoordinator.authManager))
    }
    
    var body: some View {
        Group {
            if !viewModel.isAuthorized {
                LoginView(networkManager: networkManager)
            } else {
                MainView()
            }
        }
    }
}

#Preview {
    ContentView(appCoordinator: AppCoordinator())
}
