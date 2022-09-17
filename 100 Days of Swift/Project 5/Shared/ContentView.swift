//
//  ContentView.swift
//  Shared
//
//  Created by Gabriel Marmen on 2022-08-10.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isAlertShown = false
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                Section{
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")    
                        
                    }
                }
                
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar{
                HStack{
                    Text("Score : \(score)")
                    Button("Restart", role: .none, action: startGame)
                }
                
                
            }
            .alert(alertTitle, isPresented: $isAlertShown){
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            
            
            
            
            
        }
        
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "Nope !", message: "You already gave this word")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Nope !", message: "This word is not possible in '\(rootWord)' !")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Nope !", message: "This word doesn't exist.")
            return
        }
        guard isLongEnough(word: answer) else {
            wordError(title: "Nope !", message: "The word is too short!")
            return
        }
        guard isNotTheSameWord(word: answer) else {
            wordError(title: "Nope !", message: "You cannot use the same word!")
            return
        }
        
        

        withAnimation{
            calculateScore(word: answer)
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
        
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
                // 2. Load start.txt into a string
                if let startWords = try? String(contentsOf: startWordsURL) {
                    // 3. Split the string up into an array of strings, splitting on line breaks
                    let allWords = startWords.components(separatedBy: "\n")

                    // 4. Pick one random word, or use "silkworm" as a sensible default
                    rootWord = allWords.randomElement() ?? "silkworm"
                    usedWords = [String]()
                    score = 0
                    // If we are here everything has worked, so we can exit
                    return
                }
            }

            // If were are *here* then there was a problem – trigger a crash and report the error
            fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func isLongEnough(word: String) -> Bool {
        word.count > 3
    }
    
    func wordError(title: String, message: String){
        alertMessage = message
        alertTitle = title
        isAlertShown = true
    }
    
    func isNotTheSameWord(word: String) -> Bool {
        !(word == rootWord)
    }
    
    func calculateScore(word: String){
        score = score + word.count
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
