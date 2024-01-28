//
//  ItemCollectionViewCell.swift
//  FoodMart1
//
//  Created by Ashish Jain on 28/01/24.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topView:UIView!
    
    @IBOutlet weak var productImageView:UIImageView!
    @IBOutlet weak var favoriteImageView:UIImageView!
    
    @IBOutlet weak var priceLabel:UILabel!
    @IBOutlet weak var unitLabel:UILabel!
    @IBOutlet weak var productNameLabel:UILabel!
    
    @IBOutlet weak var addItemView:UIView!
    
    var addItemTapHandler: (() -> Void)?
    var favoriteTapHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Additional setup code if needed
        let addItemTap = UITapGestureRecognizer(target: self, action: #selector(addTapped))
        addItemView.addGestureRecognizer(addItemTap)
        
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        favoriteImageView.addGestureRecognizer(favoriteTap)
        favoriteImageView.isUserInteractionEnabled = true
        
        addItemView.layer.cornerRadius = 10
        applyShadowEffect(viewForShadow: topView)
    }
    
    
    @objc func addTapped(){
        addItemTapHandler?()
        print("AddTapped")
    }
    
    @objc func favoriteTapped(){
        favoriteTapHandler?()
        print("AddTapped")
    }
    
    func applyShadowEffect(viewForShadow:UIView){
        viewForShadow.layer.shadowColor = UIColor.black.cgColor
        viewForShadow.layer.shadowOpacity = 1
        viewForShadow.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewForShadow.layer.shadowRadius = 5
        viewForShadow.layer.masksToBounds = false

    }
    
}
