//
//  SettingsProtocol.swift
//  Pouch
//
//  Created by Raman choudhary on 17/02/23.
//

import Foundation

protocol SettingsPresenterProtocol{
    var view:SettingsViewProtocol? {get set}
    func userLogOutAction()
    func updatePreferencesApiCall(secData:SettingsSectionData,section:Int)
}

protocol SettingsViewProtocol{
    var presenter: SettingsPresenterProtocol? {get set}
    func updatePreferences(secData:SettingsSectionData,section:Int)
}
