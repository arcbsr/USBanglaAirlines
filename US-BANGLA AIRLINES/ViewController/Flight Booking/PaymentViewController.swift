//
//  PaymentViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 25/2/21.
//  Copyright © 2021 usbangla. All rights reserved.
//

import UIKit
import SSLCommerzSDK

class PaymentViewController: UIViewController {
    var sslCommerz: SSLCommerz?
    private let storeId = "usbanglaairlinestest001"
    private let storePassowrd = "usbanglaairlinestest001@ssl"
    var totalAmount = 0.0
    var currencyCode = "BDT"
    var transactionId = ""
    var productCategory = "Airline Ticket"
    var name = ""
    var email = ""
    var address = "not available"
    var city = "not available"
    var postCode = "not available"
    var country = ""
    var phoneNumber = ""
    var pnr = ""
    var productName = "US-Bangla Air Ticket"
    var productProfile = ""
    var hoursTillDeparture = ""
    var flightType = "domestic"
    var journyFromTo = "from"
    var thirdPartyBooking = ""
    var isLocalFlight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Payment"
        
        if isLocalFlight{
            flightType = "domestic"
        }else{
            flightType = "global"
        }
        transactionId = UUID().uuidString
        initializePayment()
    }
    
    func initializePayment(){
        sslCommerz = SSLCommerz(integrationInformation: .init(storeID: storeId, storePassword: storePassowrd, totalAmount: totalAmount, currency: currencyCode, transactionId: transactionId, productCategory: productCategory), emiInformation: nil, customerInformation: .init(customerName: name, customerEmail: email, customerAddressOne: address, customerCity: city, customerPostCode: postCode, customerCountry: country, customerPhone: phoneNumber), shipmentInformation: nil, productInformation: .init(productName: productName, productCategory: productCategory, productProfile: ProductProfile(productProfile: productProfile, hoursTillDeparture: hoursTillDeparture, flightType: flightType, pnr: pnr, journeyFromTo: journyFromTo, thirdPartyBooking: thirdPartyBooking)), additionalInformation: nil)
        
        sslCommerz?.delegate = self
        sslCommerz?.start(in: self, shouldRunInTestMode: true)
        //        sslCommerz?.start(in: self, shouldRunInTestMode: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
}


extension PaymentViewController: SSLCommerzDelegate{
    func transactionCompleted(withTransactionData transactionData: TransactionDetails?) {
        let status = transactionData?.status ?? ""
        if status == "FAILED"{
            self.showAlert(title: "Payment failed!", message: nil){ _ in
                self.navigationController?.popViewController()
            }
        }else if status == "VALID" || status == "VALIDATED"{
            self.showAlert(title: "Payment successful!", message: nil){ _ in
                self.navigationController?.popViewController()
            }
        }
    }
}
