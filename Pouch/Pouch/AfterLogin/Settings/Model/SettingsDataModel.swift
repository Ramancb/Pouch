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
    case notification
    case appNotification
    case country
    case language
}


class SettingsRowDataModel: NSObject {
    var title:String?
    var desc:String?
    var isSelected:Bool?
    var type:SettingsRow?
    
    public init(title:String?,desc: String = "",isSelected:Bool? = nil, settingRow:SettingsRow?) {
        self.title = title
        self.isSelected = isSelected
        self.type = settingRow
        self.desc = desc
    }
}

class AccountSection{
    static var array: [SettingsRowDataModel] = [
        SettingsRowDataModel.init(title: AppStrings.editProfile, settingRow: .editProfile),
        SettingsRowDataModel.init(title: AppStrings.privacy, settingRow: .privacy)
    ]
}
class NotificationSection{
    static var array: [SettingsRowDataModel] = [
        SettingsRowDataModel.init(title: AppStrings.notification, isSelected: false, settingRow: .notification),
        SettingsRowDataModel.init(title: AppStrings.appNotifications, isSelected: false, settingRow: .appNotification)
    ]
}
class MoreSection{
    static var array: [SettingsRowDataModel] = [
        SettingsRowDataModel.init(title: AppStrings.language, settingRow: .language),
        SettingsRowDataModel.init(title: AppStrings.country, settingRow: .country)
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

