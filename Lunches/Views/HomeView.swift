//
//  HomeView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                VStack(spacing: 24) {
                    LunchCard(lunch: Lunch(), isAvailable: true)
                    LunchCard(lunch: Lunch(), isAvailable: true)
                    LunchCard(lunch: Lunch(), isAvailable: true)
                    LunchCard(lunch: Lunch(), isAvailable: true)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.addButtonAction()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .searchable(text: $vm.searchText, prompt: "Поиск")
            .navigationTitle("Главная")
        }
    }
}

#Preview {
    HomeView()
}
