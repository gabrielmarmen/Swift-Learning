//
//  CardView.swift
//  Project 17
//
//  Created by Gabriel Marmen on 2022-10-04.
//

import SwiftUI

struct CardView: View {
    
    let card: Card
    var removal: (() -> Void)? = nil
    
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var backgroundColor = Color.white

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? .white
                        : .white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(backgroundColor)
                )
                .shadow(radius: 10)

            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 10)))
        .offset(x: offset.width , y: 0)
        .opacity(3 - Double(abs(offset.width / 100)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                    backgroundColor = offset.width > 0 ? .green : .red
                }
                .onEnded { _ in
                    if abs(offset.width) > 200 {
                        if offset.width > 0 {
                            feedback.notificationOccurred(.success)
                        } else {
                            feedback.notificationOccurred(.error)
                        }
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
