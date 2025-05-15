//
//  MainView.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        TabView {
            HomeView(viewModel: viewModel.makeHomeViewModel())
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }
            HistoryView(viewModel: viewModel.makeHistoryViewModel())
                .tabItem {
                    Image(systemName: "clock")
                    Text("История")
                }
            ProfileView(viewModel: viewModel.makeProfileViewModel())
                .tabItem {
                    Image(systemName: "person")
                    Text("Профиль")
                }
        }
    }
}
