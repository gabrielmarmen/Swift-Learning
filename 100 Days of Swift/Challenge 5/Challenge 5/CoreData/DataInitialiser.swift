//
//  DataInitialiser.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-02.
//

import CoreData
import SwiftUI
import Foundation

struct DataInitialiser {
    
    static func GetDataFromJSON() async -> [User] {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return [User]()
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                
                return decodedResponse
                
            }
        } catch {
            print("Invalid data")
        }
        return [User]()
    }
    
    
}
