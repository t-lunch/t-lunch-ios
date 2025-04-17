//
//  ContentViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
}
