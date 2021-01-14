//
//  CityPairModel.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 14/1/21.
//  Copyright © 2021 usbangla. All rights reserved.
//

import Foundation
import ObjectMapper

class CityPairModel : Mappable {
    var codes : [CityPairCode]?
    var responseInfo : ResponseInfo?
    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        codes <- map["Codes"]
        responseInfo <- map["ResponseInfo"]
        extensions <- map["Extensions"]
    }
    
}

class CityPairCode: Mappable {
    
    var start = ""
    var end = ""
    var code: String?{
        didSet{
            if let str = code{
                let array = str.components(separatedBy: "-")
                start = array.first ?? ""
                end = array.last ?? ""
            }
        }
    }
    var label: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        code <- map["Code"]
        label <- map["Label"]
    }
    
}
