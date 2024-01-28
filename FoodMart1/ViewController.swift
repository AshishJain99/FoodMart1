//
//  ViewController.swift
//  FoodMart1
//
//  Created by Ashish Jain on 28/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    let jsonDataParser = JsonDataParser()
    
//    var allProductCategory = [ProductCategory]()
    var tableCellData:[cellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var cdCategoryData = PersistentStorage.shared.fetchManagedObject(managedObject: CDCategory.self)
        if cdCategoryData?.count == 0{
            jsonDataParser.parseJsonDataToCoreData()
            cdCategoryData = PersistentStorage.shared.fetchManagedObject(managedObject: CDCategory.self)
        }
        
//        let cdCategoryData = PersistentStorage.shared.fetchManagedObject(managedObject: CDCategory.self)
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            
            self.convertCDCategoryToProductCategory(cdCategoryData: cdCategoryData)
        }
        
        
        
    }
    func convertCDCategoryToProductCategory(cdCategoryData:[CDCategory]?){
        guard let cdCategoryData = cdCategoryData else{return}
        for data in cdCategoryData{
            let id = data.id
            let name = data.name!
            let cdItems = data.items
            let item = convertToItem(cdItem: cdItems)
            
            print("xxxxxx")
            print(data)
            print("xxxxxx")
            
            let productCategory = ProductCategory(id: Int(id), name: name, items: item!)
//            allProductCategory.append(productCategory)
            let cellData = cellData(opened: true, productCategory: productCategory)
            tableCellData.append(cellData)
        }
        print("")
//        print(allProductCategory)
        tableView.reloadData()
    }
    
    func convertToItem(cdItem:Set<CDItem>?)->[ProductItem]?{
        var productItemArray: [ProductItem] = []
        guard let cdItem = cdItem else{return nil}
        for item in cdItem {
            let id = item.id
            let name = item.name
            let icon = item.icon
            let price = item.price
            
            let itemModel = ProductItem(id: Int(id), name: name!, icon: icon!, price: price)
            productItemArray.append(itemModel)
            
        }
        return productItemArray
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableCellData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableCellData[section].opened == true{
            return 2
        }else{
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") else{return UITableViewCell()}
            cell.textLabel?.text = tableCellData[indexPath.section].productCategory.name
            cell.isUserInteractionEnabled = true 
            return cell
            
        }else{
            
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.productItemData = tableCellData[indexPath.section].productCategory.items
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item != 0{
            return 200
        }else{
            return 30
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            let section = indexPath.section

            // Toggle the open state for the selected section
            tableCellData[section].opened.toggle()
            tableView.reloadSections([indexPath.section], with: .none)

        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 200, height: 200)
//    }
    
    
}

struct cellData{
    var opened: Bool
    let productCategory: ProductCategory
}
