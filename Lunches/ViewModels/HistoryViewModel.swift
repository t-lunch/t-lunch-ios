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
    var globalLogger: GlobalLogger

    @Published var searchText: String
    @Published var lunches: [LunchFeedback]

    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol, globalLogger: GlobalLogger) {
        self.networkManager = networkManager
        self.authManager = authManager
        self.globalLogger = globalLogger

        searchText = ""
        lunches = []
    }

    func fetchData() {
        networkManager.getLunchHistory(userId: Int64(authManager.userId)) { result in
            switch result {
            case let .success(success):
                self.lunches = success.map { lunch in
                    LunchFeedback(lunch: lunch, isLiked: false)
                }
            case let .failure(failure):
                if let description = failure.errorDescription {
                    self.globalLogger.logError(description)
                } else {
                    self.globalLogger.logError("Error while fetching data")
                }
            }
        }
    }
}
