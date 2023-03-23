//
//  SideMenuTableCell.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit


class SettingsTableCell: UITableViewCell {

    @IBOutlet weak var rightArrowButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func setCellData(data:SettingsRowDataModel?){
        self.rightArrowButton.isUserInteractionEnabled = false
        self.titleLabel.text = data?.title
        self.descriptionLabel.text = data?.desc
        if data?.type == .notifation || data?.type == .appNotification{
            self.rightArrowButton.setImage(data?.isSelected == true ? UIImage(named: "toggle_on_ic") : UIImage(named: "toggle_off_ic"), for: .normal)
            if data?.type == .notifation{
                self.descriptionLabel.text = data?.isSelected == true ? AppStrings.notificationOnDesc : AppStrings.notificationOffDesc
            }else{
                self.descriptionLabel.text = data?.isSelected == true ? AppStrings.appNotificationOnDesc : AppStrings.appNotificationOffDesc
            }
        }else{
            self.rightArrowButton.setImage(UIImage(named: "arrow_ryt_grey_ic"), for: .normal)
        }
    }
}
