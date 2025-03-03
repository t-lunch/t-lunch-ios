//
//  HistoryView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var vm = HistoryViewModel()
    @State var isLiked: Bool = true
    @State var isLiked1: Bool = false
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                VStack(spacing: 24) {
                    LunchCard(lunch: Lunch.example, isLiked: $isLiked)
                    LunchCard(lunch: Lunch.example, isLiked: $isLiked1)
                }
            }
            .searchable(text: $vm.searchText, prompt: "Поиск")
            .navigationTitle("История")
        }
    }
}


#Preview {
    HistoryView()
}
