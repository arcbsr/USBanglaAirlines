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
    
    enum GivenOption {
        case payment, bookingFlight, skyStar, hotline, manageBooking, holiday, flightSchedule, webCheckIn
    }
    var currentOption: GivenOption = .skyStar
    
    let skyStarUrl = "https://mob-skystarsignup.usbair.com"
    let manageBookingUrl = "https://mob-managebooking.usbair.com"
    let holidayUrl = "https://mob-holiday.usbair.com"
    let hotlineUrl = "https://mob-offices.usbair.com"
    let flightScheduleUrl = "https://mob-flightstatus.usbair.com"
    let webCheckInUrl = "https://mob-webcheckin.usbair.com"
    
    var redirectURL = "https://google.com"
    var courseUid = ""
    var verifyPurchase: ((_ transactionTag: String )->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = ""
        switch currentOption {
        case .payment:
            print("payment")
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
            //        if let url = URL(string: "https://priyoclass.com"){
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
        
        
        if currentOption == .payment{
            navigationController?.navigationBar.isHidden = false
            navigationItem.title = "Payment"
        }else{
            navigationController?.navigationBar.isHidden = true
        }
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
