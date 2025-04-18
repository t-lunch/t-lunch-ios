//
//  HomeView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var authManager: AuthManager
    var networkManager: LunchNetworkManagerProtocol

    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol) {
        self.authManager = authManager
        self.networkManager = networkManager
        _viewModel = StateObject(wrappedValue: HomeViewModel(authManager: authManager, networkManager: networkManager))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(viewModel.lunches) { lunch in
                        LunchCard(lunch: lunch, isAvailable: true, joinAction: {
                            networkManager.joinLunch(lunchId: lunch.id, userId: Int64(authManager.userId)) { response in
                                print(response as Any)
                            }
                        })
                        .onTapGesture {
                            viewModel.selectedLunch = lunch
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            .searchable(text: $viewModel.searchText, prompt: "Поиск")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.addButtonAction()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(item: $viewModel.selectedLunch, onDismiss: {
                viewModel.selectedLunch = nil
            }) { lunch in
                DetailView(lunch: lunch)
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $viewModel.isAddingSheetPresented, onDismiss: {
                viewModel.isAddingSheetPresented = false
            }) {
                AddingView(viewModel: viewModel)
                    .presentationDragIndicator(.visible)
            }
            .navigationTitle("Главная")
        }
    }
}

struct DetailView: View {
    let lunch: Lunch
    @State var isAvailable: Bool = true
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            header

            labelsSection
            notesSection

            participantsSection

            Spacer()
        }
        .padding()
    }

    var participantsSection: some View {
        Section {
            ForEach(lunch.users, id: \.userId) { participant in
                HStack {
                    Text(participant.name)

                    Spacer()

                    Button {} label: {
                        TelegramIcon()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }

    var header: some View {
        HStack {
            Text("Обед от \(lunch.name)")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .bold()
                    .foregroundStyle(.secondary)
                    .padding(10)
                    .background {
                        Circle()
                            .foregroundStyle(.secondary.opacity(0.5))
                    }
                    .scaleEffect(0.8)
            }
            .foregroundStyle(.primary)
        }
    }

    var labelsSection: some View {
        VStack(alignment: .leading) {
            LunchCardLabel(title: lunch.name, image: "mappin")
            LunchCardLabel(title: lunch.time.formatted(date: .omitted, time: .shortened), image: "alarm")
            LunchCardLabel(title: uchastnika(Int(lunch.numberOfParticipants)), image: "person.2")
        }
    }

    var notesSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let notes = lunch.description {
                Text("Примечания")
                Text(notes)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    HomeView(authManager: AuthManager(), networkManager: FakeLunchNetworkManager(authManager: AuthManager()))
}
