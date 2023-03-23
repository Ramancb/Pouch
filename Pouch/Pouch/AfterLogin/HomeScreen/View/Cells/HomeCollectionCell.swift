//
//  HomeCollectionCell.swift
//  Pouch
//
//  Created by Raman choudhary on 11/02/23.
//

import UIKit
import SwiftUI

enum DiscountType:String{
    case ptOff = "PT_OFF"
}

enum BackGroundFrontType:String{
    case grad_color_Image = "GRAD_COLOR_IMAGE"
    case plain = "PLAIN"
    case gradient = "GRADIENT"
    case colorImage = "COLOR_IMAGE"
}

class HomeCollectionCell: UICollectionViewCell {
   
    @IBOutlet weak var card_View: CardView!
    
    override func prepareForReuse() {
        card_View.cardBgView.removeGradient()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellData(cardData: CardsData?){
        self.card_View.setCardViewData(data: cardData)
        
    }
}




