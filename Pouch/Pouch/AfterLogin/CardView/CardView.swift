//
//  CardView.swift
//  Pouch
//
//  Created by Raman choudhary on 13/03/23.
//

import UIKit

protocol CardViewDelegate{
    func closeCard()
    func deleteCard(cardData:CardsData?)
}

class CardView: UIView {

    
    @IBOutlet weak var invitationTextLabel: UILabel!
    @IBOutlet weak var invitationTextBgView: UIView!
    @IBOutlet weak var eventMarkView: UIView!
    @IBOutlet weak var termConditionsLabel: UILabel!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var durationDescLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personInfoView: UIView!
    @IBOutlet weak var validViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var validViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventCloseBtn: UIButton!
    @IBOutlet weak var eventDeleteBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var extraDescBgView: UIView!
    @IBOutlet weak var extraDescLabel: UILabel!
    @IBOutlet weak var howToUseLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var botttomCardTitleLabel: UILabel!
    @IBOutlet weak var bottomContactView: UIView!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var eventCardTopView: UIView!
    @IBOutlet weak var contactBgView: UIView!
    @IBOutlet weak var cardDescLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var dueDateValueLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var validThruValueLabel: UILabel!
    @IBOutlet weak var validThruLabel: UILabel!
    @IBOutlet weak var cardValidDateBgView: UIView!
    @IBOutlet weak var cardValidDateView: UIView!
    @IBOutlet weak var membershipIdLabel: UILabel!
    @IBOutlet weak var membershipTypeLabel: UILabel!
    @IBOutlet weak var membershipTypeView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoImageBgView: UIView!
    @IBOutlet weak var cardBgView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var qrCodeBgView: UIView!
    
    @IBOutlet weak var largeQrCodeImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var qrTitleLabel: UILabel!
    
    ///Voucher outlets
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var voucherNameBgView: UIView!
    @IBOutlet weak var voucherMaxPersonBgView: UIView!
    @IBOutlet weak var voucherNameLabel: UILabel!
    @IBOutlet weak var voucherCodeLabel: UILabel!
    @IBOutlet weak var percentStackView: UIStackView!
    
    ///coupon outlets
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var dottedLineBgView: UIView!
    @IBOutlet weak var percentOffLabel: UILabel!
    

    private var provider: Provider?
    private var varient: Variant?
    private var layoutData:MEMBERSHIP?
    var cardData:CardsData?
    var delegate:CardViewDelegate?
    
    private let nibName = "CardView"
    
    override init(frame:CGRect){
        super.init(frame: frame)
        commonInIt()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInIt()
    }
    
    public var isOpen:Bool = false
    
    private func  commonInIt(){
         Bundle.main.loadNibNamed( nibName, owner: self, options: nil)
        self.cardBgView.frame = self.bounds
        self.cardBgView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.addSubview(self.cardBgView)
    }
    
    func setCardViewData(data: CardsData?){
        self.cardData = data
        self.voucherNameBgView.isHidden = (data?.type == CardType.membership.rawValue || data?.type == CardType.event.rawValue)
        self.percentStackView.isHidden = data?.type == CardType.voucher.rawValue
        self.voucherMaxPersonBgView.isHidden = !(data?.type == CardType.voucher.rawValue)
        self.membershipTypeView.isHidden = data?.type == CardType.voucher.rawValue
        self.cardValidDateBgView.isHidden = !(data?.type == CardType.membership.rawValue || data?.type == CardType.event.rawValue)
        self.dottedLineBgView.isHidden = !(data?.type == CardType.coupon.rawValue) || self.isOpen
        self.logoImageBgView.isHidden = data?.type == CardType.event.rawValue
        self.qrCodeImageView.isHidden = !(data?.type == CardType.event.rawValue)
        self.eventCardTopView.isHidden = !(data?.type == CardType.event.rawValue)
        self.validViewLeadingConstraint.constant = (data?.type == CardType.membership.rawValue && self.isOpen) ? 30 : 0
        self.validViewTrailingConstraint.constant = (data?.type == CardType.membership.rawValue && self.isOpen) ? 30 : 0
        self.cardValidDateView.cornerRadius = (data?.type == CardType.membership.rawValue && self.isOpen) ? 10 : 0
        self.personInfoView.isHidden = !(data?.type == CardType.membership.rawValue && self.isOpen)
        self.eventMarkView.isHidden = !(data?.type == CardType.event.rawValue && !self.isOpen)
        self.topLineView.isHidden = !(self.isOpen && data?.type != CardType.event.rawValue)
        self.invitationTextBgView.isHidden = !(data?.type == CardType.event.rawValue && self.isOpen)
        self.qrCodeBgView.isHidden = !(self.isOpen)
        self.bottomContactView.isHidden = !(self.isOpen)
        self.extraDescBgView.isHidden = !(self.isOpen)
        self.contactBgView.isHidden = self.isOpen
        self.deleteBtn.isHidden = !(self.isOpen)
        self.closeBtn.isHidden = !(self.isOpen)
        self.eventDeleteBtn.isHidden = !(self.isOpen)
        self.eventCloseBtn.isHidden = !(self.isOpen)
        self.verifiedImageView.isHidden = self.isOpen || data?.isActive == false
        self.verifiedImageView.image = UIImage(named: "Coupon_ic")
        self.scrollView.isUserInteractionEnabled = self.isOpen
        self.setCardLayoutWise(card: data)
    }
    
