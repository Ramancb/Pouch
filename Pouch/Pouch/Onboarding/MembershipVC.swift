//
//  MembershipVC.swift
//  Pouch
//
//  Created by Prince on 06/02/23.
//

import UIKit

class MembershipVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func deleteAction(_ sender: UIButton) {
        self.present(DeletePopUpVC(), false)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.popVC()
    }
    

}
