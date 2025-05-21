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
        networkManager.getLunchHistory(userId: IntId(authManager.userId)) { result in
            switch result {
            case let .success(success):
                DispatchQueue.main.async {
                    self.lunches = success
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

    func onLikeAction(_ lunch: LunchFeedback) {
        networkManager.rateLunch(
            userId: IntId(authManager.userId),
            lunchId: lunch.lunch.id,
            isLiked: lunch.isLiked
        ) { response in
            switch response {
            case .success:
                break
            case let .failure(failure):
                if let description = failure.errorDescription {
                    self.globalLogger.logError(description)
                } else {
                    self.globalLogger.logError("Error at rating lunch")
                }
            }
        }
        fetchData()
    }
}