    func setCardLayoutWise(card:CardsData?){
        guard let templateName = card?.templateName else{return}
        DatabaseManager.shared.isDbDocumentExist(dbName: DatabaseManager.kTemplateDBName, templateName: templateName) { data, error in
            self.provider = data?.provider
            self.varient = data?.variant
            switch card?.type{
            case CardType.voucher.rawValue:
                self.setVoucherCard(card: card)
            case  CardType.event.rawValue:
                self.setEventCard(card: card)
            case CardType.coupon.rawValue:
                self.setCouponCard(card: card)
            case  CardType.membership.rawValue:
                self.setMembershipCard(card: card)
            default :
                self.setMembershipCard(card: card)
            }
       }
    }
    
    func setBackgroudViews(layout:BackgroundFront?){
        self.backgroundImageView.image = layout?.image?.base64ToImage()
        cardBgView.backgroundColor = UIColor(hex: layout?.color ?? "#FFFFFF")
//        if layout?.type == BackGroundFrontType.grad_color_Image.rawValue ||  layout?.type == BackGroundFrontType.gradient.rawValue{
//            cardBgView.applyGradient(colours: [UIColor(hex: layout?.colorPrimary ?? "#FFFFFF") ?? .clear,UIColor(hex: layout?.colorSecondary ?? "#FFFFFF") ?? .clear], locations: [0,1])
//        }else{
//            cardBgView.backgroundColor = UIColor(hex: layout?.colorPrimary ?? "#FFFFFF")
//        }
    }
    
