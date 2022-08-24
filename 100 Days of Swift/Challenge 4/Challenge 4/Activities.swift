//
//  Activities.swift
//  Challenge 4
//
//  Created by Gabriel Marmen on 2022-08-23.
//

import Foundation

class Activities: ObservableObject {
    
    @Published var items = [Activity]() {
        didSet {
        
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
