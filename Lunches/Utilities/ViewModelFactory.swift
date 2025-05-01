//
//  ViewModelFactory.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import Foundation

final class ViewModelFactory {
    static let previewContent = ViewModelFactory.makePreview()
    
    private let authManager: AuthManager
    private let networkManager: LunchNetworkManagerProtocol
    private let globalLogger: GlobalLogger
    
    private init(authManager: AuthManager,
                 networkManager: LunchNetworkManagerProtocol,
                 globalLogger: GlobalLogger) {
        self.authManager = authManager
        self.networkManager = networkManager
        self.globalLogger = globalLogger
    }
    
    // Основная фабрика для App
    static func makeLive() -> ViewModelFactory {
        let auth = AuthManager()
        let network = LunchNetworkManager(
            service: APIService(urlSession: .shared),
            authManager: auth
        )
        let logger = GlobalLogger(label: "com.lunches.globalError")
        return ViewModelFactory(authManager: auth, networkManager: network, globalLogger: logger)
    }
    
    // Preview-фабрика
    static func makePreview() -> ViewModelFactory {
        let auth = AuthManager()
        let fakeNetwork = FakeLunchNetworkManager(authManager: auth)
        let logger = GlobalLogger(label: "preview.globalError")
        return ViewModelFactory(authManager: auth, networkManager: fakeNetwork, globalLogger: logger)
    }

    init() {
        authManager = AuthManager()
//        networkManager = LunchNetworkManager(service: APIService(urlSession: URLSession.shared), authManager: authManager)
        networkManager = FakeLunchNetworkManager(authManager: authManager)
        globalLogger = GlobalLogger(label: "com.lunches.globalError")
    }
    
    func makeContentViewModel() -> ContentViewModel {
        return ContentViewModel(
            authManager: authManager,
            globalLogger: globalLogger,
            makeMainViewModel: makeMainViewModel,
            makeLoginViewModel: makeLoginViewModel
        )
    }

    func makeHistoryViewModel() -> HistoryViewModel {
        return HistoryViewModel(
            authManager: authManager,
            networkManager: networkManager,
            globalLogger: globalLogger
        )
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(
            authManager: authManager,
            networkManager: networkManager,
            globalLogger: globalLogger
        )
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(
            networkManager: networkManager,
            globalLogger: globalLogger,
            makeSignUpViewModel: makeSignUpViewModel
        )
    }
    
    func makeMainViewModel() -> MainViewModel {
        return MainViewModel(
            authManager: authManager,
            networkManager: networkManager,
            makeHomeViewModel: makeHomeViewModel,
            makeHistoryViewModel: makeHistoryViewModel,
            makeProfileViewModel: makeProfileViewModel
        )
    }
    
    func makeProfileRedactViewModel() -> ProfileRedactViewModel {
        return ProfileRedactViewModel(
            authManager: authManager,
            networkManager: networkManager,
            globalLogger: globalLogger
        )
    }
    
    func makeProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(
            authManager: authManager,
            networkManager: networkManager,
            makeProfileRedactView: makeProfileRedactViewModel
        )
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel(
            networkManager: networkManager,
            globalLogger: globalLogger,
            makeLoginViewModel: makeLoginViewModel
        )
    }
}

