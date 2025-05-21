//
//  ProfileRedactViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

final class ProfileRedactViewModel: ObservableObject {
    var authManager: AuthManager
    var networkManager: LunchNetworkManagerProtocol
    var globalLogger: GlobalLogger

    @Published var name: String
    @Published var surname: String
    @Published var tgContact: String
    @Published var emojiIcon: String

    @Published var office: String

    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol, globalLogger: GlobalLogger) {
        self.authManager = authManager
        self.networkManager = networkManager
        self.globalLogger = globalLogger

        name = ""
        surname = ""
        tgContact = ""
        emojiIcon = ""

        office = ""
    }

    func fetchData() {
        networkManager.getProfile(userId: IntId(authManager.userId)) { result in
            switch result {
            case let .success(user):
                DispatchQueue.main.async {
                    self.name = user.name
                    self.surname = user.surname
                    self.tgContact = user.tg
                    self.emojiIcon = user.emoji

                    self.office = user.office
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

    func saveButtonAction() {
        networkManager.changeProfile(user: User(userId: authManager.userId, name: name, surname: surname, tg: tgContact, office: office, emoji: emojiIcon)) { response in
            switch response {
            case let .success(success):
                self.globalLogger.logInfo("User \(success.userId) changed profile")
            case let .failure(failure):
                if let description = failure.errorDescription {
                    self.globalLogger.logError(description)
                } else {
                    self.globalLogger.logError("Error at changing profile")
                }
            }
        }
    }

    func logOutAction() {
        authManager.clearTokens()
    }
}
