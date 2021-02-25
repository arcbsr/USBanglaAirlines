//
//  CustomWebViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 25/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class CustomWebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    let skyStarLoginUrl = "https://fo-asia.ttinteractive.com/Zenith/FrontOffice/usbangla/en-GB/Customer/Login"
    let skyStarSignupUrl = "http://fo-asia.ttinteractive.com/Zenith/FrontOffice/usbangla/en-GB/Customer/CreateFFP"
    let manageBookingUrl = "http://fo-asia.ttinteractive.com/Zenith/FrontOffice/usbangla/Home/FindBooking"
    let holidayUrl = "https://usbair.com/app/tourpackage.php"
    let hotlineUrl = "https://usbair.com/app/hotline.php"
    let flightScheduleUrl = "https://usbair.com/app/flightschedule.php"
    let webCheckInUrl = "https://fo-asia.ttinteractive.com/Zenith/FrontOffice/USbangla/en-GB/Home/FindBooking?findbookingmode=WebCheckin"
    let liveFlightSearch = "https://fo-asia.ttinteractive.com/Zenith/FrontOffice/USBangla/en-GB/FlightStatusSearch/FlightStatus"
    let myBooking = "http://fo-asia.ttinteractive.com/Zenith/FrontOffice/usbangla/Home/FindBooking"
    let salesOffice = "https://usbair.com/app/hotline.php"
    
    var redirectURL = "https://google.com"
    var courseUid = "https://usbair.com/app/hotline.php"
    var verifyPurchase: ((_ transactionTag: String )->())?
    var currentOption: GivenOption = .skyStarSignUp
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = ""
        switch currentOption {
        case .skyStarSignUp:
            urlString = skyStarSignupUrl
            navigationItem.title = "SKY STARS"
        case .skyStarLogin:
            urlString = skyStarLoginUrl
            navigationItem.title = "SKY STARS"
        case .liveFlightSearch:
            urlString = liveFlightSearch
            navigationItem.title = "LIVE FLIGHT SEARCH"
        case .holiday:
            urlString = holidayUrl
            navigationItem.title = "HOLIDAYS"
        case .hotline:
            urlString = hotlineUrl
            navigationItem.title = "CONTACT US"
        case .manageBooking:
            urlString = manageBookingUrl
            navigationItem.title = "MANAGE BOOKING"
        case .flightSchedule:
            urlString = flightScheduleUrl
            navigationItem.title = "FLIGHT SCHEDULES"
        case .webCheckIn:
            urlString = webCheckInUrl
            navigationItem.title = "WEB CHECK-IN"
        case .myBooking:
            urlString = myBooking
            navigationItem.title = "MY BOOKING"
        case .salesOffice:
            urlString = salesOffice
            navigationItem.title = "SALES OFFICE"
        default:
            break
        }
        
        if let url = URL(string: urlString){
            //                    if let url = URL(string: "https://usbair.com/get_help/contact_us"){
            print("====urlString = \(urlString)")
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
            SVProgressHUD.show()
            webView.load(urlRequest)
        }
        
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        if currentOption == .payment{
        //            navigationController?.navigationBar.isHidden = false
        //            navigationItem.title = "Payment"
        //        }else{
        //            navigationController?.navigationBar.isHidden = false
        //            navigationItem.title = "US-Bangla Airlines"
        //            navigationController?.navigationBar.isHidden = true
        //        }
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}

extension CustomWebViewController: WKNavigationDelegate{
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            if let url = webView.url{
                print("### URL:", url)
                let urlString = url.absoluteString
                if urlString.contains("google.com"){
                    navigationController?.popViewController(animated: true)
                    let transactionTag = self.getQueryStringParameter(url: urlString, param: "transaction_tag") ?? ""
                    verifyPurchase?(transactionTag)
                    return
                }
            }
            if SVProgressHUD.isVisible(){
                SVProgressHUD.dismiss()
            }
        }
        
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            // When page load finishes. Should work on each page reload.
            print("### EP:", webView.estimatedProgress)
            if (self.webView.estimatedProgress == 1) {
                print("### EP:", webView.estimatedProgress)
                if SVProgressHUD.isVisible(){
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
}
