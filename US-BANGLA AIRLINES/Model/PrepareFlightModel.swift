//
//  PrepareFlightModel.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 26/6/21.
//  Copyright © 2021 usbangla. All rights reserved.
//

import Foundation
import ObjectMapper

class PrepareFlight : Mappable {
    //    var segments : [Segments]?
    //    var passengers : [Passengers]?
    //    var specialServices : [SpecialServices]?
    var fareInfo : FareInfo?
    //    var optionalSpecialServices : [OptionalSpecialServices]?
    //    var seatMaps : [String]?
    //    var responseInfo : ResponseInfo?
    //    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        //        segments <- map["Segments"]
        //        passengers <- map["Passengers"]
        //        specialServices <- map["SpecialServices"]
        fareInfo <- map["FareInfo"]
        //        optionalSpecialServices <- map["OptionalSpecialServices"]
        //        seatMaps <- map["SeatMaps"]
        //        responseInfo <- map["ResponseInfo"]
        //        extensions <- map["Extensions"]
    }
    
}

//class FareInfo : Mappable {
////    var eMDTicketFareOptions : [EMDTicketFareOptions]?
////    var eMDTicketFares : [String]?
////    var saleCurrencyAmountTotal : SaleCurrencyAmountTotal?
////    var itineraries : [Itineraries]?
//    var fareRules : [FareRules]?
////    var saleCurrencyCode : String?
////    var eTTicketFares : [ETTicketFares]?
////    var extensions : String?
//
//    init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
////        eMDTicketFareOptions <- map["EMDTicketFareOptions"]
////        eMDTicketFares <- map["EMDTicketFares"]
////        saleCurrencyAmountTotal <- map["SaleCurrencyAmountTotal"]
////        itineraries <- map["Itineraries"]
//        fareRules <- map["FareRules"]
////        saleCurrencyCode <- map["SaleCurrencyCode"]
////        eTTicketFares <- map["ETTicketFares"]
////        extensions <- map["Extensions"]
//    }
//
//}

class FareRule : Mappable {
    var ref : String?
    var voluntaryChangeCode : String?
    var voluntaryRefundCode : String?
    //    var details : Details?
    var fareConditionText : FareConditionText?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        ref <- map["Ref"]
        voluntaryChangeCode <- map["VoluntaryChangeCode"]
        voluntaryRefundCode <- map["VoluntaryRefundCode"]
        //        details <- map["Details"]
        fareConditionText <- map["FareConditionText"]
        extensions <- map["Extensions"]
    }
    
}


class FareConditionText : Mappable {
    var text : String?
    var value : String?
    var children : [Children]?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        text <- map["Text"]
        value <- map["Value"]
        children <- map["Children"]
        extensions <- map["Extensions"]
    }
    
}


class Children : Mappable {
    var text : String?
    var value : String?
    var children : [String]?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        text <- map["Text"]
        value <- map["Value"]
        children <- map["Children"]
        extensions <- map["Extensions"]
    }
    
}
