//
//  HistoryView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    ForEach($viewModel.lunches, id: \.lunch.id) { $lunch in
                        LunchCard(lunch: lunch.lunch, isLiked: $lunch.isLiked)
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            .searchable(text: $viewModel.searchText, prompt: "Поиск")
            .navigationTitle("История")
        }
    }
}

#Preview {
    HistoryView(viewModel: ViewModelFactory.previewContent.makeHistoryViewModel())
}
