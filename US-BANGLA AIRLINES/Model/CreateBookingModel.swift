//
//  CreateBookingModel.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 23/2/21.
//  Copyright © 2021 usbangla. All rights reserved.
//


import Foundation
import ObjectMapper

class CreateBookingModel : Mappable {
    var invalidData : String?
    var booking : Booking?
    var responseInfo : ResponseInfo?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        invalidData <- map["InvalidData"]
        booking <- map["Booking"]
        responseInfo <- map["ResponseInfo"]
        extensions <- map["Extensions"]
    }
    
}


class Booking : Mappable {
    var fareInfo : FareInfo?
    var ticketInfo : TicketInfo?
    var miscInfo : MiscInfo?
    var pnrInformation : PnrInformation?
    var segments : [Segment]?
    var passengers : [Passenger]?
    var specialServices : [SpecialService]?
    var seatMaps : [String]?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        fareInfo <- map["FareInfo"]
        ticketInfo <- map["TicketInfo"]
        miscInfo <- map["MiscInfo"]
        pnrInformation <- map["PnrInformation"]
        segments <- map["Segments"]
        passengers <- map["Passengers"]
        specialServices <- map["SpecialServices"]
        seatMaps <- map["SeatMaps"]
        extensions <- map["Extensions"]
    }
    
}


class PnrInformation : Mappable {
    var pnrCode : String?
    var pnrStatusCode : String?
    var timeLimit : String?
    var missingTravelerRecordLocator : Bool?
    var refCustomer : String?
    var createdDateGMT : String?
    var modifiedDateGMT : String?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        pnrCode <- map["PnrCode"]
        pnrStatusCode <- map["PnrStatusCode"]
        timeLimit <- map["TimeLimit"]
        missingTravelerRecordLocator <- map["MissingTravelerRecordLocator"]
        refCustomer <- map["RefCustomer"]
        createdDateGMT <- map["CreatedDateGMT"]
        modifiedDateGMT <- map["ModifiedDateGMT"]
        extensions <- map["Extensions"]
    }
    
}


class SpecialService : Mappable {
    var text : String?
    var data : Data?
    var status : String?
    var refPassenger : String?
    var refSegment : String?
    var code : String?
    var technicalType : String?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        text <- map["Text"]
        data <- map["Data"]
        status <- map["Status"]
        refPassenger <- map["RefPassenger"]
        refSegment <- map["RefSegment"]
        code <- map["Code"]
        technicalType <- map["TechnicalType"]
        extensions <- map["Extensions"]
    }
    
}


class TicketInfo : Mappable {
    var eTTickets : [String]?
    var eMDTickets : [String]?
    var fops : [String]?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        eTTickets <- map["ETTickets"]
        eMDTickets <- map["EMDTickets"]
        fops <- map["Fops"]
        extensions <- map["Extensions"]
    }
    
}


class MiscInfo : Mappable {
    var boardingPassList : [String]?
    var isPendingExchange : Bool?
    var pendingRefundRequest : String?
    var exchangeableOriginDestinations : [ExchangeableOriginDestinations]?
    var cancelInfo : CancelInfo?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        boardingPassList <- map["BoardingPassList"]
        isPendingExchange <- map["IsPendingExchange"]
        pendingRefundRequest <- map["PendingRefundRequest"]
        exchangeableOriginDestinations <- map["ExchangeableOriginDestinations"]
        cancelInfo <- map["CancelInfo"]
        extensions <- map["Extensions"]
    }
    
}

class ExchangeableOriginDestinations : Mappable {
    var refItinerary : String?
    var originDestinationOrder : Int?
    var eTTicketFareTargets : [ETTicketFareTargets]?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        refItinerary <- map["RefItinerary"]
        originDestinationOrder <- map["OriginDestinationOrder"]
        eTTicketFareTargets <- map["ETTicketFareTargets"]
        extensions <- map["Extensions"]
    }
    
}

class ETTicketFareTargets : Mappable {
    var refETTicketFare : String?
    var couponOrders : [Int]?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        refETTicketFare <- map["RefETTicketFare"]
        couponOrders <- map["CouponOrders"]
        extensions <- map["Extensions"]
    }
    
}


class CancelInfo : Mappable {
    var canCancel : Bool?
    var canVoid : Bool?
    var canRefund : Bool?
    var canRequestRefund : Bool?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        canCancel <- map["CanCancel"]
        canVoid <- map["CanVoid"]
        canRefund <- map["CanRefund"]
        canRequestRefund <- map["CanRequestRefund"]
    }
    
}
