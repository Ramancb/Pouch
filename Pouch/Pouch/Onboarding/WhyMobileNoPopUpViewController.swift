//
//  WhyMobileNoPopUpViewController.swift
//  Pouch
//
//  Created by Piyush Kumar on 31/01/23.
//

import UIKit

class WhyMobileNoPopUpViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var gotItBtnBgView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        information()
        self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.frame.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gotItBtnBgView.applyGradient(colours: [UIColor(hexString: "#F8D777"), UIColor(hexString: "#BB962D") ], locations: [0,1])
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform.identity
        }
    }
    
    func information() {
        let attributedString = NSMutableAttributedString(string: "Lorem ipsem is dummy text \n Used for printing and text.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        informationLabel.attributedText = attributedString
    }
    
    @IBAction func gotItAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.frame.height)
        } completion: { isSucceed in
            self.dismiss(animated: false)
        }
    }
}
