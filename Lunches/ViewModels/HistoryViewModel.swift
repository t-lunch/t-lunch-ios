//
//  HistoryViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    var networkManager: LunchNetworkManagerProtocol
    var authManager: AuthManager

    @Published var searchText: String
    @Published var lunches: [LunchFeedback]

    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol) {
        self.networkManager = networkManager
        self.authManager = authManager

        searchText = ""
        lunches = []
    }

    func fetchData() {
        networkManager.getLunchHistory(userId: Int64(authManager.userId)) { response in
            self.lunches = response.map { lunch in
                LunchFeedback(lunch: lunch, isLiked: false)
            }
        }
    }
}
