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
    var offerplace : [Offerplace]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        offerplace <- map["offerplace"]
    }
    
}

class Offerplace : Mappable {
    var originCode : String?
    var destinationCode : String?
    var image : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        originCode <- map["OriginCode"]
        destinationCode <- map["DestinationCode"]
        image <- map["image"]
    }
    
}
