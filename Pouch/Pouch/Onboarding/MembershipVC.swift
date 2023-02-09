//
//  MembershipVC.swift
//  Pouch
//
//  Created by Prince on 06/02/23.
//

import UIKit

class MembershipVC: UIViewController {
    
    @IBOutlet weak var cardNumberView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardNumberView.applyGradient(colours: [UIColor(hexString: "#A2134A"), UIColor(hexString: "#000000") ], locations: [0.1,0.4])
    }

    @IBAction func deleteAction(_ sender: UIButton) {
        let vc = DeletePopUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
