//
//  HistoryView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel

    var authManager: AuthManager
    var networkManager: LunchNetworkManagerProtocol

    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol) {
        self.authManager = authManager
        self.networkManager = networkManager
        _viewModel = StateObject(wrappedValue: HistoryViewModel(authManager: authManager, networkManager: networkManager))
    }

    @State var isLiked: Bool = true
    @State var isLiked1: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    ForEach($viewModel.lunches, id: \.lunch.id) { $lunch in
                        LunchCard(lunch: lunch.lunch, isLiked: $lunch.isLiked)
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            .searchable(text: $viewModel.searchText, prompt: "Поиск")
            .navigationTitle("История")
        }
    }
}

#Preview {
    HistoryView(authManager: AuthManager(), networkManager: FakeLunchNetworkManager(authManager: AuthManager()))
}
