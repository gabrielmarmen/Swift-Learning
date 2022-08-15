//
//  ExpenseItem.swift
//  Project 7
//
//  Created by Gabriel Marmen on 2022-08-15.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
