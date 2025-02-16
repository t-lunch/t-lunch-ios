//
//  UserModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

protocol UserModel: AnyObject & Identifiable {
    var id: UUID { get }
    
    var name: String { get set }
    var surname: String { get set }
    
    var tgContact: String? { get set }
}

final class MainUser: UserModel {
    static let shared = MainUser()
    
    let id = UUID()
    
    var login: String
    var password: String
    
    var name: String
    var surname: String
    
    var tgContact: String?
    
#if DEBUG
    init() {
        self.login = "test"
        self.password = "test"
        self.name = "Тестовый"
        self.surname = "Пользователь"
        self.tgContact = "tgcontact52"
    }
#endif
    
    init(login: String, password: String, name: String, surname: String, tgContact: String? = nil) {
        self.login = login
        self.password = password
        self.name = name
        self.surname = surname
        self.tgContact = tgContact
    }
}

final class User: UserModel {
    let id = UUID()
    
    var name: String
    
    var surname: String
    
    var tgContact: String?
    
    init(name: String, surname: String, tgContact: String? = nil) {
        self.name = name
        self.surname = surname
        self.tgContact = tgContact
    }
}
