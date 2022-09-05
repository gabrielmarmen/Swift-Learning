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
    
    
    
    static func cacheData(in moc: NSManagedObjectContext) async{
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                
                for i in 0..<decodedResponse.count {
                    let tmpUser = CachedUser(context: moc)
                    tmpUser.age = Int16(decodedResponse[i].age)
                    tmpUser.name = decodedResponse[i].name
                    tmpUser.id = decodedResponse[i].id
                    tmpUser.isActive = decodedResponse[i].isActive
                    tmpUser.company = decodedResponse[i].company
                    for y in 0..<decodedResponse[i].friends.count{
                        let tmpFriend = CachedFriend(context: moc)
                        tmpFriend.id = UUID(uuidString: decodedResponse[i].friends[y].id)
                        tmpFriend.name =  decodedResponse[i].friends[y].name
                        tmpUser.addToFriends(tmpFriend)
                    }
                }
                try? moc.save()
            }
        } catch {
            print("Invalid data")
        }
    }
    
    static func DeleteAllRecords(in moc: NSManagedObjectContext) {
        
    }
    
}
