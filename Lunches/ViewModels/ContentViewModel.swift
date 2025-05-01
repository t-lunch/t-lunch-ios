//
//  ContentViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @ObservedObject private var authManager: AuthManager
    @ObservedObject private var globalLogger: GlobalLogger
    
    let makeMainViewModel: () -> MainViewModel
    let makeLoginViewModel: () -> LoginViewModel
    
    @Published var globalError: String? = nil
    @Published var isAuthorized: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    init(
        authManager: AuthManager,
        globalLogger: GlobalLogger,
        makeMainViewModel: @escaping () -> MainViewModel,
        makeLoginViewModel: @escaping () -> LoginViewModel
    ) {
        self.authManager = authManager
        self.globalLogger = globalLogger
        self.makeMainViewModel = makeMainViewModel
        self.makeLoginViewModel = makeLoginViewModel
        
        globalLogger.$globalError
            .receive(on: DispatchQueue.main)
            .assign(to: &$globalError)
        
        authManager.$isAuthorized
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.isAuthorized, on: self)
                    .store(in: &cancellables)
    }

    func clearError() {
        globalLogger.clearError()
    }
}
