//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Kevin Reid on 17/01/2019.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var telephone: String?

}

extension Contact : Identifiable {

}
