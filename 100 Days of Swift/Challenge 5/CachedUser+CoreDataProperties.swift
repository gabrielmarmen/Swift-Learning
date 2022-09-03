//
//  CachedUser+CoreDataProperties.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-02.
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
    @NSManaged public var friends: CachedFriend?
    
    
    var wrappedCompany: String {
        company ?? "Unknown"
    }
    var wrappedName: String {
        company ?? "Unknown"
    }


}



extension CachedUser : Identifiable {

}
