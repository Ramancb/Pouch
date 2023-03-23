//
//  UserCardsModel.swift
//  Pouch
//
//  Created by Raman choudhary on 21/02/23.
//

import Foundation
import ObjectMapper

// MARK: - LAYOUT TYPE ENUM CASES DECLARATION
enum CardType: String{
    case voucher = "VOUCHER"
    case event = "EVENT"
    case coupon = "COUPON"
    case membership = "MEMBERSHIP"
    case boardingPass = "BP"
}

// MARK: - CARDS DATA MODEL

struct UserCardsModel : Mappable {
    var success : Bool?
    var response : [CardsData]?

    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        response <- map["response"]
    }
}

class CardsData : NSObject,Mappable {
    var userId : String?
    var externalResourceId : String?
    var nameOnAccount : String?
    var paymentCycle : String?
    var consumed : Bool?
    var isOneTimeUse : Bool?
    var status : String?
    var deleted : Bool?
    var isActive : Bool?
    var qrCode : String?
    var version : String?
    var balance : String?
    var type : String?
    var expired : Bool?
    var id : String?
    var tnCText : String?
    var validity : String?
    var accountNo : String?
    var validFrom : String?
    var expiry : String?
    var renewalDate : String?
    var valueToEncode : String?
    var categoryId : String?
    var templateName : String?
    
    
    // voucher......
    var voucherCode : String?
    var amount : String?
    var validTill : String?
    var vendorType : String?
    var serviceName : String?
    var validAt : String?
    var maxPersons : Int?
    
    // coupon....
    var discountType : String?
    var discount : Double?
    var minPurchase : Int?
    var validFor : String?
    
    //Event.....
    var eventName : String?
    var eventType : String?
    var dateTime : String?
    var address : Address?
    var venue : String?
    var invitationText : String?
    var eventScheduleUrl : String?
    
    //Boarding pass....
    var flightNumber : String?
    var airlineCode : String?
    var compartment : String?
    var pnrCode : String?
    var uniqueID : String?
    var gate : String?
    var fastTrack : Bool?
    var sourceAirport : String?
    var destinationAirport : String?
    var sourceCity : String?
    var sequenceNo : String?
    var destinationCity : String?
    var seatNo : String?
    var flightDateTime : Int?
    var barcodeType : String?
    var passengerName : String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        userId <- map["userId"]
        externalResourceId <- map["externalResourceId"]
        nameOnAccount <- map["nameOnAccount"]
        paymentCycle <- map["paymentCycle"]
        consumed <- map["consumed"]
        isOneTimeUse <- map["isOneTimeUse"]
        status <- map["status"]
        deleted <- map["deleted"]
        isActive <- map["isActive"]
        qrCode <- map["qrCode"]
        version <- map["version"]
        balance <- map["balance"]
        type <- map["type"]
        expired <- map["expired"]
        id <- map["id"]
        tnCText <- map["tnCText"]
        validity <- map["validity"]
        accountNo <- map["accountNo"]
        validFrom <- map["validFrom"]
        expiry <- map["expiry"]
        renewalDate <- map["renewalDate"]
        valueToEncode <- map["valueToEncode"]
        categoryId <- map["categoryId"]
        templateName <- map["templateName"]
        
        // Voucher....
        voucherCode <- map["voucherCode"]
        amount <- map["amount"]
        validTill <- map["validTill"]
        vendorType <- map["vendorType"]
        serviceName <- map["serviceName"]
        validAt <- map["validAt"]
        maxPersons <- map["maxPersons"]
        
        // coupon....
        discountType <- map["discountType"]
        discount <- map["discount"]
        validFor <- map["validFor"]
        minPurchase <- map["minPurchase"]
        
        //Events....
        eventName <- map["eventName"]
        eventType <- map["eventType"]
        dateTime <- map["dateTime"]
        address <- map["address"]
        venue <- map["venue"]
        invitationText <- map["invitationText"]
        eventScheduleUrl <- map["eventScheduleUrl"]
        
        //BoardingPass
        flightNumber <- map["flightNumber"]
        airlineCode <- map["airlineCode"]
        compartment <- map["compartment"]
        pnrCode <- map["pnrCode"]
        uniqueID <- map["uniqueID"]
        gate <- map["gate"]
        fastTrack <- map["fastTrack"]
        sourceAirport <- map["sourceAirport"]
        destinationAirport <- map["destinationAirport"]
        sourceCity <- map["sourceCity"]
        sequenceNo <- map["sequenceNo"]
        destinationCity <- map["destinationCity"]
        seatNo <- map["seatNo"]
        flightDateTime <- map["flightDateTime"]
        barcodeType <- map["barcodeType"]
        passengerName <- map["passengerName"]
    }
}