    func setBottomContactView(){
        self.botttomCardTitleLabel.setLabel(provider?.displayName, UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"),.latoSemibold,14)
        self.phoneLabel.setLabel(provider?.phone, UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"),.latoSemibold,14)
        self.websiteLabel.setLabel(provider?.website, UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"),.latoSemibold,14)
        self.phoneLabel.set(text: provider?.phone ?? "",leftIcon: UIImage(named: "ico_support_phone"))
        self.websiteLabel.set(text: provider?.website ?? "",leftIcon: UIImage(named: "ico_website"))
        self.phoneLabel.isUserInteractionEnabled = true
        self.websiteLabel.isUserInteractionEnabled = true
        self.phoneLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.callAction(gesture:))))
        self.websiteLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openWebsite(gesture:))))
    }
    
    @objc func callAction(gesture:UIGestureRecognizer){
        guard let url = URL(string: "telprompt://\(provider?.phone ?? "")"),
                UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func openWebsite(gesture:UIGestureRecognizer){
        guard let webLink = provider?.website else{return}
        guard let url = URL(string: webLink.hasPrefix("https://") ? webLink : "https://\(webLink)" ) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            Singleton.shared.showErrorMessage(error: "Invalid url!", isError: .error)
        }
    }
    
    func setViewForDetail(card:CardsData?){
        self.qrTitleLabel.setLabel(provider?.displayName, UIColor(hex: layoutData?.qrColor ?? "#FFFFFF"),.latoBold,14)
        self.addressLabel.setLabel("\(provider?.address?.streetAddress ?? ""),  \(provider?.address?.locality ?? ""), \(provider?.address?.city ?? ""), \(provider?.address?.state ?? ""), \(provider?.address?.country ?? "")", UIColor(hex: layoutData?.qrColor ?? "#FFFFFF"),.latoRegular,14)
        self.howToUseLabel.setLabel(layoutData?.headingDetailExtra, UIColor(hex: layoutData?.secondaryText?.color ?? "#FFFFFF"), .latoBold, 18)
        self.extraDescLabel.attributedText = BulletListHelper.createBulletedList(fromStringArray: layoutData?.detailListExtra ?? [],font: UIFont.setCustom(.latoRegular, 14), color: UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"))
        self.largeQrCodeImageView.image = card?.qrCode?.base64ToImage()
    }
    
    func setMembershipCard(card:CardsData?){
        self.layoutData = provider?.layoutWiseConfig?.mEMBERSHIP
        // set data layout wise
        self.setBackgroudViews(layout: layoutData?.backgroundFront)
        
        // set varientData
        self.membershipTypeLabel.setLabel(varient?.layoutVariant?.displayName, UIColor(hex: layoutData?.secondaryText?.color ?? "#FFFFFF"),.latoRegular,18)
        // set provider data
        self.logoImage.image = provider?.logoSmall?.base64ToImage()
        self.cardDescLabel.setLabel(provider?.displayName, UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"),.latoSemibold,14)
        self.contactLabel.setLabel(provider?.phone, UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"),.latoSemibold,14)
        self.setBottomContactView()
        // set card data
        self.validThruLabel.setLabel("Valid Thru", UIColor(hex: layoutData?.secondaryText?.color ?? "#FFFFFF"),.latoRegular,15)
        self.dueDateLabel.setLabel("Due Date", UIColor(hex: layoutData?.secondaryText?.color ?? "#FFFFFF"),.latoRegular,15)
        self.validThruValueLabel.setLabel(card?.expiry, UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"),.latoSemibold,18)
        self.dueDateValueLabel.setLabel(card?.renewalDate, UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"),.latoSemibold,18)
        self.membershipIdLabel.setLabel(card?.valueToEncode,  UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoSemibold,18)
        self.personNameLabel.setLabel(card?.nameOnAccount,  UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoSemibold,18)
        self.durationDescLabel.setLabel(self.getBalanceString(cardData: card),  UIColor(hex: layoutData?.secondaryText?.color ?? "#ffffff"),.latoRegular,18)
        self.termConditionsLabel.setLabel("t&c", UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoRegular,15)
        self.contactBgView.backgroundColor = .clear
        self.setViewForDetail(card: card)
    }
    
    func getBalanceString(cardData:CardsData?)-> String{
        var balanceString = ""
        if let prefix = layoutData?.balancePrefix{
            balanceString.append(contentsOf: "\(prefix) ")
        }
        if let balance = cardData?.balance{
            balanceString.append(contentsOf: "\(balance) ")
        }
        
        if let suffix = layoutData?.balanceSuffix{
            balanceString.append(contentsOf: "\(suffix) ")
        }
        return balanceString
    }
    
    func setVoucherCard(card:CardsData?){
        layoutData = provider?.layoutWiseConfig?.vOUCHER
        
        // set data layout wise
        setBackgroudViews(layout: layoutData?.backgroundFront)
        
        // set provider data
        logoImage.image = provider?.logoSmall?.base64ToImage()
        self.cardDescLabel.setLabel(provider?.displayName, UIColor(hex: layoutData?.secondaryText?.color ?? "#ffffff"),.latoSemibold,14)
        self.contactLabel.setLabel(provider?.phone, UIColor(hex: layoutData?.secondaryText?.color ?? "#ffffff"),.latoSemibold,14)
       setBottomContactView()
        // set card data
       voucherNameLabel.setLabel("\(card?.serviceName ?? "")\nVoucher", UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"), .latoExtraLight, 47)
        countLabel.setLabel("\(card?.maxPersons ?? 0)",  UIColor(hex: layoutData?.secondaryText?.color ?? "#FFFFFF"), .latoSemibold, 16)
        voucherCodeLabel.setLabel(card?.valueToEncode, UIColor(hex: layoutData?.primaryText?.color ?? ""), .latoSemibold, 16)
        self.setViewForDetail(card: card)
        self.termConditionsLabel.setLabel("t&c", UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoRegular,15)
        contactBgView.backgroundColor = .white
    }
    
    func setCouponCard(card:CardsData?){
        layoutData = provider?.layoutWiseConfig?.cOUPON
        
        // set data layout wise
        setBackgroudViews(layout: layoutData?.backgroundFront)
        
        // set provider data
        self.logoImage.image = provider?.logoSmall?.base64ToImage()
        self.cardDescLabel.setLabel(provider?.displayName, UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoSemibold,14)
        self.contactLabel.setLabel(provider?.phone, UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoSemibold,14)
        setBottomContactView()

        // set card data
        self.membershipTypeLabel.setLabel(card?.validFor, UIColor(hex: layoutData?.secondaryText?.color ?? "#ffffff"),.latoRegular,14)
        self.membershipIdLabel.setLabel(card?.valueToEncode, UIColor(hex: layoutData?.secondaryText?.color ?? "#ffffff"),.latoSemibold,14)
        self.voucherNameLabel.setLabel("\(card?.discount?.toInt ?? 0)", UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"), .latoExtraLight, 76)
        if card?.discountType == DiscountType.ptOff.rawValue{
            self.percentLabel.setLabel("%",  UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"), .latoExtraLight, 38)
            self.percentOffLabel.setLabel("OFF",  UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF"), .latoExtraLight, 38)
        }
        self.dottedLineBgView.addHorizontalDashedBorder(color: UIColor(hex: layoutData?.primaryText?.color ?? "#FFFFFF") ?? .gray)
        self.setViewForDetail(card: card)
        self.termConditionsLabel.setLabel("t&c", UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoRegular,15)
        self.contactBgView.backgroundColor = .clear
    }
    
    func setEventCard(card:CardsData?){
        layoutData = provider?.layoutWiseConfig?.eVENT
       
        // set data layout wise
        setBackgroudViews(layout: layoutData?.backgroundFront)
        
        // set provider data
        self.logoImage.image = provider?.logoSmall?.base64ToImage()
        self.cardDescLabel.setLabel(provider?.displayName, UIColor(hex: layoutData?.secondaryText?.color ?? "#ffffff"),.latoSemibold,14)
        self.contactLabel.setLabel(provider?.phone, UIColor(hex: layoutData?.secondaryText?.color ?? "#ffffff"),.latoSemibold,14)
        setBottomContactView()
        
        // set card data
        self.qrCodeImageView.image = card?.qrCode?.base64ToImage()
        self.eventTypeLabel.setLabel(card?.eventType, UIColor(hex: layoutData?.secondaryText?.color ?? "#ffffff"), .latoRegular, 14)
        self.membershipTypeLabel.setLabel(card?.eventName, UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoSemibold,24)
        self.membershipIdLabel.setLabel(card?.venue, UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoSemibold,14)
        self.validThruLabel.setLabel("Date", UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoRegular,15)
        self.dueDateLabel.setLabel("Time", UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoRegular,15)
        
        let date = card?.dateTime ?? ""
        let dateOnly = date.components(separatedBy: " ").first ?? ""
        let timeOnly = date.replacingOccurrences(of: dateOnly, with: "")
        
        self.validThruValueLabel.setLabel(dateOnly, UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoSemibold,18)
        self.dueDateValueLabel.setLabel(timeOnly, UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoSemibold,18)
        self.setViewForDetail(card: card)
        self.termConditionsLabel.setLabel("t&c", UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoRegular,15)
        self.invitationTextLabel.setLabel(varient?.layoutVariant?.invitationText, UIColor(hex: layoutData?.primaryText?.color ?? "#ffffff"),.latoRegular,15)
        self.contactBgView.backgroundColor = .white
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        self.delegate?.deleteCard(cardData: cardData)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.delegate?.closeCard()
    }
}
