//
//  SignUpViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
    @Published var login: String
    @Published var password: String
    
    @Published var name: String
    @Published var surname: String
    @Published var tgContact: String
    
    @Published var isPasswordFieldSecured: Bool
    
    init() {
        self.login = ""
        self.password = ""
        
        self.name = ""
        self.surname = ""
        self.tgContact = ""
        
        self.isPasswordFieldSecured = true
    }
    
    func signInButtonAction() -> Bool {
        true
    }
}
