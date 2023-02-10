//
//  SettingsDataModel.swift
//  Pouch
//
//  Created by Piyush Kumar on 09/02/23.
//

import Foundation
import UIKit

enum SettingsRow{
    case editProfile
    case privacy
    case notifation
    case appNotification
    case country
    case language
}


class SettingsRowDataModel: NSObject {
    var icon : UIImage?
    var unselectedIcon:UIImage?
    var title:String?
    var isSelected:Bool = false
    var type:SettingsRow?
    
    
    public init(title:String?,rightIcon:UIImage?,isSelected:Bool = false,unselectedIcon:UIImage? = nil, settingRow:SettingsRow?) {
        self.title = title
        self.icon = rightIcon
        self.isSelected = isSelected
        self.unselectedIcon = unselectedIcon
        self.type = settingRow
    }
}

class AccountSection{
    static var array: [SettingsRowDataModel] = [
        SettingsRowDataModel.init(title: AppStrings.editProfile, rightIcon: UIImage(named: "arrow_ryt_grey_ic"), settingRow: .editProfile),
        SettingsRowDataModel.init(title: AppStrings.privacy, rightIcon: UIImage(named: "arrow_ryt_grey_ic"), settingRow: .privacy)
    ]
}
class NotificationSection{
    static var array: [SettingsRowDataModel] = [
        SettingsRowDataModel.init(title: AppStrings.notification, rightIcon: UIImage(named: "toggle_on_ic"), isSelected: false,unselectedIcon: UIImage(named: "toggle_off_ic"), settingRow: .notifation),
        SettingsRowDataModel.init(title: AppStrings.appNotifications, rightIcon: UIImage(named: "toggle_on_ic"), isSelected: false, unselectedIcon: UIImage(named: "toggle_off_ic"), settingRow: .appNotification)
    ]
}
class MoreSection{
    static var array: [SettingsRowDataModel] = [
        SettingsRowDataModel.init(title: AppStrings.language, rightIcon: UIImage(named: "arrow_ryt_grey_ic"), settingRow: .language),
        SettingsRowDataModel.init(title: AppStrings.country, rightIcon: UIImage(named: "arrow_ryt_grey_ic"), settingRow: .country)
        ]
}

struct SettingsSectionData{
    var SectionTitle:String?
    var rowData:[SettingsRowDataModel]?
    var sectionIcon:UIImage?
}

class SettingsDataModel{
    static var array: [SettingsSectionData] = [
        SettingsSectionData(SectionTitle: AppStrings.account, rowData: AccountSection.array, sectionIcon: UIImage(named: "account_ic")),
        SettingsSectionData(SectionTitle: AppStrings.notification, rowData: NotificationSection.array, sectionIcon: UIImage(named: "notification_ic")),
        SettingsSectionData(SectionTitle: AppStrings.more, rowData: MoreSection.array, sectionIcon: UIImage(named: "more_ic"))
    ]
}

