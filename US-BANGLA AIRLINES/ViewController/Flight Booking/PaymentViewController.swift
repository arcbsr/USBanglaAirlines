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
    private let storePassowrd = "usbanglaairlinestest001@ssl"
    private let storeId = "usbanglaairlinestest001"
    var totalAmount = 0.0
    var currencyCode = "BDT"
    var transactionId = ""
    var name = ""
    var email = ""
    var address = ""
    var city = ""
    var postCode = ""
    var country = ""
    var phoneNumber = ""
    var pnr = ""
    var productName = "US-Bangla Airline" //"US-Bangla Air Ticket"
    var productCategory = "airline-ticket"
    var productProfile = "US-Bangla Airline"
    var hoursTillDeparture = ""
    var flightType = "domestic"
    var journyFromTo = "" // Dhk-Syl
    var thirdPartyBooking = "N/A"
    var isLocalFlight = true
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
        
        if totalAmount <= 0.0{
            showAlert(title: "Warning! Amount must be greater than zero", message: nil)
            return
        }
        
        sslCommerz = SSLCommerz(integrationInformation: .init(storeID: storeId, storePassword: storePassowrd, totalAmount: totalAmount, currency: currencyCode, transactionId: transactionId, productCategory: productCategory), emiInformation: nil, customerInformation: .init(customerName: name, customerEmail: email, customerAddressOne: address, customerCity: city, customerPostCode: postCode, customerCountry: country, customerPhone: phoneNumber), shipmentInformation: nil, productInformation: .init(productName: productName, productCategory: productCategory, productProfile: ProductProfile(productProfile: productProfile, hoursTillDeparture: hoursTillDeparture, flightType: flightType, pnr: pnr, journeyFromTo: journyFromTo, thirdPartyBooking: thirdPartyBooking)), additionalInformation: nil)
        
        //        sslCommerz = SSLCommerz(integrationInformation: IntegrationInformation.init(storeID: storeId, storePassword: storePassowrd, totalAmount: 1000.00, currency: "BDT", transactionId: "123id", productCategory: "product"), emiInformation: nil, customerInformation: nil, shipmentInformation: nil, productInformation: nil, additionalInformation: nil)
        
        //        sslCommerz = SSLCommerz(integrationInformation: IntegrationInformation.init(storeID: "abc", storePassword: "123", totalAmount: 1000.00, currency: "BDT", transactionId: "123id", productCategory: "product"), emiInformation: nil, customerInformation: nil, shipmentInformation: nil, productInformation: nil, additionalInformation: nil)
        
        
        //        sslCommerz = SSLCommerz(integrationInformation: IntegrationInformation.init(storeID: "abc", storePassword: "123", totalAmount: 10.00, currency: "BDT", transactionId: "123id", productCategory: "product"), emiInformation: nil, customerInformation: CustomerInformation.init(customerName: "john", customerEmail: "ssl@ssl.com", customerAddressOne: "address1", customerCity: "city", customerPostCode: "123", customerCountry: "Bangaldesh", customerPhone: "12434"), shipmentInformation: nil, productInformation: ProductInformation.init(productName: "product", productCategory: "category", productProfile: ProductProfile(productProfile: "Airline Ticket", hoursTillDeparture: "3", flightType: "", pnr: pnr, journeyFromTo: "34", thirdPartyBooking: "34")),  additionalInformation: nil)
        
        //        sslCommerz = SSLCommerz(integrationInformation: IntegrationInformation.init(storeID: storeId, storePassword: storePassowrd, totalAmount: 10.00, currency: "BDT", transactionId: "123id", productCategory: "product"), emiInformation: nil, customerInformation: CustomerInformation.init(customerName: "john", customerEmail: "ssl@ssl.com", customerAddressOne: "address1", customerCity: "city", customerPostCode: "123", customerCountry: "Bangaldesh", customerPhone: "12434"), shipmentInformation: nil, productInformation: ProductInformation.init(productName: "product", productCategory: "category", productProfile: ProductProfile(productProfile: "Airline Ticket", hoursTillDeparture: "3", flightType: "", pnr: pnr, journeyFromTo: "34", thirdPartyBooking: "34")),  additionalInformation: nil)
        
        //        sslCommerz = SSLCommerz.init(integrationInformation: .init(storeID: storeId, storePassword: storePassowrd, totalAmount: 1000.0, currency: "BDT", transactionId: "2343", productCategory: "asd"), emiInformation: nil, customerInformation: .init(customerName: "doe", customerEmail: "ss@ss.com", customerAddressOne: "one", customerCity: "two", customerPostCode: "111", customerCountry: "BD", customerPhone: "00000"), shipmentInformation: nil, productInformation: nil, additionalInformation: nil)
        
        
        sslCommerz?.delegate = self
        sslCommerz?.start(in: self, shouldRunInTestMode: GlobalItems.isTestBuild)
        //        sslCommerz?.start(in: self, shouldRunInTestMode: true)
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
            validatePayment(t_id: transactionData?.val_id ?? "")
        }
    }
}

// MARK: API CALL
extension PaymentViewController{
    
    func validatePayment(t_id: String) {
        
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
            "t_id": t_id, // "ssl-comrx-val-id",
            "pnr": pnr, // "pnr received on booking creation",
            "amount": totalAmount,
            "currency": currencyCode,
            "PassengerName": leadPassengerLastName //"lead-passenger-last-name"
        ]
        
        var urlStr = "https://usbair.com/app2/bs_mobiapp_payment_validator/create_ticket_stage.php"
        if GlobalItems.isTestBuild == false{
            urlStr = "https://usbair.com/app2/bs_mobiapp_payment_validator/create_ticket.php"
        }
        guard let url = URL(string: urlStr) else{
            return
        }
        
        print("validate payment url: \(url) params \(params)")
        
        SVProgressHUD.show()
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<PaymentValidatorModel>) in
            print("=== response = \(response)")
            SVProgressHUD.dismiss()
            
            let status = response.result.value?.status ?? ""
            if status == "Success"{
                self.showAlert(title: "", message: nil) { _ in
                    
                }
            }else{
                self.showAlert(title: "", message: nil) { _ in
                    
                }
            }
            
            //            guard let statusCode = response.response?.statusCode else{
            //
            //                return
            //            }
            //            print("statusCode = \(statusCode)")
            //
            //            if statusCode >= 400 && statusCode < 500{
            //                self.showAlert(title: <#T##String?#>, message: <#T##String?#>)
            //            }else if statusCode >= 500{
            //                self.showAlert(title: "Something went wrong!", message: nil)
            //            }
            //
            //            switch response.result {
            //            case .success:
            //                print("\(String(describing: response.result.value))")
            //
            //            case .failure(let error):
            //                print("error = \(error)")
            //            }
            
        })
    }
}
