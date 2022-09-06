//
//  Users.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-02.
//

import Foundation

class Users: ObservableObject{
    
    @Published var items: [User]
    
    var haveNoEntries: Bool {
        items.isEmpty
    }
    
    init(){
        items = [User]()
    }
    
    func getUser(from friend: Friend) -> User {
        items.first(where: {$0.id == friend.id})!
    }
    
    
    
    

    
}
