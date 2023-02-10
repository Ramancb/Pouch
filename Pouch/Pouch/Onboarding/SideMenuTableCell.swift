//
//  SideMenuTableCell.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit

protocol SideMenuTableCellDelegate{
    func updatedRowData(data:SettingsRowDataModel?,index:IndexPath?)
}

class SideMenuTableCell: UITableViewCell {

    @IBOutlet weak var countrySelectedLabel: UILabel!
    @IBOutlet weak var sideMenuLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    var row_data:SettingsRowDataModel?
    var delegate:SideMenuTableCellDelegate?
    var selectedIndex:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellData(data:SettingsRowDataModel?,delegate:SideMenuTableCellDelegate?,index:IndexPath?){
        self.delegate = delegate
        self.row_data = data
        self.selectedIndex = indexPath
        self.sideMenuLabel.text = data?.title
        if data?.type == .notifation || data?.type == .appNotification{
            self.rightButton.setImage(data?.isSelected == true ? data?.icon : data?.unselectedIcon, for: .normal)
        }else{
            self.rightButton.setImage(data?.icon, for: .normal)
        }
        
    }
   
  
    @IBAction func rightBtnAction(_ sender: UIButton) {
        sender.isSelected = !(sender.isSelected)
        self.row_data?.isSelected = sender.isSelected
        self.delegate?.updatedRowData(data: self.row_data,index: self.selectedIndex)
    }
}
