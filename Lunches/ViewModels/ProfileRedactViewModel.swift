//
//  ProfileRedactViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

final class ProfileRedactViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var tgContact: String = ""
    @Published var emojiIcon: String = ""
    
    init() {
        self.name = MainUser.shared.name
        self.surname = MainUser.shared.surname
        self.tgContact = MainUser.shared.tgContact ?? ""
        self.emojiIcon = MainUser.shared.emojiIcon ?? ""
    }
    
    func saveButtonAction() {
        
    }
    
    func logOutAction() -> Bool {
        true
    }
}
