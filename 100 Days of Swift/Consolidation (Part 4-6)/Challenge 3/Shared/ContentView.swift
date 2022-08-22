//
//  ContentView.swift
//  Shared
//
//  Created by Gabriel Marmen on 2022-08-12.
//

import SwiftUI

struct ContentView: View {
    @State private var baseNumber = 2
    @State private var randomMultiplier = Int.random(in: 2..<12)
    @State private var selectedNumberOfQuestion = 5
    @State private var currentQuestion = 1
    @State private var questionsToBeAsked = [5,10,15]
    @State private var answerGiven = ""
    @State private var score = 0
    
    @State private var isAlertShown = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var GameStarted = false
    
    @FocusState private var answerFieldFocused: Bool
    
    
    private var GameStopped: Bool {
        !GameStarted
    }
    private var goodResult: Int {
        baseNumber * randomMultiplier
    }
    private var answerGivenInt: Int {
        Int(answerGiven) ?? 0
    }
    
    
    var body: some View {
        
        if GameStopped{
            NavigationView{
                    List{
                        Section(header: Text("Settings")){
                            Stepper("Multiply by : \(baseNumber)", value: $baseNumber, in: 2...12)
                            
                            Picker("Number of Questions", selection: $selectedNumberOfQuestion){
                                ForEach(questionsToBeAsked, id: \.self){ question in
                                    Text(question, format: .number)
                                }
                            }
                            
                            
                        }
                    }
                    .navigationTitle("FactorLearn")
                    .toolbar{
                        Button("Start", action: StartGame)
                    }
            }
        }
        
        else{
            NavigationView{
                    
                    VStack(spacing: 20){
                        Spacer()
                        HStack{
                            Spacer()
                            Text(String(baseNumber))
                                .font(.largeTitle)
                                .frame(width: 100, height: 100, alignment: .center)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .shadow(color: .secondary, radius: 5, x: 1, y: 1)
                            Spacer()
                            Text("X")
                                .font(.largeTitle)
                                .shadow(color: .secondary, radius: 5, x: 1, y: 1)
                            Spacer()
                            Text(String(randomMultiplier))
                                .font(.largeTitle)
                                .frame(width: 100, height: 100, alignment: .center)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .shadow(color: .secondary, radius: 5, x: 1, y: 1)
                            Spacer()
                        }
                        .padding()
                        
                        TextField("Enter the Result", text: $answerGiven )
                            .font(.largeTitle)
                            .frame(width: 300, height: 100, alignment: .center)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: .gray, radius: 5, x: 1, y: 1)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($answerFieldFocused)
                            .toolbar{
                                ToolbarItemGroup(placement: .keyboard){
                                    
                                    Button("Cancel"){
                                        answerFieldFocused = false
                                        
                                    }
                                    .foregroundColor(.red)
                                    Spacer()
                                    Button("Confirm"){
                                        ConfirmTapped()
                                    }
                                    .foregroundColor(.green)
                                }
                            }
                        Text("Score : \(score)")
                            .font(.title)
                            .padding()
                        Spacer()
                    }
                    .navigationTitle("FactorLearn")
                    .toolbar(){
                        Button("Stop", action: StopGame )
                    }
            }
            .alert(alertTitle, isPresented: $isAlertShown){
                Button("Play again"){
                    StartGame()
                }
                .foregroundColor(.primary)
                Button("Quit"){
                    StopGame()
                }
                .foregroundColor(.red)
            }message: {
                Text(alertMessage)
            }
        }
        
        
            
    }
    
    func StartGame(){
        currentQuestion = 1
        score = 0
        GameStarted = true
            
    }
    func StopGame(){
        answerFieldFocused = false
        answerGiven = ""
        GameStarted = false
    }
    func ConfirmTapped(){
        if answerGivenInt == goodResult{
            score += 1
        }
        if currentQuestion < selectedNumberOfQuestion{
            
            NewRound()
        }
        else{
            let percentage: Double = Double(score) / Double(selectedNumberOfQuestion)
            switch percentage {
            case 0.0..<0.60:
                alertTitle = "Oops..."
                alertMessage = "You can do better!\nFinal Score : \(score)/\(selectedNumberOfQuestion)"
                
            case 0.60..<0.80:
                alertTitle = "Good"
                alertMessage = "You're starting to get the hang of it!\nFinal Score : \(score)/\(selectedNumberOfQuestion)"
                
            case 0.80..<1:
                alertTitle = "Excellent"
                alertMessage = "That's very good, but can you reach perfection?\nFinal Score : \(score)/\(selectedNumberOfQuestion)"
                
            case 1:
                alertTitle = "Incredible"
                alertMessage = "Wow, you got everything right!\nFinal Score : \(score)/\(selectedNumberOfQuestion)"
                
            default:
                alertTitle = "Hmmm..."
                alertMessage = "Something went wrong"
            }
            
            isAlertShown = true
            
            
        }
    }
    func NewRound(){
        randomMultiplier = Int.random(in: 0..<13)
        currentQuestion += 1
        answerGiven = ""
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
