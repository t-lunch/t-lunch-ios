//
//  ContentView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
}

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

struct MainView: View {
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
