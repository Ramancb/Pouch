//
//  SideMenuVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 02/02/23.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var settingsData:[SettingsSectionData] = SettingsDataModel.array
    var countriesArr: [String] = ["India","New York","Australia","England","London"]
    var languageArr: [String] = ["English","Hindi"]
    var presenter: SettingsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.applyGradient(colours: [UIColor(hexString: "#161a1a"), UIColor(hexString: "#000000") ], locations: [0,0.7])
        setTableView()
    }

    func setTableView(){
        settingsTableView.register(cellClass: SettingsTableCell.self)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    func setDropDown(tag:Int){
        let picker = CustomPickerController()
        picker.delegate = self
        picker.set(tag % 10 == 0 ? languageArr : countriesArr, delegate: self,tag: tag)
        self.present(picker, false)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.popVC()
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        presenter?.userLogOutAction()
    }
}

extension SettingsVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsData[section].rowData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: SettingsTableCell.self, forIndexPath: indexPath)
        cell.setCellData(data: self.settingsData[indexPath.section].rowData?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.settingsData[indexPath.section].rowData?[indexPath.row].type{
        case .privacy:
            guard let url = URL(string:"https://www.pouch.club/privacy.html") else {
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else{
                Singleton.shared.showErrorMessage(error: "Invalid url!", isError: .error)
            }
        case .editProfile:
            let vc = EditProfilePresenter.CreateEditProfileModule(delegate: nil)
            self.present(vc, animated: false)
        case .country,.language:
            self.setDropDown(tag: indexPath.section * 10 + indexPath.row)
        case .appNotification,.notification:
            if let isSelected = self.settingsData[indexPath.section].rowData?[indexPath.row].isSelected{
                self.settingsData[indexPath.section].rowData?[indexPath.row].isSelected =  !(isSelected)
                presenter?.updatePreferencesApiCall(secData: self.settingsData[indexPath.section], section: indexPath.section)
            }
//            self.settingsTableView.reloadData()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView.getFromNib(className: SettingsSectionHeader.self)
        sectionHeader.setHeaderData(data: self.settingsData[section])
        return sectionHeader
    }
}
extension SettingsVC: CustomPickerControllerDelegate{
    
    func didSelectPicker(_ value: String, _ index: Int, _ tag: Int?, custom picker: CustomPickerController) {
        let section = (tag ?? 0) / 10
        let row = (tag ?? 0) % 10
        self.settingsData[section].rowData?[row].desc = value
        self.settingsTableView.reloadData()
    }
    
    func cancel(picker: CustomPickerController, _ tag: Int) {
        
    }
}


extension SettingsVC: SettingsViewProtocol{
    func updatePreferences(secData: SettingsSectionData, section: Int) {
        DispatchQueue.main.async {
            self.settingsData[section] = secData
            self.settingsTableView.reloadData()
        }
    }
    
}
