//
//  SideMenuVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 02/02/23.
//

import UIKit

class SideMenuVC: UIViewController{
    
    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    var Account:[String] = ["EditProfile","Privacy"]
    var Notification:[String] = ["Notifications", "App Notifications"]
    var More:[String] = ["Language", "Country"]
    var AccountHeader:[String] = ["Account", "Notification","More"]
    var HeaderImage:[UIImage] = [UIImage(named:"account_ic")!, UIImage(named:"notification_ic")!, UIImage(named:"more_ic")!]
    var section: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewOutlet.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.1,0.4])
        setTableView()
        
    }
    func setTableView(){
        
        sideMenuTableView.register(UINib(nibName: "SideMenuTableCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableCell")
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
    }
    @IBAction func backAction(_ sender: Any) {
        let vc = HomeScreenVC()
        self.navigationController?.popToViewController(vc, animated: true)
    }
}

extension SideMenuVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Account.count
        case 1:
            return Notification.count
        case 2:
            return More.count
        default :
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableCell", for: indexPath) as! SideMenuTableCell
        section = indexPath.section
        switch indexPath.section {
        case 0:
            cell.sideMenuLabel.text = Account[indexPath.row]
            cell.notificationToggleBtnOutlet.isHidden = true
            cell.rightArrowOutlet.isHidden = false
        case 1:
            cell.sideMenuLabel.text = Notification[indexPath.row]
            cell.notificationToggleBtnOutlet.isHidden = false
            cell.rightArrowOutlet.isHidden = true
        case 2:
            
            cell.sideMenuLabel.text = More[indexPath.row]
            cell.notificationToggleBtnOutlet.isHidden = true
            cell.rightArrowOutlet.isHidden = false
        default:
            return cell
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UINib(nibName: "SectionHeaderView",bundle: nil).instantiateView as! SectionHeaderView
        switch section {
        case 0:
            sectionHeader.headerLabel.text = AccountHeader[0]
            sectionHeader.headerImage.image = HeaderImage[0]
        case 1:
            sectionHeader.headerLabel.text = AccountHeader[1]
            sectionHeader.headerImage.image = HeaderImage[1]
        case 2:
            sectionHeader.headerLabel.text = AccountHeader[2]
            sectionHeader.headerImage.image = HeaderImage[2]
           
        default:
            return sectionHeader
        }
        return sectionHeader
        
    }
}
