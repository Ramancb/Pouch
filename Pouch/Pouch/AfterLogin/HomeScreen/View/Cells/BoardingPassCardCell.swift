//
//  BoardingPassCardCell.swift
//  Pouch
//
//  Created by Raman choudhary on 09/03/23.
//

import UIKit

class BoardingPassCardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardBgView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var qrText2label: UILabel!
    @IBOutlet weak var qrText1Label: UILabel!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var flightValueLabel: UILabel!
    @IBOutlet weak var seatValueLabel: UILabel!
    @IBOutlet weak var departureValueLabel: UILabel!
    @IBOutlet weak var flightLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var seatTypeLabel: UILabel!
    @IBOutlet weak var passangerNameLabel: UILabel!
    @IBOutlet weak var passangerLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoBgView: UIView!
    @IBOutlet weak var toPlaceLabel: UILabel!
    @IBOutlet weak var toCodeLabel: UILabel!
    @IBOutlet weak var fromPlaceLabel: UILabel!
    @IBOutlet weak var fromCodeLabel: UILabel!
    
    var templateData:TemplatesData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setBoardingPassCard(card:CardsData?){
        DatabaseManager.shared.isDbDocumentExist(dbName: DatabaseManager.kTemplateDBName, templateName: card?.templateName ?? "") { data, error in
            self.templateData = data
            self.setData(cardData: card)
       }
        
    }
    
    func setData(cardData:CardsData?){
        let primaryText = templateData?.provider?.layoutWiseConfig?.boardingPass?.primaryText
        let secondaryText = templateData?.provider?.layoutWiseConfig?.boardingPass?.secondaryText
        let provider = templateData?.provider
//        let varient = card?.template?.variant
        let layout = templateData?.provider?.layoutWiseConfig?.boardingPass?.backgroundFront
        
        self.fromCodeLabel.setLabel(cardData?.sourceAirport, UIColor(hex: primaryText?.color ?? "#000000"), .latoBold, 29)
        self.toCodeLabel.setLabel(cardData?.destinationAirport, UIColor(hex: primaryText?.color ?? "#000000"), .latoBold, 29)
        self.toPlaceLabel.setLabel(cardData?.sourceCity, UIColor(hex: secondaryText?.color ?? "#000000"), .latoSemibold, 14)
        self.fromPlaceLabel.setLabel(cardData?.destinationCity, UIColor(hex: secondaryText?.color ?? "#000000"), .latoSemibold, 14)
        self.logoImage.image = provider?.logoSmall?.base64ToImage()
        self.passangerLabel.setLabel("PASSANGER", UIColor(hex: secondaryText?.color ?? "#000000"), .latoRegular, 11)
        self.passangerNameLabel.setLabel(cardData?.passengerName, UIColor(hex: primaryText?.color ?? "#000000"), .latoRegular, 14)
        self.seatTypeLabel.setLabel(cardData?.compartment, UIColor(hex: secondaryText?.color ?? "#000000"), .latoBold, 11)
        self.departureLabel.setLabel("DEPARTURE", UIColor(hex: secondaryText?.color ?? "#000000"), .latoRegular, 11)
        self.seatLabel.setLabel("SEAT", UIColor(hex: secondaryText?.color ?? "#000000"), .latoRegular, 11)
        self.flightLabel.setLabel("FLIGHT", UIColor(hex: secondaryText?.color ?? "#000000"), .latoRegular, 11)
        let date = Date(milliseconds: cardData?.flightDateTime ?? 0)
        self.departureValueLabel.setLabel("0000 Hrs", UIColor(hex: primaryText?.color ?? "#000000"), .latoSemibold, 14)
        self.seatValueLabel.setLabel(cardData?.seatNo, UIColor(hex: primaryText?.color ?? "#000000"), .latoSemibold, 14)
        self.flightValueLabel.setLabel("\(cardData?.airlineCode ?? "") \(cardData?.flightNumber ?? "")", UIColor(hex: primaryText?.color ?? "#000000"), .latoSemibold, 14)
        self.qrCodeImageView.image = cardData?.qrCode?.base64ToImage()
        self.cardBgView.backgroundColor = UIColor(hex: layout?.colorPrimary ?? "#FFFFFF")
        self.logoBgView.backgroundColor = UIColor(hex: provider?.layoutWiseConfig?.boardingPass?.airlineBoxBackground ?? "#FFFFFF")
        qrText2label.setLabel(cardData?.pnrCode,UIColor(hex: secondaryText?.color ?? "#000000") , .latoRegular, 11)
        qrText1Label.setLabel(date.toString(format: .ddM3y4), UIColor(hex: secondaryText?.color ?? "#000000"), .latoRegular, 11)
    }
}
