//
//  CustomWebViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 25/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit
import WebKit



class CustomWebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    enum GivenOption {
        case bookingFlight, skyStar, hotline, manageBooking, holiday, flightSchedule, webCheckIn
    }
    var currentOption: GivenOption = .skyStar
    
    let skyStarUrl = "https://mob-skystarsignup.usbair.com"
    let manageBookingUrl = "https://mob-managebooking.usbair.com"
    let holidayUrl = "https://mob-holiday.usbair.com"
    let hotlineUrl = "https://mob-offices.usbair.com"
    let flightScheduleUrl = "https://mob-flightstatus.usbair.com"
    let webCheckInUrl = "https://mob-webcheckin.usbair.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = ""
        switch currentOption {
        case .skyStar:
            urlString = skyStarUrl
        case .holiday:
            urlString = holidayUrl
        case .hotline:
            urlString = hotlineUrl
        case .manageBooking:
            urlString = manageBookingUrl
        case .flightSchedule:
            urlString = flightScheduleUrl
        case .webCheckIn:
            urlString = webCheckInUrl
        default:
            break
        }
        
        if let url = URL(string: urlString){
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    
}
