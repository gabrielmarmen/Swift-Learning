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
    
    
    
    static func UpdateCache(with downloadedUsers: [User], in moc: NSManagedObjectContext) {
        for user in downloadedUsers {
            let cachedUser = CachedUser(context: moc)
            
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.company = user.company
            for friend in user.friends {
                let cachedFriend =  CachedFriend(context: moc)
                
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                
                cachedUser.addToFriends(cachedFriend)
            }
        }
        try? moc.save()
    }
    
    static func GetDataFromJSON() async -> [User] {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return [User]()
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                
                for user in decodedResponse{
                    print(user.name)
                    for friend in user.friends {
                        print("   \(friend.name)")
                    }
                }
                return decodedResponse
                
            }
        } catch {
            print("Invalid data")
        }
        return [User]()
    }
    
    static func FetchUsers(in moc: NSManagedObjectContext) async {
        
        let downloadedUsers = await GetDataFromJSON()
        await MainActor.run {
            UpdateCache(with: downloadedUsers, in: moc)
        }
    }
    
    
}
