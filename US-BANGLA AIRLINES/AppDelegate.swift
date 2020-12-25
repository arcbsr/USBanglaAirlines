//
//  AppDelegate.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 25/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Dismiss"
            IQKeyboardManager.shared.shouldResignOnTouchOutside = true
            
            UINavigationBar.appearance().barStyle = UIBarStyle.black
        
        return true
    }



}

