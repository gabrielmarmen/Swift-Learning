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
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    

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
                        FlagView(of: countries[number])
                            .accessibilityLabel(labels[countries[number], default: "Unknown Flag"])
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
    
    func FlagImage(of path: String) -> some View{
        Image(path)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerSize: .init(width: 7, height: 7)))
            .shadow(radius: 5)
    }
}

struct FlagView: View{
    let of: String
    
    var body: some View{
        Image(of)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerSize: .init(width: 7, height: 7)))
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

extension View {
    func title() -> some View{
        modifier(Title())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
