//
//  SettingsPresenter.swift
//  Pouch
//
//  Created by Piyush Kumar on 09/02/23.
//

import UIKit
import ObjectMapper

class SettingsPresenter:SettingsPresenterProtocol{
    var view: SettingsViewProtocol?
    
    static func createSettingsModule()->UIViewController{
        let view = SettingsVC()
        var presenter: SettingsPresenterProtocol = SettingsPresenter()
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
    func userLogOutAction() {
//        ApiHandler.call(apiName: API.Name.logout, params: [:], httpMethod: .POST) { (data:MessageResponse?, error) in
//            Singleton.shared.logoutFromDevice()
//        }
        Singleton.shared.logoutFromDevice()
    }
    
    func updatePreferencesJson(data:SettingsSectionData) -> JSON{
        var json = JSON()
        json[API.keys.set_notification_app] = data.rowData?.first(where: {$0.type == .appNotification})?.isSelected
        json[API.keys.set_notification] = data.rowData?.first(where: {$0.type == .notification})?.isSelected
        return json
    }
    
    func setUserData(data:SettingsSectionData){
        if var userData = UserDefaultsCustom.getUserData(){
            userData.preferences?.mapData?.notification_app = data.rowData?.first(where: {$0.type == .appNotification})?.isSelected
            userData.preferences?.mapData?.notification = data.rowData?.first(where: {$0.type == .notification})?.isSelected
            UserDefaultsCustom.saveUserData(userData: userData)
            DatabaseManager.shared.createOrUpdateDocumentForDb(_id: userData.mobile ?? "", dbName: DatabaseManager.kProfileDBName, json: userData.toJSON())
        }
    }
    
    func updatePreferencesApiCall(secData:SettingsSectionData,section:Int){
        let json = ["map" : updatePreferencesJson(data: secData)]
        ApiHandler.call(apiName: API.Name.profile_preferences_update, params: json, httpMethod: .PUT) { (data:MessageResponse?, error) in
            self.setUserData(data: secData)
            self.view?.updatePreferences(secData:secData,section:section)
        }
    }
}
