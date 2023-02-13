//
//  MembershipVC.swift
//  Pouch
//
//  Created by Prince on 06/02/23.
//

import UIKit

class MembershipVC: UIViewController {
    
    @IBOutlet weak var dinnerTypeLabel: UILabel!
    
    @IBOutlet weak var membershipBackground: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var vacationWorldLabel: UILabel!
    @IBOutlet weak var tollFreeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discountRuppee: UILabel!
    @IBOutlet weak var validThruTop: NSLayoutConstraint!
    @IBOutlet weak var bronzeTop: NSLayoutConstraint!
    @IBOutlet weak var nameTop: NSLayoutConstraint!
    @IBOutlet weak var dismissTop: NSLayoutConstraint!
    @IBOutlet weak var qrViewTop: NSLayoutConstraint!
    @IBOutlet weak var foodVoucher: UIImageView!
    @IBOutlet weak var rsOffLabel: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    var membership_Type : MembershipType = .foodVoucher
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Membership()
        rsOffLabel.text = "Rs \nOFF"
    }
    func Membership() {
        switch membership_Type{
        case .membership:
            foodVoucher.isHidden = true
            dismissButton.isHidden = true
            arrowButton.isHidden = true
            nameLabel.isHidden = false
            discountRuppee.isHidden = true
            rsOffLabel.isHidden = true
            dinnerTypeLabel.isHidden = false
            vacationWorldLabel.isHidden = false
            tollFreeLabel.isHidden = false
            membershipBackground.image = UIImage(named: "membership_bg_img")
        case .foodVoucher:
            foodVoucher.isHidden = false
            dismissButton.isHidden = false
            arrowButton.isHidden = false
            nameLabel.isHidden = true
            dinnerTypeLabel.isHidden = true
            vacationWorldLabel.isHidden = true
            tollFreeLabel.isHidden = true
            self.backgroundView.applyGradient(colours: [UIColor(hexString: "#35005D"), UIColor(hexString: "#6426A2") ], locations: [0,1])
        case .coupons:
            foodVoucher.image = UIImage(named: "Coupon_ic")
            dismissButton.isHidden = false
            arrowButton.isHidden = false
            discountRuppee.isHidden = false
            rsOffLabel.isHidden = false
            nameLabel.isHidden = true
            dinnerTypeLabel.isHidden = true
            vacationWorldLabel.isHidden = true
            tollFreeLabel.isHidden = true
            self.backgroundView.applyGradient(colours: [UIColor(hexString: "#DDB84D"), UIColor(hexString: "#BB962D") ], locations: [0,1])
        default:
            break
        }
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        self.present(DeletePopUpVC(), false)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.popVC()
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
    }
    
    @IBAction func arrowAction(_ sender: UIButton) {
    }
}
