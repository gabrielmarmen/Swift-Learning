//
//  ContentView.swift
//  Challenge 2
//
//  Created by Gabriel Marmen on 2022-08-05.
//

import SwiftUI

struct ContentView: View {
    
    @State private var arrayRPS = ["Rock","Paper","Scissors"]
    @State private var win: Bool = Int.random(in: 0..<2) != 0
    @State private var showingAlert = false
    @State private var computerChoice: Int = Int.random(in: 0..<3)
    @State private var playerChoice = 0
    @State private var result = ""
    @State private var score = 0
    @State private var questionNo = 1
    
    private var alertTitle: String {
        result == "win" ? "Yep !!" : "Nope :("
    }
    private var alertMessage: String {
        if questionNo < 10 {
            return "Your score is " + String(score) + " out of " + String(questionNo)
        }
        else{
            return "You finished with a score of " + String(score) + " out of 10"
        }
        
    }
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray,.black], startPoint: .top, endPoint: .bottom)
            
                .ignoresSafeArea()
            VStack{
                Spacer()
                Spacer()
                HStack(spacing: 10){
                    Text("Your opponent has " + arrayRPS[computerChoice])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                }
                Spacer()
                HStack(){
                    
                    Text("Pick the right choice to " + (win ? "Win" : "Lose"))
                        .foregroundColor(.white)
                }
                Spacer()
                Spacer()

                HStack(spacing: 15){
                    ForEach(0..<arrayRPS.count, id: \.self){ i in
                        Button(arrayRPS[i]){
                            AnswerTapped(chosen: i)
                        }
                            .frame(width: 75, height: 40)
                            .background()
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    }
                }
                Spacer()
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Continue", action: NewRound)
        } message: {
            Text(alertMessage)
        }
        
    }
    
    func AnswerTapped(chosen answer: Int)
    {

        if arrayRPS[computerChoice] == "Rock"
        {
            if win == true{
                
                if arrayRPS[answer] == "Paper"
                {
                    result = "win"
                }
                else{
                    result = "lose"
                }
            }
            else{
                if arrayRPS[answer] == "Scissors"
                {
                    result = "win"
                }
                else{
                    result = "lose"
                }
            }
            
        }
        if arrayRPS[computerChoice] == "Paper"
        {
            if win == true{
                
                if arrayRPS[answer] == "Scissors"
                {
                    result = "win"
                }
                else{
                    result = "lose"
                }
            }
            else{
                if arrayRPS[answer] == "Rock"
                {
                    result = "win"
                }
                else{
                    result = "lose"
                }
            }
            
        }
        if arrayRPS[computerChoice] == "Scissors"
        {
            if win == true{
                
                if arrayRPS[answer] == "Rock"
                {
                    result = "win"
                }
                else{
                    result = "lose"
                }
            }
            else{
                if arrayRPS[answer] == "Paper"
                {
                    result = "win"
                }
                else{
                    result = "lose"
                }
            }
            
        }
        
        if result == "win"{
            score += 1
        }
        
        if questionNo == 10{
            showingAlert = true
        }
        
        NewRound()
        
        
        
    }
    
    func NewRound()
    {
        computerChoice = Int.random(in: 0..<3)
        win = Int.random(in: 0..<2) != 0
        
        if questionNo > 10 {
            questionNo = 1
            score = 0
        }
        else{
            questionNo += 1
        }
        print(questionNo)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
