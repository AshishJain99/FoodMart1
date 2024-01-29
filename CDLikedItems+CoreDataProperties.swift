//
//  CDLikedItems+CoreDataProperties.swift
//  FoodMart1
//
//  Created by Ashish Jain on 29/01/24.
//
//

import Foundation
import CoreData


extension CDLikedItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLikedItems> {
        return NSFetchRequest<CDLikedItems>(entityName: "CDLikedItems")
    }

    @NSManaged public var id: Int16
    @NSManaged public var liked: Bool
    @NSManaged public var toItem: CDItem?

}

extension CDLikedItems : Identifiable {

}
