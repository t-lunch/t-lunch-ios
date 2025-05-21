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
    var hasJoined: Bool = false
    var isLiked: Bool = false
    @State private var isLikedInternal: Bool = false
    var showLikeButton: Bool = false
    var joinAction: () -> Void = {}
    var leaveAction: () -> Void = {}
    var isLikedAction: () -> Void = {}

    @State private var isProcessing = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(color: .primary.opacity(0.2), radius: 10)

            VStack(alignment: .leading) {
                HStack {
                    Text("Обед от \(lunch.name)")
                        .font(.title3)
                        .bold()

                    Spacer()

                    if showLikeButton {
                        Button {
                            withAnimation(.bouncy) {
                                isLikedInternal.toggle()
                                isLikedAction()
                            }
                        } label: {
                            Image(systemName: isLikedInternal ? "heart.fill" : "heart")
                                .font(.system(size: 28))
                                .foregroundColor(isLikedInternal ? .red : .accentColor)
                        }
                    }
                }

                LunchCardLabel(title: lunch.place, image: "mappin")
                LunchCardLabel(title: lunch.time.formatted(date: .omitted, time: .shortened), image: "alarm")
                LunchCardLabel(title: inflectParticipant(Int(lunch.numberOfParticipants) ?? 0), image: "person.2")

                if isAvailable || hasJoined {
                    Button {
                        isProcessing = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isProcessing = false
                            hasJoined ? leaveAction() : joinAction()
                        }
                    } label: {
                        if isProcessing {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        } else {
                            Text(hasJoined ? "Отказаться" : "Присоединиться")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.smallLunchButton(hasJoined: hasJoined))
                    .padding(.vertical, 5)
                    .disabled(isProcessing)
                }
            }
            .padding()
        }
        .onAppear {
            isLikedInternal = isLiked
        }
        .aspectRatio(2 / 1, contentMode: .fit)
        .padding(.horizontal)
    }
}

struct LunchCardLabel: View {
    var title: String
    var image: String

    let imageSize = 38.0

    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(.white)
                .frame(width: imageSize, height: imageSize)
                .background {
                    Circle()
                        .fill(.blue)
                }
            Text(title)
        }
    }
}

/// Склонение слова "участник"
func inflectParticipant(_ n: Int) -> String {
    switch n % 10 {
    case 1 where n % 100 != 11:
        return "\(n) участник"
    case 2 ... 4 where !(12 ... 14).contains(n % 100):
        return "\(n) участника"
    default:
        return "\(n) участников"
    }
}

#Preview {
    LunchCard(
        lunch: Lunch.example,
        isAvailable: true,
        hasJoined: false,
        isLiked: true,
        showLikeButton: true
    )
}
