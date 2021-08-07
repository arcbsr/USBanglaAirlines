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
    var error: Error?
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


class Error : Mappable {
    var code : String?
    var message : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        code <- map["Code"]
        message <- map["Message"]
     
    }
    
}

class Code : Mappable {
    var code : String?
    var label : String?
    var valueCodeProperties : [ValueCodeProperties]?
    //    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        code <- map["Code"]
        label <- map["Label"]
        valueCodeProperties <- map["ValueCodeProperties"]
        //        extensions <- map["Extensions"]
    }
    
}


class ValueCodeProperties : Mappable {
    var name : String?
    //    var booleanValue : String?
    //    var numberValue : Double?
    //    var dateTimeValue : String?
    var stringValue : String?
    //    var extensions : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        name <- map["Name"]
        //        booleanValue <- map["BooleanValue"]
        //        numberValue <- map["NumberValue"]
        //        dateTimeValue <- map["DateTimeValue"]
        stringValue <- map["StringValue"]
        //        extensions <- map["Extensions"]
    }
    
}
