//
//  WhyMobileNoPopUpViewController.swift
//  Pouch
//
//  Created by Piyush Kumar on 31/01/23.
//

import UIKit

class InformationPopUpController: UIViewController, InformationViewProtocol {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var gotItBtnBgView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    
    var presenter: InformationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationLabel.setLineSpacing(lineSpacing: 5.0, textAlignment: .center)
        self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.frame.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gotItBtnBgView.applyGradient(colours: [UIColor(hexString: "#F8D777"), UIColor(hexString: "#BB962D") ], locations: [0,1])
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func gotItAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.frame.height)
        } completion: { isSucceed in
            self.dismiss(animated: false)
        }
    }
}
