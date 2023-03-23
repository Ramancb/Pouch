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
        print("user name: \(UserDefaultsCustom.getUserData()?.preferences)")
        self.rightArrowButton.isUserInteractionEnabled = false
        self.titleLabel.text = data?.title
        self.descriptionLabel.text = data?.desc
        if data?.type == .notification || data?.type == .appNotification{
            
            if data?.type == .notification{
                let notificationState = UserDefaultsCustom.getUserData()?.preferences?.mapData?.notification ?? false
                self.rightArrowButton.setImage(notificationState == true ? UIImage(named: "toggle_on_ic") : UIImage(named: "toggle_off_ic"), for: .normal)
                self.descriptionLabel.text = notificationState == true ? AppStrings.notificationOnDesc : AppStrings.notificationOffDesc
            }else{
                let appNotificationState = UserDefaultsCustom.getUserData()?.preferences?.mapData?.notification_app ?? false
                
                self.rightArrowButton.setImage(appNotificationState == true ? UIImage(named: "toggle_on_ic") : UIImage(named: "toggle_off_ic"), for: .normal)
                self.descriptionLabel.text = appNotificationState == true ? AppStrings.appNotificationOnDesc : AppStrings.appNotificationOffDesc
            }
        }else{
            self.rightArrowButton.setImage(UIImage(named: "arrow_ryt_grey_ic"), for: .normal)
        }
    }
}