// MARK: - CATEGORIES DATA MODEL
struct CategoriesModel : Mappable {
    var success : Bool?
    var response : [CategoryData]?

    init?(map: Map) {
        
    }

    mutating func mapping(map: Map) {
        success <- map["success"]
        response <- map["response"]
    }

}

struct CategoryData : Mappable {
    var displayName : String?
    var active : Bool?
    var deleted : Bool?
    var id : String?
    var iconUrl : String?
    var order : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        displayName <- map["displayName"]
        active <- map["active"]
        deleted <- map["deleted"]
        id <- map["id"]
        iconUrl <- map["iconUrl"]
        order <- map["order"]
        name <- map["name"]
    }

}

// MARK: - TEMPLATES DATA MODEL

struct TemplatesModel : Mappable {
    var success : Bool?
    var response : [TemplatesData]?

    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        response <- map["response"]
    }
}

struct TemplateByNameModel : Mappable {
    var success : Bool?
    var response : TemplatesData?

    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        response <- map["response"]
    }
}

struct TemplatesData : Mappable {
    var variant : Variant?
    var id : String?
    var provider : Provider?
    var name : String?
    var type : String?
    var category : CategoryData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        variant <- map["variant"]
        id <- map["id"]
        provider <- map["provider"]
        name <- map["name"]
        type <- map["type"]
        category <- map["category"]
    }
}

struct Variant : Mappable {
    var id : String?
    var deleted : Bool?
    var providerId : String?
    var layoutType : String?
    var layoutVariant : LayoutVariant?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        deleted <- map["deleted"]
        providerId <- map["providerId"]
        layoutType <- map["layoutType"]
        layoutVariant <- map["layoutVariant"]
    }
}

struct LayoutVariant : Mappable {
    var displayName : String?
    var detailListExtra : String?
    var name : String?
    var headingDetailExtra : String?
    var backgroundFront : String?
    var invitationText:String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        displayName <- map["displayName"]
        detailListExtra <- map["detailListExtra"]
        name <- map["name"]
        headingDetailExtra <- map["headingDetailExtra"]
        backgroundFront <- map["backgroundFront"]
        invitationText <- map["invitationText"]
    }
    
}



struct Provider : Mappable {
    var id : String?
    var description : String?
    var logoLarge : String?
    var twitter : String?
    var email : String?
    var phone : String?
    var logoSmall : String?
    var deleted : Bool?
    var address : Address?
    var collaborator : String?
    var website : String?
    var layoutWiseConfig : LayoutWiseConfig?
    var name : String?
    var displayName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        description <- map["description"]
        logoLarge <- map["logoLarge"]
        twitter <- map["twitter"]
        email <- map["email"]
        phone <- map["phone"]
        logoSmall <- map["logoSmall"]
        deleted <- map["deleted"]
        address <- map["address"]
        collaborator <- map["collaborator"]
        website <- map["website"]
        layoutWiseConfig <- map["layoutWiseConfig"]
        name <- map["name"]
        displayName <- map["displayName"]
    }

}

struct Address : Mappable {
    var locality : String?
    var city : String?
    var country : String?
    var zipcode : String?
    var longitude : String?
    var latitude : String?
    var streetAddress : String?
    var state : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        locality <- map["locality"]
        city <- map["city"]
        country <- map["country"]
        zipcode <- map["zipcode"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        streetAddress <- map["streetAddress"]
        state <- map["state"]
    }
}

struct LayoutWiseConfig : Mappable {
    var vOUCHER : MEMBERSHIP?
    var eVENT : MEMBERSHIP?
    var cOUPON : MEMBERSHIP?
    var mEMBERSHIP : MEMBERSHIP?
    var dEFAULT : MEMBERSHIP?
    var boardingPass : MEMBERSHIP?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        vOUCHER <- map["VOUCHER"]
        eVENT <- map["EVENT"]
        cOUPON <- map["COUPON"]
        mEMBERSHIP <- map["MEMBERSHIP"]
        dEFAULT <- map["DEFAULT"]
        boardingPass <- map["BP"]
    }
}

