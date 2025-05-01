//
//  SignUpViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
    let networkManager: LunchNetworkManagerProtocol
    let globalLogger: GlobalLogger

    let makeLoginViewModel: () -> LoginViewModel

    @Published var email: String
    @Published var password: String

    @Published var name: String
    @Published var surname: String
    @Published var tgContact: String

    @Published var emoji: String // not in view
    @Published var office: String // not in view

    @Published var isPasswordFieldSecured: Bool

    init(
        networkManager: LunchNetworkManagerProtocol,
        globalLogger: GlobalLogger,
        makeLoginViewModel: @escaping () -> LoginViewModel
    ) {
        self.networkManager = networkManager
        self.globalLogger = globalLogger
        self.makeLoginViewModel = makeLoginViewModel

        email = ""
        password = ""

        name = ""
        surname = ""
        tgContact = ""

        emoji = ""
        office = ""

        isPasswordFieldSecured = true
    }

    func signInButtonAction() {
        networkManager.registration(request: RegistrationRequest(name: name, surname: surname, tg: tgContact, office: office, emoji: emoji, email: email, password: password)) { response in
            switch response {
            case .success(let success):
                self.globalLogger.logInfo("User \(success.userId) logged in")
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
