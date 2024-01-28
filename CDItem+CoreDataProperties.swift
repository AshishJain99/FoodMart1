//
//  CDItem+CoreDataProperties.swift
//  FoodMart1
//
//  Created by Ashish Jain on 28/01/24.
//
//

import Foundation
import CoreData


extension CDItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDItem> {
        return NSFetchRequest<CDItem>(entityName: "CDItem")
    }

    @NSManaged public var id: Int16
    @NSManaged public var icon: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var category: CDCategory?

}

extension CDItem : Identifiable {

}
