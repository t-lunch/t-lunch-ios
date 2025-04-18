//
//  ProfileViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    var networkManager: LunchNetworkManagerProtocol
    var authManager: AuthManager

    @Published var name: String
    @Published var surname: String
    @Published var tgContact: String?
    @Published var emojiIcon: String?

    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol) {
        self.networkManager = networkManager
        self.authManager = authManager

        name = ""
        surname = ""
        tgContact = ""
        emojiIcon = ""
    }

    func fetchData() {
        networkManager.getProfile(userId: Int64(authManager.userId)) { user in
            if let user = user {
                self.name = user.name
                self.surname = user.surname
                self.tgContact = user.tg
                self.emojiIcon = user.emoji
            }
        }
    }
}
