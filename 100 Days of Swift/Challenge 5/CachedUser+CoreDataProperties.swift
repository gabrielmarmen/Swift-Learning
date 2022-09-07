//
//  CachedUser+CoreDataProperties.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-05.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var friends: NSSet?
    
    var wrappedCompany: String {
        company ?? "Unknown"
    }
    var wrappedName: String {
        name ?? "Unknown"
    }
    var wrappedArrayFriends: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
