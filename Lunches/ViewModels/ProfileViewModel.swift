//
//  ProfileViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var name: String
    @Published var surname: String
    @Published var tgContact: String?
    
    init() {
        self.name = MainUser.shared.name
        self.surname = MainUser.shared.surname
        self.tgContact = MainUser.shared.tgContact
    }
}
