//
//  CDAddedItems+CoreDataProperties.swift
//  FoodMart1
//
//  Created by Ashish Jain on 29/01/24.
//
//

import Foundation
import CoreData


extension CDAddedItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAddedItems> {
        return NSFetchRequest<CDAddedItems>(entityName: "CDAddedItems")
    }

    @NSManaged public var id: Int16
    @NSManaged public var toItem: CDItem?

}

extension CDAddedItems : Identifiable {

}
