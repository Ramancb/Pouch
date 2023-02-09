//
//  SideMenuVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 02/02/23.
//

import UIKit

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    var settingsData:[SettingsSectionData] = SettingsDataModel.array
    var setData:[SettingsRowDataModel] = NotificationSection.array
    var countriesArr: [String] = ["India","New York","Australia","England","London"]
    var languageArr: [String] = ["English","Hindi"]

    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutlet.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.1,0.4])
        setTableView()
    }
    func setDropDown(){
        let picker = CustomPickerController()
        picker.set(countriesArr, delegate: self,tag: 0)
        self.present(picker, false)
    }
    func languageDropDown(){
        let picker = CustomPickerController()
        picker.set(languageArr, delegate: self,tag: 0)
        self.present(picker, false)
    }
    func setTableView(){
        sideMenuTableView.register(cellClass: SideMenuTableCell.self)
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SideMenuVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsData[section].rowData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: SideMenuTableCell.self, forIndexPath: indexPath)
        cell.setCellData(data: self.settingsData[indexPath.section].rowData?[indexPath.row], delegate: self, index: indexPath)//setCellData(data: self.settingsData[indexPath.section].rowData?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.settingsData[indexPath.section].rowData?[indexPath.row].type{
        case .editProfile:
            let vc = EditProfilePresenter.CreateEditProfileModule()
            self.pushViewController(vc, true)
        case .privacy:
            break
        case .country:
            self.setDropDown()
        case .language:
            self.languageDropDown()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UINib(nibName: "SectionHeaderView",bundle: nil).instantiateView as! SectionHeaderView
        sectionHeader.headerLabel.text = self.settingsData[section].SectionTitle
        sectionHeader.headerImage.image = self.settingsData[section].sectionIcon
        return sectionHeader
    }
}
extension SideMenuVC: CustomPickerControllerDelegate{
    func didSelectPicker(_ value: String, _ index: Int, _ tag: Int?, custom picker: CustomPickerController) {
    }
    
    func cancel(picker: CustomPickerController, _ tag: Int) {
    }
}

extension SideMenuVC: SideMenuTableCellDelegate{
    func updatedRowData(data: SettingsRowDataModel?, index: IndexPath?) {
        guard let row_data = data else{return}
        guard let indexpath = index else{return}
        self.settingsData[indexpath.section].rowData?[indexpath.row] = row_data
        self.sideMenuTableView.reloadRows(at: [indexpath], with: .automatic)
    }
}
