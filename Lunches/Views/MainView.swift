//
//  MainView.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import SwiftUI

struct MainView: View {
    var authManager: AuthManager
    var networkManager: LunchNetworkManagerProtocol
    
    var body: some View {
        TabView {
            HomeView(authManager: authManager,
                     networkManager: networkManager)
            .tabItem {
                Image(systemName: "house")
                Text("Главная")
            }
            HistoryView(authManager: authManager,
                        networkManager: networkManager)
            .tabItem {
                Image(systemName: "clock")
                Text("История")
            }
            ProfileView(authManager: authManager,
                        networkManager: networkManager)
            .tabItem {
                Image(systemName: "person")
                Text("Профиль")
            }
        }
    }
}
