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

    let makeProfileRedactView: () -> ProfileRedactViewModel

    @Published var errorMessage: String?

    @Published var name: String
    @Published var surname: String
    @Published var tgContact: String?
    @Published var emojiIcon: String?

    init(
        authManager: AuthManager,
        networkManager: LunchNetworkManagerProtocol,
        makeProfileRedactView: @escaping () -> ProfileRedactViewModel
    ) {
        self.networkManager = networkManager
        self.authManager = authManager
        self.makeProfileRedactView = makeProfileRedactView

        name = ""
        surname = ""
        tgContact = ""
        emojiIcon = ""
    }

    func fetchData() {
        networkManager.getProfile(userId: IntId(authManager.userId)) { result in
            switch result {
            case let .success(user):
                self.name = user.name
                self.surname = user.surname
                self.tgContact = user.tg
                self.emojiIcon = user.emoji
            case let .failure(error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
