//
//  User+CoreDataProperties.swift
//  
//
//  Created by Evan Gruère on 02/05/2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var authentication: String?
    @NSManaged public var identifier: String?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float

}
