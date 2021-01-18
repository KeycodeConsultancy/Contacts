//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Kevin Reid on 18/01/2021.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var telephone: String?
    @NSManaged public var id: UUID?

}

extension Contact : Identifiable {

}
