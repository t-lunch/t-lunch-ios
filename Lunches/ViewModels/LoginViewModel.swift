//
//  LoginViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var login: String
    @Published var password: String
    
    @Published var isPasswordFieldSecured: Bool
    
    init() {
        self.login = ""
        self.password = ""
        
        self.isPasswordFieldSecured = true
    }
    
    func loginButtonAction() -> Bool {
        true
    }
}
