//
//  HomeViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    var networkManager: LunchNetworkManagerProtocol
    var authManager: AuthManager

    @Published var searchText: String

    @Published var lunches: [Lunch]
    @Published var selectedLunch: Lunch?

    @Published var isAddingSheetPresented: Bool
    @Published var sheetTimeSelection: String
    @Published var sheetPlaceSelection: String
    @Published var sheetPlaceName: String
    @Published var sheetNotes: String

    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol) {
        self.networkManager = networkManager
        self.authManager = authManager

        lunches = []
        searchText = ""
        selectedLunch = nil
        isAddingSheetPresented = false
        sheetTimeSelection = "11:00"
        sheetPlaceSelection = "Кухня"
        sheetPlaceName = ""
        sheetNotes = ""
    }

    func fetchData() {
        networkManager.getLunches(userId: Int64(authManager.userId), offset: 0, limit: 100) { result in
            self.lunches = result
        }
    }

    func addButtonAction() {
        isAddingSheetPresented = true
    }
    
    func saveNewLunch() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        
        if let date = formatter.date(from: sheetTimeSelection) {
            networkManager.createLunch(request: CreateLunchRequest(userId: Int64(authManager.userId), place: sheetPlaceName == "" ? "Кухня" : sheetPlaceName, time: date, description: sheetNotes)) { response in
                print(response as Any)
            }
        } else {
            print("Ошибка парсинга времени")
        }
    }
}
