//
//  ContentView.swift
//  Project 2
//
//  Created by Gabriel Marmen on 2022-08-04.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var titleAlert = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionNo = 1
    @State private var message = ""

    
    
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30){
                VStack{
                    Text("Select the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.semibold))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.bold))
                }
                ForEach(0..<3){ number in
                    Button{
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerSize: .init(width: 7, height: 7)))
                            .shadow(radius: 5)
                    }
                }
                Text("Score : " + String(score))
                    .foregroundColor(.white)
            }
            
        }
        .alert(titleAlert, isPresented: $showingScore) {
            Button("Continue", action: newQuestion)
        } message: {
            Text(message)
        }
        
    }
    
    
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            titleAlert = "Correct"
            
            if questionNo == 8 {
                score += 1
                message = "Well done, you finished with a score of " + String(score) + "/8"
            }
            else
            {
                score += 1
                message = "Your score is " + String(score)
            }
            
        }
        else {
            titleAlert = "Nope"
            message = "That's the flag of " + countries[number]
            score = 0
            questionNo = 0
        }
        showingScore = true
    }
    
    func newQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if questionNo == 8 {
            questionNo = 1
            score = 0
        }
        questionNo += 1
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
