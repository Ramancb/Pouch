//
//  MembershipVC.swift
//  Pouch
//
//  Created by Prince on 06/02/23.
//

import UIKit

class MembershipVC: UIViewController {
    
    @IBOutlet weak var nameTop: NSLayoutConstraint!
    @IBOutlet weak var dinnerTypeLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var membershipBackground: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var vacationWorldLabel: UILabel!
    @IBOutlet weak var tollFreeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discountRuppee: UILabel!
    @IBOutlet weak var foodVoucher: UIImageView!
    @IBOutlet weak var rsOffLabel: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var bronzeDetailLabel: UILabel!
    @IBOutlet weak var bronzeLabel: UILabel!
    @IBOutlet weak var cardDetailView: UIStackView!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    @IBOutlet weak var hotelNameLabel: UILabel!
    
    var membership_Type : CardType = .membership
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Membership()
    }
    func Membership() {
        switch membership_Type{
        case .membership:
            nameTop.constant = 32
            dinnerTypeLabel.isHidden = false
            vacationWorldLabel.isHidden = false
            nameLabel.isHidden = false
            tollFreeLabel.isHidden = false
            foodVoucher.isHidden = true
            dismissButton.isHidden = true
            discountRuppee.isHidden = true
            arrowButton.isHidden = true
            rsOffLabel.isHidden = true
            nameLabel.font = UIFont.setCustom(.latoSemibold, 18)
            dinnerTypeLabel.font = UIFont.setCustom(.latoRegular, 18)
            hotelNameLabel.font = UIFont.setCustom(.latoSemibold, 17)
            hotelAddressLabel.font = UIFont.setCustom(.latoRegular, 13)
            bronzeLabel.font = UIFont.setCustom(.latoRegular, 18)
            bronzeDetailLabel.font = UIFont.setCustom(.latoSemibold, 18)
            bronzeDetailLabel.textColor = UIColor.appColor(.themeWhite)
            dinnerTypeLabel.textColor = UIColor.white.withAlphaComponent(0.4)
            bronzeLabel.textColor = UIColor.white.withAlphaComponent(0.4)
            hotelAddressLabel.textColor = UIColor.appColor(.themeBlack)?.withAlphaComponent(0.68)
            viewLine.backgroundColor = UIColor.white.withAlphaComponent(0.14)
            deleteButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            membershipBackground.image = UIImage(named: AppStrings.backgroundImage)
            
        case .foodVoucher:
            nameTop.constant = 31
            foodVoucher.isHidden = false
            dismissButton.isHidden = false
            arrowButton.isHidden = false
            nameLabel.isHidden = false
            dinnerTypeLabel.isHidden = false
            deleteButton.isHidden = true
            closeButton.isHidden = true
            vacationWorldLabel.isHidden = true
            rsOffLabel.isHidden = true
            discountRuppee.isHidden = true
            tollFreeLabel.isHidden = true
            cardDetailView.isHidden = true
            nameLabel.font = UIFont.setCustom(.latoSemibold, 18)
            bronzeLabel.font = UIFont.setCustom(.latoSemibold, 18)
            bronzeDetailLabel.font = UIFont.setCustom(.latoRegular, 18)
            hotelNameLabel.font = UIFont.setCustom(.latoSemibold, 17)
            hotelAddressLabel.font = UIFont.setCustom(.latoRegular, 13)
            dinnerTypeLabel.font = UIFont.setCustom(.latoRegular, 18)
            dinnerTypeLabel.textColor = UIColor.white.withAlphaComponent(0.4)
            bronzeLabel.textColor = UIColor.appColor(.themeWhite)
            hotelAddressLabel.textColor = UIColor.appColor(.themeBlack)?.withAlphaComponent(0.68)
            bronzeDetailLabel.textColor = UIColor.white.withAlphaComponent(0.4)
            viewLine.backgroundColor = UIColor.appColor(.Grey)?.withAlphaComponent(0.14)
            bronzeLabel.text = AppStrings.title
            bronzeDetailLabel.text = AppStrings.tollFree
            dinnerTypeLabel.text = AppStrings.dinnerType
            self.membershipBackground.applyGradient(colours: [UIColor(hexString: "#35005D"), UIColor(hexString: "#6426A2") ], locations: [0,1])
       
     case .coupons:
            nameTop.constant = 18
            dismissButton.isHidden = false
            arrowButton.isHidden = false
            discountRuppee.isHidden = false
            rsOffLabel.isHidden = false
            nameLabel.isHidden = true
            deleteButton.isHidden = true
            closeButton.isHidden = true
            dinnerTypeLabel.isHidden = true
            vacationWorldLabel.isHidden = true
            tollFreeLabel.isHidden = true
            cardDetailView.isHidden = true
            bronzeLabel.font = UIFont.setCustom(.latoSemibold, 19)
            hotelNameLabel.font = UIFont.setCustom(.latoSemibold, 14)
            hotelAddressLabel.font = UIFont.setCustom(.latoRegular, 18)
            bronzeDetailLabel.font = UIFont.setCustom(.latoRegular, 19)
            bronzeLabel.textColor = UIColor.appColor(.themeWhite)
            bronzeDetailLabel.textColor = UIColor.white.withAlphaComponent(0.75)
            hotelAddressLabel.textColor = UIColor.black.withAlphaComponent(0.75)
            hotelAddressLabel.backgroundColor = UIColor.appColor(.transparent)
            viewLine.backgroundColor = UIColor.appColor(.whiteOpacity)
            hotelAddressLabel.textAlignment = .center
            bronzeDetailLabel.text = AppStrings.tollFree
            hotelAddressLabel.text = AppStrings.code
            bronzeLabel.text = AppStrings.title
            rsOffLabel.text = AppStrings.rsOff
            hotelNameLabel.text = AppStrings.hotelName
            foodVoucher.image = UIImage(named: AppStrings.coupon)
            self.membershipBackground.applyGradient(colours: [UIColor(hexString: "#DDB84D"), UIColor(hexString: "#BB962D") ], locations: [0,1])
            
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
