//
//  LoginViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    let networkManager: LunchNetworkManagerProtocol

    @Published var email: String
    @Published var password: String

    @Published var isPasswordFieldSecured: Bool

    init(networkManager: LunchNetworkManagerProtocol) {
        self.networkManager = networkManager

        email = ""
        password = ""

        isPasswordFieldSecured = true
    }

    func loginButtonAction() {
        networkManager.login(request: LoginRequest(email: email, password: password)) { _ in }
    }
}
