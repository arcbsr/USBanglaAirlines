//
//  FlightSearchModel.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 15/1/21.
//  Copyright © 2021 usbangla. All rights reserved.
//

import Foundation
import ObjectMapper

class FlightSearchModel: Mappable {
    
    var extensions: String?
    var fareInfo: FareInfo?
    var offer: Offer?
    var passengers: [Passenger]?
    var responseInfo: ResponseInfo?
    var segments: [Segment]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        extensions <- map["Extensions"]
        fareInfo <- map["FareInfo"]
        offer <- map["Offer"]
        passengers <- map["Passengers"]
        responseInfo <- map["ResponseInfo"]
        segments <- map["Segments"]
    }
    
}

class Segment: Mappable {
    
    var infoDictionary = [String: FlightInfo]()
    var airlineDesignator: String?
    var bookingClasses: [BookingClass]?
    var destinationCode: String?
    var extensions: String?
    var flightInfo: FlightInfo?
    //    {
    //        didSet{
    //            print("ref = \(String(describing: ref))")
    //            print("info.equipmentText = \(String(describing: flightInfo?.equipmentText))")
    //            print("")
    //        }
    //    }
    var originCode: String?
    var ref: String?{
        didSet{
            if let key = ref, let val = flightInfo{
                GlobalItems.segmentRefInfoDictinary[key] = val
            }
            //            print("ref = \(String(describing: ref))")
            //            print("info.equipmentText = \(String(describing: flightInfo?.equipmentText))")
            //            print("dictionary = \(GlobalItems.segmentRefInfoDictinary)")
            //            print("")
        }
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        airlineDesignator <- map["AirlineDesignator"]
        bookingClasses <- map["BookingClasses"]
        destinationCode <- map["DestinationCode"]
        extensions <- map["Extensions"]
        flightInfo <- map["FlightInfo"]
        originCode <- map["OriginCode"]
        ref <- map["Ref"]
    }
    
}


class FlightInfo: Mappable {
    
    var segmentRef = ""
    var itineraryRef = ""
    var saleCurrencyAmount: SaleCurrencyAmount?
    var originCode = ""
    var destinationCode = ""
    var arrivalDate: String?
    var codeShareAgreementTypeCode: String?
    var departureDate: String?
    var destinationAirportTerminal: String?
    var durationMinutes: Int?
    var equipmentCode: String?
    var equipmentText: String?
    var extensions: String?
    var flightNumber: String?
    var operatingAirlineDesignator: String?
    var operatingFlightNumber: String?
    var originAirportTerminal: String?
    var remarks: String?
    var stops: [String]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        arrivalDate <- map["ArrivalDate"]
        codeShareAgreementTypeCode <- map["CodeShareAgreementTypeCode"]
        departureDate <- map["DepartureDate"]
        destinationAirportTerminal <- map["DestinationAirportTerminal"]
        durationMinutes <- map["DurationMinutes"]
        equipmentCode <- map["EquipmentCode"]
        equipmentText <- map["EquipmentText"]
        extensions <- map["Extensions"]
        flightNumber <- map["FlightNumber"]
        operatingAirlineDesignator <- map["OperatingAirlineDesignator"]
        operatingFlightNumber <- map["OperatingFlightNumber"]
        originAirportTerminal <- map["OriginAirportTerminal"]
        remarks <- map["Remarks"]
        stops <- map["Stops"]
    }
    
}


class BookingClass: Mappable {
    
    var cabinClassCode: String?
    var code: String?
    var extensions: String?
    var operatingCode: String?
    var quantity: Int?
    var statusCode: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        cabinClassCode <- map["CabinClassCode"]
        code <- map["Code"]
        extensions <- map["Extensions"]
        operatingCode <- map["OperatingCode"]
        quantity <- map["Quantity"]
        statusCode <- map["StatusCode"]
    }
    
}


class Passenger: Mappable {
    
    var extensions: String?
    var nameElement: String?
    var passengerQuantity: Int?
    var passengerTypeCode: String?
    var ref: String?
    var refClient: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        extensions <- map["Extensions"]
        nameElement <- map["NameElement"]
        passengerQuantity <- map["PassengerQuantity"]
        passengerTypeCode <- map["PassengerTypeCode"]
        ref <- map["Ref"]
        refClient <- map["RefClient"]
    }
    
}


class Offer: Mappable {
    
    var expirationDateGMT: String?
    var extensions: String?
    var ref: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        expirationDateGMT <- map["ExpirationDateGMT"]
        extensions <- map["Extensions"]
        ref <- map["Ref"]
    }
    
}


class FareInfo: Mappable {
    
    //    var eTTicketFares: [ETTicketFare]?
    var extensions: String?
    //    var fareRules: [FareRule]?
    var itineraries: [Itinerary]?
    var saleCurrencyCode: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        //        eTTicketFares <- map["ETTicketFares"]
        extensions <- map["Extensions"]
        //        fareRules <- map["FareRules"]
        itineraries <- map["Itineraries"]
        saleCurrencyCode <- map["SaleCurrencyCode"]
    }
    
}


class Itinerary: Mappable {
    
    var airOriginDestinations: [AirOriginDestination]?
    var extensions: String?
    var ref: String?
    var saleCurrencyAmount: SaleCurrencyAmount?
    var validatingAirlineDesignator: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        airOriginDestinations <- map["AirOriginDestinations"]
        extensions <- map["Extensions"]
        ref <- map["Ref"]
        saleCurrencyAmount <- map["SaleCurrencyAmount"]
        validatingAirlineDesignator <- map["ValidatingAirlineDesignator"]
    }
    
}


