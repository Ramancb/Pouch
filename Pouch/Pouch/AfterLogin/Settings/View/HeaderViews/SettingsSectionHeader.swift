//
//  SectionHeaderView.swift
//  Pouch
//
//  Created by Piyush Kumar on 02/02/23.
//

import UIKit

class SettingsSectionHeader: UIView {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setHeaderData(data:SettingsSectionData){
        self.headerLabel.text  = data.SectionTitle
        self.headerImage.image = data.sectionIcon
    }
}
