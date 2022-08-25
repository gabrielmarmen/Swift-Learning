//
//  Activity.swift
//  Challenge 4
//
//  Created by Gabriel Marmen on 2022-08-23.
//

import Foundation

struct Activity: Identifiable, Codable {
    
    var id = UUID()
    var title: String
    var description: String
    var completedCounter: Int = 0
    
    mutating func complete(){
        completedCounter += 1
    }
    
}
