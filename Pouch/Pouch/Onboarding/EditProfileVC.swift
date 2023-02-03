//
//  EditProfileVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var editProfileView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileView.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.1,0.7])
        
    }


 

}
