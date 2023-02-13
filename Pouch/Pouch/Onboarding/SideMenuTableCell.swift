//
//  SideMenuTableCell.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit

protocol SideMenuTableCellDelegate{
    func updatedRowData(sender:UIButton)
}

class SideMenuTableCell: UITableViewCell {

    @IBOutlet weak var countrySelectedLabel: UILabel!
    @IBOutlet weak var sideMenuLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    var delegate:SideMenuTableCellDelegate?
//    var selectedIndex:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func setCellData(data:SettingsRowDataModel?,delegate:SideMenuTableCellDelegate?,index:IndexPath?){
        self.delegate = delegate
        self.rightButton.tag = ((indexPath?.section ?? 0) * 10) + (indexPath?.row ?? 0)
        self.sideMenuLabel.text = data?.title
        if data?.type == .notifation || data?.type == .appNotification{
            self.rightButton.setImage(data?.isSelected == true ? data?.icon : data?.unselectedIcon, for: .normal)
            self.rightButton.isUserInteractionEnabled = true
        }else{
            self.rightButton.isSelected = false
            self.rightButton.isUserInteractionEnabled = false
            self.rightButton.setImage(data?.isSelected == true ? data?.icon : data?.icon, for: .normal)
        }
        
    }
   
  
    @IBAction func rightBtnAction(_ sender: UIButton) {
        sender.isSelected = !(sender.isSelected)
        self.delegate?.updatedRowData(sender: sender)
    }
}
