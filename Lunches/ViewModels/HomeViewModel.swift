//
//  HomeViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    
    @Published var isAddingSheetPresented = false
    @Published var sheetTimeSelection = "11:00"
    @Published var sheetPlaceSelection = "Кухня"
    @Published var sheetPlaceName = ""
    @Published var sheetNotes = ""
    
    func addButtonAction() {
        isAddingSheetPresented = true
    }
}
