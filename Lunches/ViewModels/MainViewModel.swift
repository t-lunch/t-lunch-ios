//
//  MainViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 29.04.2025.
//

import Foundation

final class MainViewModel: ObservableObject {
    var authManager: AuthManager
    var networkManager: LunchNetworkManagerProtocol
    
    let makeHomeViewModel: () -> HomeViewModel
    let makeHistoryViewModel: () -> HistoryViewModel
    let makeProfileViewModel: () -> ProfileViewModel
    
    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol,
         makeHomeViewModel: @escaping () -> HomeViewModel,
         makeHistoryViewModel: @escaping () -> HistoryViewModel,
         makeProfileViewModel: @escaping () -> ProfileViewModel) {
        self.networkManager = networkManager
        self.authManager = authManager
        self.makeHomeViewModel = makeHomeViewModel
        self.makeHistoryViewModel = makeHistoryViewModel
        self.makeProfileViewModel = makeProfileViewModel
    }
}