//struct VOUCHER : Mappable {
//    var secondaryText : SecondaryText?
//    var headingDetailExtra : String?
//    var backgroundFront : BackgroundFront?
//    var qrColor : String?
//    var qrBorderColor : String?
//    var qrDropShadow : Bool?
//    var primaryText : PrimaryText?
//    var detailListExtra : String?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//
//        secondaryText <- map["secondaryText"]
//        headingDetailExtra <- map["headingDetailExtra"]
//        backgroundFront <- map["backgroundFront"]
//        qrColor <- map["qrColor"]
//        qrBorderColor <- map["qrBorderColor"]
//        qrDropShadow <- map["qrDropShadow"]
//        primaryText <- map["primaryText"]
//        detailListExtra <- map["detailListExtra"]
//    }
//}
//
//struct EVENT : Mappable {
//    var secondaryText : SecondaryText?
//    var headingDetailExtra : String?
//    var backgroundFront : BackgroundFront?
//    var qrColor : String?
//    var qrBorderColor : String?
//    var qrDropShadow : Bool?
//    var primaryText : PrimaryText?
//    var detailListExtra : String?
//    var text : String?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//
//        secondaryText <- map["secondaryText"]
//        headingDetailExtra <- map["headingDetailExtra"]
//        backgroundFront <- map["backgroundFront"]
//        qrColor <- map["qrColor"]
//        qrBorderColor <- map["qrBorderColor"]
//        qrDropShadow <- map["qrDropShadow"]
//        primaryText <- map["primaryText"]
//        detailListExtra <- map["detailListExtra"]
//        text <- map["text"]
//    }
//}
//
//struct COUPON : Mappable {
//    var secondaryText : SecondaryText?
//    var headingDetailExtra : String?
//    var backgroundFront : BackgroundFront?
//    var qrColor : String?
//    var qrBorderColor : String?
//    var qrDropShadow : Bool?
//    var primaryText : PrimaryText?
//    var detailListExtra : [String]?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//
//        secondaryText <- map["secondaryText"]
//        headingDetailExtra <- map["headingDetailExtra"]
//        backgroundFront <- map["backgroundFront"]
//        qrColor <- map["qrColor"]
//        qrBorderColor <- map["qrBorderColor"]
//        qrDropShadow <- map["qrDropShadow"]
//        primaryText <- map["primaryText"]
//        detailListExtra <- map["detailListExtra"]
//    }
//}

struct MEMBERSHIP : Mappable {
    var secondaryText : PrimaryText?
    var qrColor : String?
    var balanceSuffix : String?
    var primaryText : PrimaryText?
    var headingDetailExtra : String?
    var qrDropShadow : Bool?
    var detailListExtra : [String]?
    var address : String?
    var qrBorderColor : String?
    var balancePrefix : String?
    var backgroundFront : BackgroundFront?
    var balanceLabel : String?
    
    //bp.....
    var airlineBoxBackground : String?
    var airlineBoxTextStyle : PrimaryText?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        secondaryText <- map["secondaryText"]
        qrColor <- map["qrColor"]
        balanceSuffix <- map["balanceSuffix"]
        primaryText <- map["primaryText"]
        headingDetailExtra <- map["headingDetailExtra"]
        qrDropShadow <- map["qrDropShadow"]
        detailListExtra <- map["detailListExtra"]
        address <- map["address"]
        qrBorderColor <- map["qrBorderColor"]
        balancePrefix <- map["balancePrefix"]
        backgroundFront <- map["backgroundFront"]
        balanceLabel <- map["balanceLabel"]
        
        //boarding pass
        airlineBoxBackground <- map["airlineBoxBackground"]
        airlineBoxTextStyle <- map["airlineBoxTextStyle"]
    }
}


//struct DEFAULT : Mappable {
//    var secondaryText : SecondaryText?
//    var headingDetailExtra : String?
//    var backgroundFront : BackgroundFront?
//    var qrColor : String?
//    var qrBorderColor : String?
//    var qrDropShadow : Bool?
//    var primaryText : PrimaryText?
//    var detailListExtra : String?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//
//        secondaryText <- map["secondaryText"]
//        headingDetailExtra <- map["headingDetailExtra"]
//        backgroundFront <- map["backgroundFront"]
//        qrColor <- map["qrColor"]
//        qrBorderColor <- map["qrBorderColor"]
//        qrDropShadow <- map["qrDropShadow"]
//        primaryText <- map["primaryText"]
//        detailListExtra <- map["detailListExtra"]
//    }
//}


struct BackgroundFront : Mappable {
    var colorPrimary : String?
    var image : String?
    var type : String?
    var colorSecondary : String?
    var color : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        colorPrimary <- map["colorPrimary"]
        image <- map["image"]
        type <- map["type"]
        colorSecondary <- map["colorSecondary"]
        color <- map["color"]
    }

}


//struct SecondaryText : Mappable {
//    var color : String?
//    var shadowColor : String?
//    var fontSize : String?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//        
//        color <- map["color"]
//        shadowColor <- map["shadowColor"]
//        fontSize <- map["fontSize"]
//    }
//}

struct PrimaryText : Mappable {
    var color : String?
    var shadowColor : String?
    var fontSize : String?

    init?(map: Map) {
        
    }

    mutating func mapping(map: Map) {
        
        color <- map["color"]
        shadowColor <- map["shadowColor"]
        fontSize <- map["fontSize"]
    }
}