class SaleCurrencyAmount: Mappable {
    
    var isExpand = false
    var forwardSegmentRef = ""
    var backwardSegmentRef = ""
    var itineraryRef = ""
    var forwardflightInfo: FlightInfo?
    var backwardflightInfo: FlightInfo?
//    var originCode = ""
//    var destinationCode = ""
    var isBusiness = false
    var baseAmount: Int?
    var discountAmount: Int?
    var extensions: String?
    var milesAmount: Int?
    var taxAmount: Int?
    var totalAmount: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        baseAmount <- map["BaseAmount"]
        discountAmount <- map["DiscountAmount"]
        extensions <- map["Extensions"]
        milesAmount <- map["MilesAmount"]
        taxAmount <- map["TaxAmount"]
        totalAmount <- map["TotalAmount"]
    }
    
}


class AirOriginDestination: Mappable {
    
    var airCoupons: [AirCoupon]?
    var extensions: String?
    var originDestinationOrder: Int?
    var refFareRule: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        airCoupons <- map["AirCoupons"]
        extensions <- map["Extensions"]
        originDestinationOrder <- map["OriginDestinationOrder"]
        refFareRule <- map["RefFareRule"]
    }
    
}


class AirCoupon: Mappable {
    
    var isBusiness = false
    var businessType = "" // ECONOMY/BUSINESS
    var bookingClassCode: String?{
        didSet{
            if let code = bookingClassCode{
                if GlobalItems.businessClassCodes.contains(code){
                    isBusiness = true
                    businessType = "BUSINESS"
                    print("\(isBusiness)")
                    print("")
                }else{
                    businessType = "ECONOMY"
                }
            }
        }
    }
    var couponOrder: Int?
    var extensions: String?
    var refSegment: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        bookingClassCode <- map["BookingClassCode"]
        couponOrder <- map["CouponOrder"]
        extensions <- map["Extensions"]
        refSegment <- map["RefSegment"]
    }
    
}


class FareRule: Mappable {
    
    var details: String?
    var extensions: String?
    var fareConditionText: String?
    var ref: String?
    var voluntaryChangeCode: String?
    var voluntaryRefundCode: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        details <- map["Details"]
        extensions <- map["Extensions"]
        fareConditionText <- map["FareConditionText"]
        ref <- map["Ref"]
        voluntaryChangeCode <- map["VoluntaryChangeCode"]
        voluntaryRefundCode <- map["VoluntaryRefundCode"]
    }
    
}


class ETTicketFare: Mappable {
    
    var amountDetails: String?
    var createdDateGMT: String?
    var extensions: String?
    var originDestinationFares: [OriginDestinationFare]?
    var ref: String?
    var refItinerary: String?
    var refPassenger: String?
    var saleCurrencyAmount: SaleCurrencyAmount?
    var taxes: [Tax]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        amountDetails <- map["AmountDetails"]
        createdDateGMT <- map["CreatedDateGMT"]
        extensions <- map["Extensions"]
        originDestinationFares <- map["OriginDestinationFares"]
        ref <- map["Ref"]
        refItinerary <- map["RefItinerary"]
        refPassenger <- map["RefPassenger"]
        saleCurrencyAmount <- map["SaleCurrencyAmount"]
        taxes <- map["Taxes"]
    }
    
}


class Tax: Mappable {
    
    var code: String?
    var countryCode: String?
    var extensions: String?
    var saleCurrencyAmount: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        code <- map["Code"]
        countryCode <- map["CountryCode"]
        extensions <- map["Extensions"]
        saleCurrencyAmount <- map["SaleCurrencyAmount"]
    }
    
}

class OriginDestinationFare: Mappable {
    
    var couponFares: [CouponFare]?
    var extensions: String?
    var originDestinationOrder: Int?
    var refWebClass: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        couponFares <- map["CouponFares"]
        extensions <- map["Extensions"]
        originDestinationOrder <- map["OriginDestinationOrder"]
        refWebClass <- map["RefWebClass"]
    }
    
}


class CouponFare: Mappable {
    
    var amountDetails: String?
    var bagAllowances: [BagAllowance]?
    var bookingClassCode: String?
    var couponOrder: Int?
    var extensions: String?
    var fareBasisCode: String?
    var refSegment: String?
    var saleCurrencyAmount: SaleCurrencyAmount?
    var taxes: [String]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        amountDetails <- map["AmountDetails"]
        bagAllowances <- map["BagAllowances"]
        bookingClassCode <- map["BookingClassCode"]
        couponOrder <- map["CouponOrder"]
        extensions <- map["Extensions"]
        fareBasisCode <- map["FareBasisCode"]
        refSegment <- map["RefSegment"]
        saleCurrencyAmount <- map["SaleCurrencyAmount"]
        taxes <- map["Taxes"]
    }
    
}


class BagAllowance: Mappable {
    
    var carryOn: Bool?
    var extensions: String?
    var quantity: String?
    var weight: Int?
    var weightMeasureQualifier: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        carryOn <- map["CarryOn"]
        extensions <- map["Extensions"]
        quantity <- map["Quantity"]
        weight <- map["Weight"]
        weightMeasureQualifier <- map["WeightMeasureQualifier"]
    }
    
}
