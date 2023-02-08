//
//  SideMenuTableCell.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit

class SideMenuTableCell: UITableViewCell {

    @IBOutlet weak var sideMenuLabel: UILabel!
    @IBOutlet weak var notificationToggleBtnOutlet: UIButton!
    @IBOutlet weak var rightArrowOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSwitchButton(isButton: Bool?){
    
        if isButton == true{
            notificationToggleBtnOutlet.setImage(UIImage(named: "toggle_on_ic"), for: .normal)
        }
        else
        {
            notificationToggleBtnOutlet.setImage(UIImage(named: "toggle_off_ic"), for: .normal)
        }
    }
    
    @IBAction func rightArrowBtnAction(_ sender: Any) {
    }
    
    @IBAction func notificationBtnToggleAction(_ sender: UIButton) {
        sender.isSelected = !(sender.isSelected)
        
    }
}
