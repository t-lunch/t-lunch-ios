//
//  HomeView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if viewModel.lunches.isEmpty {
                        Text("Доступных обедов нет")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding()
                    } else {
                        ForEach(sortedLunches) { lunch in
                            LunchCard(
                                lunch: lunch,
                                isAvailable: !viewModel.verifyAttendance(to: lunch),
                                hasJoined: viewModel.verifyAttendance(to: lunch),
                                joinAction: {
                                    viewModel.joinLunch(lunch)
                                },
                                leaveAction: {
                                    viewModel.leaveLunch(lunch)
                                }
                            )
                            .onTapGesture {
                                viewModel.selectedLunch = lunch
                            }
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
                DetailView(lunch: lunch, viewModel: viewModel)
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
        .refreshable {
            viewModel.fetchData()
        }
    }

    private var sortedLunches: [Lunch] {
        viewModel.lunches
            .filter {
                viewModel.searchText.isEmpty ||
                    $0.name.localizedCaseInsensitiveContains(viewModel.searchText) ||
                    $0.place.localizedCaseInsensitiveContains(viewModel.searchText)
            }
            .sorted { lhs, rhs in
                let lhsJoined = viewModel.verifyAttendance(to: lhs)
                let rhsJoined = viewModel.verifyAttendance(to: rhs)

                if lhsJoined != rhsJoined {
                    return lhsJoined // true выше false
                }

                return lhs.time < rhs.time // раньше — выше
            }
    }
}

struct DetailView: View {
    let lunch: Lunch
    @ObservedObject var viewModel: HomeViewModel
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
        .onAppear {
            viewModel.fetchParticipants(for: lunch)
        }
    }

    var participantsSection: some View {
        Section {
            ForEach(viewModel.participants, id: \.userId) { participant in
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
            LunchCardLabel(title: inflectParticipant(Int(lunch.numberOfParticipants) ?? 0), image: "person.2")
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
    HomeView(viewModel: ViewModelFactory.previewContent.makeHomeViewModel())
}
