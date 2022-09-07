//
//  CachedFriend+CoreDataProperties.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-05.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    var wrappedName: String {
        name ?? "Unknown"
    }
    var wrappedCachedUser: CachedUser {
        user ?? CachedUser()
    }
    
}

extension CachedFriend : Identifiable {

}
