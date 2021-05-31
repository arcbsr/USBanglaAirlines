//
//  PaymentViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 25/2/21.
//  Copyright © 2021 usbangla. All rights reserved.
//

import UIKit
import SSLCommerzSDK
import Alamofire
import SVProgressHUD
import AlamofireObjectMapper


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
    var leadPassengerLastName = ""
    
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
//            self.showAlert(title: "Payment successful!", message: nil){ _ in
                //                self.navigationController?.popViewController()
//            }
            validatePayment()
        }
    }
}

// MARK: API CALL
extension PaymentViewController{
    
    func validatePayment() {
        
        //            let headers: HTTPHeaders = [
        //                "Authorization": "token \(UserInfo.token)"
        //            ]
        
        //        let requestInfo: Parameters = [
        //            //            "AuthenticationKey": "_JEAAAAL436mpPsYP3m2lwfwBiLPdzcUQEHyecX5mtHR1RMK0DTHTEiyA_EYVUazFkn3rIGIGu6wxA8qa1gYyfs1uOib4E_U",
        //                        "AuthenticationKey": "_JEAAAABWU_EYtV0PDQ5AefVBXqTISe7_EqErTgeZryEzUyElkoBqCSdJh8UQdKZLhbSW62OVwi7Ix58ZnGrS9CBDxSnz7g_U",
        //                        "CultureName": "en-GB"
        //        ]
        
//        let requestInfo: Parameters = [
//            "AuthenticationKey": GlobalItems.getAuthKey(),
//            "CultureName": "en-GB"
//        ]
        
        let params: Parameters = [
            "t_id": "ssl-comrx-val-id",
            "pnr": pnr, // "pnr received on booking creation",
            "amount": "3400.00", // must take from sslcommerz transation model received on success callback method
            "currency": "BDT",  // Take also from sslcommerz transation model
            "PassengerName": leadPassengerLastName //"lead-passenger-last-name"
        ]
        
        var urlStr = "https://usbair.com/app2/bs_mobiapp_payment_validator/create_ticket_stage.php"
        if GlobalItems.isTestBuild == false{
            urlStr = "https://usbair.com/app2/bs_mobiapp_payment_validator/create_ticket.php"
        }
        guard let url = URL(string: urlStr) else{
            return
        }
        
        print("url: \(url) params \(params)")
        
        SVProgressHUD.show()
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<PaymentValidatorModel>) in
            print("=== response = \(response)")
            SVProgressHUD.dismiss()
            
            guard let statusCode = response.response?.statusCode else{
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                print("\(String(describing: response.result.value))")
            case .failure(let error):
                print("error = \(error)")
            }
        })
    }
}
