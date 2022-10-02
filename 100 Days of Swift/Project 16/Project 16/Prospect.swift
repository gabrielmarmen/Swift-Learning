//
//  Prospect.swift
//  Project 16
//
//  Created by Gabriel Marmen on 2022-09-27.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    private var savePath: URL
    
    
    init() {
        
        //Setting the save Path
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        savePath = paths[0].appendingPathComponent("prospects.json")
        
        //Check if its able to load the data from the path.
        //If yes we try to decode the data.
        //If anything fails we create an empty array
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }

        people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func saveToJson() {
        if let encoded = try? JSONEncoder().encode(people) {
            do {
                try encoded.write(to: savePath)
                let input = try String(contentsOf: savePath)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        saveToJson()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        saveToJson()
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
