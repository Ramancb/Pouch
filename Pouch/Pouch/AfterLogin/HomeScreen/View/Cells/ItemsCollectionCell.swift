//
//  HomeCollectionCell.swift
//  Pouch
//
//  Created by Piyush Kumar on 06/02/23.
//

import UIKit

class ItemsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentHighlightView: UIView!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellData(data: CategoryData?,isSelected:Bool){
        self.itemLabel.text = data?.displayName
        self.contentHighlightView.isHidden = !isSelected
        self.itemLabel.textColor = isSelected ?  UIColor.appColor(.themeWhite) : UIColor.appColor(.lightGray)
    }
}
