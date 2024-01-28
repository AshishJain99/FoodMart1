//
//  CoreDataParser.swift
//  FoodMart1
//
//  Created by Ashish Jain on 28/01/24.
//

import Foundation

class JsonDataParser{
    
    func parseJsonDataToCoreData(){
        guard let jsonData = getJsonOfflineData() else{return}
        let categories = jsonData.categories
        DispatchQueue.main.async {
            for record in categories {
                let productCategory = CDCategory(context: PersistentStorage.shared.context)

                productCategory.id = Int16(record.id)
                productCategory.name = record.name
                
                var itemsSet = Set<CDItem>()

                record.items.forEach { (itemCategory) in
                    let cdProductItems = CDItem(context: PersistentStorage.shared.context)

                    cdProductItems.id = Int16(itemCategory.id)
                    cdProductItems.icon = itemCategory.icon
                    cdProductItems.name = itemCategory.name
                    cdProductItems.price = itemCategory.price

                    itemsSet.insert(cdProductItems)
                }

                let x = itemsSet
                productCategory.items = itemsSet
                print(productCategory)
                PersistentStorage.shared.saveContext()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                let x = PersistentStorage.shared.fetchManagedObject(managedObject: CDCategory.self)
                print(x)
            }
            
        }
    }
    
    private func getJsonOfflineData()->ProductCategoryResponse?{
        if let path = Bundle.main.path(forResource: "shopping", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ProductCategoryResponse.self, from: data)
                // Use yourData to populate Core Data
                return jsonData
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                return nil
            }
        }
        return nil
    }
}
