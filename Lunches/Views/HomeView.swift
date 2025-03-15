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
                    ForEach(mockLunches) { lunch in
                        LunchCard(lunch: lunch, isAvailable: true)
                            .onTapGesture {
                                vm.selectedLunch = lunch
                            }
                    }
                }
            }
            .searchable(text: $vm.searchText, prompt: "Поиск")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.addButtonAction()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(item: $vm.selectedLunch, onDismiss: {
                vm.selectedLunch = nil
            }) { lunch in
                DetailView(lunch: lunch)
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $vm.isAddingSheetPresented, onDismiss: {
                vm.isAddingSheetPresented = false
            }) {
                AddingView(vm: vm)
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
            ForEach(lunch.participants, id: \.self) { participant in
                HStack {
                    Text(User.userBase.first { $0.id == participant }?.name ?? "Имя")
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        TelegramIcon()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
    
    var header: some View {
        HStack {
            Text("Обед от \(lunch.creator)")
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
            LunchCardLabel(title: lunch.place.title(), image: "mappin")
            LunchCardLabel(title: lunch.time.formatted(date: .omitted, time: .shortened), image: "alarm")
            LunchCardLabel(title: uchastnika(lunch.participants.count), image: "person.2")
        }
    }
    
    var notesSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let notes = lunch.notes {
                Text("Примечания")
                Text(notes)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct AddingView: View {
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        VStack {
            header
            
            timeSelection
            
            placeSelection
            
            notesSelection
            
            Spacer()
            
            saveButton
        }
        .animation(.bouncy, value: vm.sheetPlaceSelection)
    }
    
    var header: some View {
        HStack {
            Text("Новое событие")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Button(action: {
                vm.isAddingSheetPresented = false
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
        .padding(.top)
        .padding(.horizontal)
    }
    
    var timeSelection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Время")
                .padding(.horizontal)
            SelectionView(cards: generateTimeSlots(start: "11:00", end: "15:00", interval: 15), selectedCard: $vm.sheetTimeSelection)
        }
    }
    
    var placeSelection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Место")
                .padding(.horizontal)
            
            SelectionView(cards: ["Кухня", "Свое место"], selectedCard: $vm.sheetPlaceSelection)
            if vm.sheetPlaceSelection == "Свое место" {
                LunchTextField(prompt: "Введите название места", text: $vm.sheetPlaceName)
                    .padding(.horizontal, -8)
            }
        }
    }
    
    var notesSelection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Примечания")
                .padding(.horizontal)
            LunchTextField(prompt: "Ваши примечания", text: $vm.sheetNotes)
                .padding(.horizontal, -8)
        }
    }
    
    var saveButton: some View {
        Button("Создать") {
            vm.isAddingSheetPresented = false
        }
        .buttonStyle(.lunchButton)
        .padding(.horizontal, -8)
    }
}


struct SelectionView: View {
    let cards: [String]
    @Binding var selectedCard: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                if #unavailable(iOS 17.0) {
                    Spacer().frame(width: 10)
                }
                
                ForEach(cards, id: \.self) { card in
                    Button(action: {
                        selectedCard = card
                    }) {
                        Text(card)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(selectedCard == card ? .tYellow : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .animation(.default, value: selectedCard)
                    }
                    .foregroundStyle(.primary)
                }
                
                if #unavailable(iOS 17.0) {
                    Spacer().frame(width: 10)
                }
            }
            .modifier(SelectionPaddingModifier())
        }
        .frame(height: 50)
    }
}

/// Модификатор, который применяет `safeAreaPadding(.horizontal)`, если iOS 17+
struct SelectionPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content.safeAreaPadding(.horizontal)
        } else {
            content
        }
    }
}

func generateTimeSlots(start: String, end: String, interval: Int) -> [String] {
    var times: [String] = []
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"

    guard let startDate = formatter.date(from: start),
          let endDate = formatter.date(from: end) else { return [] }

    var currentTime = startDate
    while currentTime <= endDate {
        times.append(formatter.string(from: currentTime))
        currentTime = Calendar.current.date(byAdding: .minute, value: interval, to: currentTime)!
    }
    
    return times
}

#Preview {
    HomeView()
}
