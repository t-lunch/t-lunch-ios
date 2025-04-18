//
//  SignUpViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
    let networkManager: LunchNetworkManagerProtocol
    
    @Published var email: String
    @Published var password: String
    
    @Published var name: String
    @Published var surname: String
    @Published var tgContact: String
    
    @Published var emoji: String // not in view
    @Published var office: String // not in view
    
    @Published var isPasswordFieldSecured: Bool
    
    init(networkManager: LunchNetworkManagerProtocol) {
        self.networkManager = networkManager
        
        self.email = ""
        self.password = ""
        
        self.name = ""
        self.surname = ""
        self.tgContact = ""
        
        self.emoji = ""
        self.office = ""
        
        self.isPasswordFieldSecured = true
    }
    
    
    func signInButtonAction() {
        networkManager.registration(request: RegistrationRequest(name: name, surname: surname, tg: tgContact, office: office, emoji: emoji, email: email, password: password)) { responce in
            print(responce as Any)
        }
    }
}
