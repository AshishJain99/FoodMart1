//
//  TableViewCell.swift
//  FoodMart1
//
//  Created by Ashish Jain on 28/01/24.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView:UICollectionView!
    
    var productItemData:[ProductItem]?{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    weak var delegate:MainTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productItemData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionVCell", for: indexPath) as! ItemCollectionViewCell
        guard let itemData = productItemData?[indexPath.item] else{return cell}
        
        let iconUrlString = itemData.icon
        let iconURL = URL(string: iconUrlString)
        cell.productImageView.sd_setImage(with: iconURL)
        
        let texts = splitTextIntoTwoParts(inputText: itemData.name)
        
        cell.productNameLabel.text = truncateTextToLimit(inputText: texts!.text1, characterLimit: 20)
        if texts?.text2 != ""{
            cell.unitLabel.text = texts?.text2
        }else{
            cell.unitLabel.isHidden = true
        }
        
        cell.priceLabel.text = "₹"+String(itemData.price)
        cell.favoriteImageView.image = UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        cell.addItemTapHandler = {[weak self] in
            self?.handleAddButtonTap(at: indexPath)
        }
        
        cell.favoriteTapHandler = {[weak self] in
            self?.handleFavoriteTap(at: indexPath)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func splitTextIntoTwoParts(inputText: String) -> (text1: String, text2: String)? {
        // Find the range of the first occurrence of a number
        if let rangeOfFirstNumber = inputText.rangeOfCharacter(from: .decimalDigits) {
            // Extract the text before and after the first number
            let text1 = String(inputText[..<rangeOfFirstNumber.lowerBound])
            let text2 = String(inputText[rangeOfFirstNumber.lowerBound...])
            return (text1, text2)
        } else {
            // If no number is found, return the entire input as text1 and an empty string as text2
            return (inputText, "")
        }
    }
    func truncateTextToLimit(inputText: String, characterLimit: Int) -> String {
        guard inputText.count > characterLimit else {
            // If the text is already within the limit, return the original text
            return inputText
        }

        // Find the last space within the character limit
        if let lastSpaceRange = inputText.range(of: " ", options: .backwards, range: inputText.startIndex..<inputText.index(inputText.startIndex, offsetBy: characterLimit)) {
            // Extract the text before the last space
            let truncatedText = String(inputText[..<lastSpaceRange.lowerBound])
            return truncatedText
        } else {
            // If no space is found within the limit, truncate at the character limit
            let truncatedText = String(inputText.prefix(characterLimit))
            return truncatedText
        }
    }
    
    func handleAddButtonTap(at indexPath: IndexPath) {
        print("Button tapped in collection view cell at indexPath: \(indexPath)")
        guard let productId = productItemData?[indexPath.item].id else{return}
        delegate?.didAddedItem(productId: productId)
    }
    
    func handleFavoriteTap(at indexPath: IndexPath) {
        print("Button tapped in collection view cell at indexPath: \(indexPath)")
        guard let productId = productItemData?[indexPath.item].id else{return}
        delegate?.didTappedLike(productId: productId)
    }
}

protocol MainTableViewCellDelegate:AnyObject{
    func didTappedLike(productId:Int)
    func didAddedItem(productId:Int)
}
