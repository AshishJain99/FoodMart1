//
//  CDCategory+CoreDataProperties.swift
//  FoodMart1
//
//  Created by Ashish Jain on 28/01/24.
//
//

import Foundation
import CoreData


extension CDCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategory> {
        return NSFetchRequest<CDCategory>(entityName: "CDCategory")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var items: Set<CDItem>?

}

// MARK: Generated accessors for items
extension CDCategory {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: CDItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: CDItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: Set<CDItem>)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: Set<CDItem>)

}

extension CDCategory : Identifiable {

}
