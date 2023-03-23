

import UIKit
import ObjectMapper

struct UserDataModel : Mappable {
    var success : Bool?
    var response : UserData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["success"]
        response <- map["response"]
    }
}

struct UserData : Mappable {
    var mobile : String?
    var provider : String?
    var firstName : String?
    var roles : String?
    var preferences : Preferences?
    var city : String?
    var email : String?
    var emailVerified : Bool?
    var lastName : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        mobile <- map["mobile"]
        provider <- map["provider"]
        firstName <- map["firstName"]
        roles <- map["roles"]
        preferences <- map["preferences"]
        city <- map["city"]
        email <- map["email"]
        emailVerified <- map["emailVerified"]
        lastName <- map["lastName"]
    }
}

struct Preferences : Mappable {
    var mapData : MapData?

    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {

        mapData <- map["map"]
    }
}

struct MapData : Mappable {
    var country : String?
    var notification : Bool?
    var notification_app : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        country <- map["country"]
        notification <- map["notification"]
        notification_app <- map["notification_app"]
    }

}



