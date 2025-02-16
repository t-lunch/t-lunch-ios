//
//  ContentView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if #available(iOS 18.0, *){
            TabView {
                Tab("Главная", systemImage: "house") {
                    HomeView()
                }
                Tab("Главная", systemImage: "clock") {
                    HistoryView()
                }
                Tab("Профиль", systemImage: "person") {
                    ProfileView()
                }
            }
        } else {
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
}

#Preview {
    ContentView()
}
