//
//  WhyMobileNoPopUpViewController.swift
//  Pouch
//
//  Created by Piyush Kumar on 31/01/23.
//

import UIKit

class InformationPopUpController: UIViewController, InformationViewProtocol {
    
    /// ViewController IBoutlets
    @IBOutlet weak var contentView: SwipeableView!
    @IBOutlet weak var gotItBtnBgView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    
    /// ViewController global variables
    var presenter: InformationPresenterProtocol?
    
    /// ViewController lyfecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        informationLabel.text = AppStrings.infoDesc
        informationLabel.setLineSpacing(lineSpacing: 5.0, textAlignment: .center)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gotItBtnBgView.applyGradient(colours: [UIColor(hexString: "#F8D777"), UIColor(hexString: "#BB962D") ], locations: [0,1])
        self.contentView.setInitialAnimation(delegate: self)
    }
    
    /// ViewController IBAction
    @IBAction func gotItAction(_ sender: Any) {
        // animate view to dismiss
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.frame.height)
        } completion: { isSucceed in
            self.dismiss(animated: false)
        }
    }
}

extension InformationPopUpController: SwipeableViewDelegate{
    func dismissView() {
        self.dismiss(animated: false)
    }
}
