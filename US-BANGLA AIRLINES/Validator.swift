//
//  Validator.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 25/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit

class Validator: NSObject {
    /// Check input UserName
    ///
    /// - Parameter username: username
    /// - Returns: true or false
    static func isValidUsername(username:String) -> Bool {
        if username.isEmpty || username.elementsEqual(""){
            return false
        }
        
        return true
    }
    
    
    /// Ceck input Password
    ///
    /// - Parameter password: password
    /// - Returns: true or false
    static func isValidPassword(password:String) -> Bool {
        if password.isEmpty || password.elementsEqual(""){
            return false
        }
        
        return true
    }
    
    /// Ceck input confirm Password
    ///
    /// - Parameter password: password
    /// - Returns: true or false
    static func isValidConfirmPassword(password:String, confirmPassword:String) -> Bool {
        if password != confirmPassword {
            return false
        }
        
        return true
    }
    
    
    /// ceck input Email valid formate
    ///
    /// - Parameter email: email
    /// - Returns: true or false
    static func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let formatter = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return formatter.evaluate(with: email)
    }
    
    /// Check input string type
    ///
    /// - Parameter value: String
    /// - Returns: true or false
    static func isValidString(value:String) -> Bool {
        if value.isEmpty || value.elementsEqual(""){
            return false
        }
        
        return true
    }
    
    /// Ceck input Phone Number
    ///
    /// - Parameter phone: phone
    /// - Returns: true or false
    static func isValidPhone(phone:String) -> Bool {
        if phone.isEmpty || phone.elementsEqual("") || phone.count<11 {
            return false
        }
        
        return true
    }

}

