//
//  LoginViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    let networkManager: LunchNetworkManagerProtocol
    let globalLogger: GlobalLogger
    let makeSignUpViewModel: () -> SignUpViewModel

    @Published var email: String
    @Published var password: String

    @Published var isPasswordFieldSecured: Bool

    init(networkManager: LunchNetworkManagerProtocol, globalLogger: GlobalLogger, makeSignUpViewModel: @escaping () -> SignUpViewModel) {
        self.networkManager = networkManager
        self.globalLogger = globalLogger
        self.makeSignUpViewModel = makeSignUpViewModel

        email = ""
        password = ""

        isPasswordFieldSecured = true
    }

    func loginButtonAction() {
        networkManager.login(request: LoginRequest(email: email, password: password)) { response in
            switch response {
            case .success:
                self.globalLogger.logInfo("User logged in")
            case .failure(let failure):
                if let description = failure.errorDescription {
                    self.globalLogger.logError(description)
                } else {
                    self.globalLogger.logError("Error at signing-up")
                }
            }
        }
    }
}
