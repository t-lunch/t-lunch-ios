//
//  MainView.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }
            HistoryView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("История")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Профиль")
                }
        }
    }
}
