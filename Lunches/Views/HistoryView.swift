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
                    ForEach(filteredLunches, id: \.lunch.id) { lunch in
                        LunchCard(lunch: lunch.lunch, isLiked: lunch.isLiked, showLikeButton: true, isLikedAction: {
                            viewModel.onLikeAction(lunch)
                        })
                    }
                }
            }
            .padding(.top)
            .searchable(text: $viewModel.searchText, prompt: "Поиск")
            .navigationTitle("История")
            .onAppear {
                viewModel.fetchData()
            }
            .refreshable {
                viewModel.fetchData()
            }
        }
    }

    private var filteredLunches: [LunchFeedback] {
        guard !viewModel.searchText.isEmpty else {
            return viewModel.lunches
        }

        return viewModel.lunches.filter { item in
            let search = viewModel.searchText.lowercased()
            return item.lunch.name.lowercased().contains(search) ||
                item.lunch.place.lowercased().contains(search) ||
                item.lunch.time.formatted(date: .abbreviated, time: .shortened).lowercased().contains(search)
        }
    }
}

#Preview {
    HistoryView(viewModel: ViewModelFactory.previewContent.makeHistoryViewModel())
}
