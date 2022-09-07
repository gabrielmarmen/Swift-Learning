//
//  User.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-02.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var friends: [Friend]
}
