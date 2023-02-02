//
//  SideMenuVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 02/02/23.
//

import UIKit

class SideMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var arr:[String] = ["EditProfile", "ChangePassword","Privacy","Notifications","App Notifications","Language","Country"]

   
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
