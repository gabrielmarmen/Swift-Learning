//
//  UserImage.swift
//  Challenge 6
//
//  Created by Gabriel Marmen on 2022-09-20.
//

import Foundation
import UIKit

struct UserImage: Comparable, Identifiable {
    
    var id: UUID
    var title: String
    var description: String
    var imageURL: URL
    
    static let exempleImage = UserImage(id: UUID(), title: "Some Image" , description: "This is an image lmao.", imageURL: URL(string: "exemple")!)
    
    static func < (lhs: UserImage, rhs: UserImage) -> Bool {
        lhs.title < rhs.title
    }
    
    
    
    
}
