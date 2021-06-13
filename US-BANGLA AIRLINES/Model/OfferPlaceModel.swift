//
//  OfferPlaceModel.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 5/2/21.
//  Copyright © 2021 usbangla. All rights reserved.
//
import Foundation
import ObjectMapper


class OfferPlaceModel : Mappable {
    var item : InitItem?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        item <- map["init"]
    }
    
}


class InitItem : Mappable {
    var last_updated : String?
    var offerplace : [Offerplace]?
    var home : Home?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        last_updated <- map["last_updated"]
        offerplace <- map["offerplace"]
        home <- map["home"]
    }
    
}


class Offerplace : Mappable {
    var originCode : String?
    var destinationCode : String?
    var image : String?
    var link: String?
    var hasDestination: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        originCode <- map["OriginCode"]
        destinationCode <- map["DestinationCode"]
        image <- map["image"]
        link <- map["link"]
        hasDestination <- map["hasDestination"]
    }
    
}


class Home : Mappable {
    var background : String?
    var book_flight : String?
    var flight_status : String?
    var holiday : String?
    var hotline : String?
    var manage_booking : String?
    var sky_star : String?
    var web_check_in : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        background <- map["background"]
        book_flight <- map["book_flight"]
        flight_status <- map["flight_status"]
        holiday <- map["holiday"]
        hotline <- map["hotline"]
        manage_booking <- map["manage_booking"]
        sky_star <- map["sky_star"]
        web_check_in <- map["web_check_in"]
    }
    
}
