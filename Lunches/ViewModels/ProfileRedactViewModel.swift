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
    
    @Published var name: String
    @Published var surname: String
    @Published var tgContact: String
    @Published var emojiIcon: String
    
    @Published var office: String
    
    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol) {
        self.authManager = authManager
        self.networkManager = networkManager
        
        self.name = ""
        self.surname = ""
        self.tgContact = ""
        self.emojiIcon = ""
        
        self.office = ""
    }
    
    func fetchData() {
        networkManager.getProfile(userId: Int64(authManager.userId)) { user in
            if let user = user {
                self.name = user.name
                self.surname = user.surname
                self.tgContact = user.tg
                self.emojiIcon = user.emoji
                
                self.office = user.office
            }
        }
    }
    
    func saveButtonAction() {
        networkManager.changeProfile(user: User(userId: 1, name: name, surname: surname, tg: tgContact, office: office, emoji: emojiIcon)) { _ in }
    }
    
    func logOutAction() {
        authManager.clearTokens()
    }
}
