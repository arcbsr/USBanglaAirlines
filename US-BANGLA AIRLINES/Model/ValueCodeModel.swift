//
//  ValueCodeModel.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 14/1/21.
//  Copyright © 2021 usbangla. All rights reserved.
//


import Foundation
import ObjectMapper


class ValueCodeModel: Mappable {
    
    var codes: [Code]?
    var extensions: String?
    var responseInfo: ResponseInfo?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        codes <- map["Codes"]
        extensions <- map["Extensions"]
        responseInfo <- map["ResponseInfo"]
    }
    
}


class ResponseInfo: Mappable {
    
    var echoToken: String?
    var error: String?
    var extensions: String?
    var processingMs: Int?
    var warnings: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        echoToken <- map["EchoToken"]
        error <- map["Error"]
        extensions <- map["Extensions"]
        processingMs <- map["ProcessingMs"]
        warnings <- map["Warnings"]
    }
    
}

class Code: Mappable {
    
    var code: String?
    var label: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        code <- map["Code"]
        label <- map["Label"]
    }
    
}
