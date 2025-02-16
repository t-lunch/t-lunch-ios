//
//  LunchCard.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct LunchCard: View {
    var lunch: Lunch
    var isAvailable: Bool = false
    var isLiked: Binding<Bool>? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(color: .primary.opacity(0.2), radius: 10)
            VStack(alignment: .leading) {
                HStack {
                    Text("Обед от \(MainUser.shared.name)")
                        .font(.title2)
                        .bold()
                    Spacer()
                    if isLiked != nil {
                        Button {
                            isLiked!.wrappedValue.toggle()
                        } label: {
                            Image(systemName: isLiked!.wrappedValue ? "heart.fill" : "heart")
                                .font(.system(size: 28))
                                .foregroundColor(isLiked!.wrappedValue ? .red : .accentColor)
                        }
                    }
                }
                label(title: "Кухня", image: "mappin")
                label(title: "14:00", image: "alarm")
                label(title: "2 участника", image: "person.2")
                
                if isAvailable {
                    Button {
                        
                    } label: {
                        Text("Присоединиться")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.smallLunchButton)
                    .padding(.vertical, 5)
                }
            }
            .padding()
        }
        .aspectRatio(19/11, contentMode: .fit)
        .padding(.horizontal)
    }
    
    func label(title: String, image: String) -> some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background {
                    Circle()
                        .fill(.blue)
                }
            Text(title)
        }
    }
}

#Preview {
    LunchCard(lunch: Lunch(), isAvailable: true, isLiked: Binding( get: { true }, set: { _ in }))
}
