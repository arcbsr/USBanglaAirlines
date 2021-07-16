//
//  InputPassengerInfoViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 28/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import AlamofireObjectMapper


class InputPassengerInfoViewController: UIViewController {
    @IBOutlet weak var createBookingButton: UIButton!{
        didSet{ //square
            createBookingButton.backgroundColor = CustomColor.secondaryColor
        }
    }
    @IBOutlet weak var termsLinkButton: UIButton!{
        didSet{
            termsLinkButton.setTitleColor(CustomColor.primaryColor, for: .normal)
            let attributedText = NSAttributedString(string: "general terms of sell", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular), .underlineStyle: NSUnderlineStyle.single.rawValue])
            termsLinkButton.setAttributedTitle(attributedText, for: .normal)
        }
    }
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var makePaymentButton: UIButton!{
        didSet{
            makePaymentButton.isHidden = true
        }
    }
    @IBOutlet weak var holdBookingButton: UIButton!{
        didSet{
            holdBookingButton.isHidden = true
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
            let footerView = UIView()
            footerView.frame.size.height = 80 // 40
            footerView.backgroundColor = .clear
            tableView.tableFooterView = footerView
        }
    }
    @IBOutlet weak var notificationImageView: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                notificationImageView.image = UIImage(named: "bell")
            }
            notificationImageView.isUserInteractionEnabled = true
            notificationImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notificationTapped)))
        }
    }
    @IBOutlet weak var menuImageView: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                menuImageView.image = UIImage(named: "open-menu")
            }
            menuImageView.isUserInteractionEnabled = true
            menuImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(menuTapped)))
        }
    }
    @IBOutlet weak var backImageView: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                backImageView.image = UIImage(named: "left-arrow")
            }
            backImageView.isUserInteractionEnabled = true
            backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTapped)))
        }
    }
    @IBOutlet weak var crossImageView: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                crossImageView.image = UIImage(named: "cancel")
            }
            crossImageView.isUserInteractionEnabled = true
            crossImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(crossTapped)))
        }
    }
    
    var visualEffectView: UIVisualEffectView!
    var sideBarView: UIView!
    var sideBarTableView: UITableView!
    var cataTopLbl = UILabel()
    var logoImgView: UIImageView?
    // for iPhone
    var shiftX: CGFloat = -400
    
    var sideMenutitleArray: NSArray = ["BOOK A FLIGHT", "MANAGE BOOKING", "MY BOOKING" ,"WEB CHECK-IN" , "HOLIDAYS", "FLIGHT STATUS", "SKY STAR", "SALES OFFICE", "CONTACT US"]
    var sideMenuImgArray = [UIImage(named: "Flight")!, UIImage(named: "Manage-Booking")!, UIImage(named: "Manage-Booking")!,  UIImage(named: "Manage-Booking")!, UIImage(named: "Holiday_Tree")!, UIImage(named: "clock")!, UIImage(named: "Sky-Star")!, UIImage(named: "Sales-Office")!, UIImage(named: "Contact")!]
    let BOOK_FLIGHT_SECTION = 0
    let MY_BOOKING_SECTION = 1
    let WEB_CHECK_IN_SECTION = 2
    let MANAGE_BOOKING_SECTION = 3
    let HOLIDAYS_SECTION = 4
    let FLIGHT_SCHEDULE_SECTION = 5
    let SKY_STAR_SECTION = 6
    let SALES_OFFICE_SECTION = 7
    let CONTACT_US_SECTION = 8
    var passengers = [Passenger]()
    var computedPassengers = [Passenger]()
    var oneWayflight: FlightInfo?
    var returnFlight: SaleCurrencyAmount?
    var offer: Offer?
    var eTTicketFares = [ETTicketFare]()
    var selectedItiRef = ""
    var fromTime = ""
    var toTime = ""
    var fromCityCode = ""
    var toCityCode = ""
    var fromCity = ""
    var toCity = ""
    var forwardFlightClass = ""
    var backwardFlightClass = ""
    var flightClass = ""
    var selectedCurrency = ""
    var isTermsAndConditionSelected = false
    var isLocalFlight = false
    var monthDictionary = ["JAN": "01", "FEB": "02", "MAR": "03", "APR": "04", "MAY": "05", "JUN": "06", "JUL": "07", "AUG": "08", "SEP": "09", "OCT": "10", "NOV": "11", "DEC": "12"]
    var termsAndCondtionLink = "https://usbair.com/assets/frontend/img/travel_info/USBA_Ticketing_Terms_And_Condition.pdf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            shiftX = -850
            if UIWindow.isLandscape{
                shiftX = -1200
            }else{
                shiftX = -850
            }
        }
        sideBarSetup()
        constructPassengers()
        if GlobalItems.bdAirportCodes.contains(fromCityCode) && GlobalItems.bdAirportCodes.contains(toCityCode){
            isLocalFlight = true
        }else{
            isLocalFlight = false
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.userInterfaceIdiom == .pad{
            shiftX = -850
            if UIWindow.isLandscape{
                shiftX = -850
            }else{
                shiftX = -1200
            }
        }
        hideMenu()
        sideBarSetup(willChangeState: true)
    }
    
    @IBAction func createBookingButtonTapped(_ sender: Any) {
        if isTermsAndConditionSelected == false{
            showAlert(title: "Please accept Terms and Conditions", message: nil)
            return
        }
        view.endEditing(true)
        if validateInput(){
            createBooking()
        }
    }
    
    @IBAction func makePaymentTapped(_ sender: Any) {
        //        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController{
        //            vc.isLocalFlight = isLocalFlight
        //            vc.isLocalFlight = self.isLocalFlight
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
    }
    
    @IBAction func termsAndConditionsButtonTapped(_ sender: Any) {
        isTermsAndConditionSelected = !isTermsAndConditionSelected
        if isTermsAndConditionSelected{
            if #available(iOS 13.0, *) {
                termsAndConditionsButton.setImage(UIImage.init(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                // Fallback on earlier versions
                termsAndConditionsButton.setImage(UIImage(named: "checkbox"), for: .normal)
            }
        }else{
            if #available(iOS 13.0, *) {
                termsAndConditionsButton.setImage(UIImage.init(systemName: "square"), for: .normal)
            } else {
                // Fallback on earlier versions
                termsAndConditionsButton.setImage(UIImage(named: "empty-checkbox"), for: .normal)
            }
        }
    }
    
    @IBAction func TermsLinkButtonTapped(_ sender: Any) {
        toWebView(type: .termsAndCondition)
    }
    
    @IBAction func holdBookingTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func constructPassengers(){
        computedPassengers = [Passenger]()
        //        for passenger in passengers{
        for i in 0 ..< passengers.count{
            // MARK: Uncommenting the following line will cause issue (class type; all adult data will be changed)
            //            let passenger = passengers[i]
            //            let count = passenger.passengerQuantity ?? 0
            
            let count = passengers[i].passengerQuantity ?? 0
            for j in 0 ..< count{
                let passenger = Passenger()
                passenger.eTTicketFare = passengers[i].eTTicketFare
                passenger.extensions = passengers[i].extensions
                passenger.nameElement = passengers[i].nameElement
                passenger.passengerQuantity = passengers[i].passengerQuantity
                passenger.passengerTypeCode = passengers[i].passengerTypeCode
                passenger.ref = passengers[i].ref
                passenger.refClient = passengers[i].refClient
                passenger.index = j + 1
                var refPassenger = ""
                if passenger.passengerTypeCode == "AD"{
                    refPassenger = "Traveler_Type_1_Index_\(j)"
                }else if passenger.passengerTypeCode == "CHD"{
                    refPassenger = "Traveler_Type_2_Index_\(j)"
                }else{
                    refPassenger = "Traveler_Type_3_Index_\(j)"
                }
                passenger.refPassenger = refPassenger
                
                if i == 0 && j == 0{ //MARK: Lead passenger's data save
                    passenger.title = UserDefaults.standard.string(forKey: "title") ?? "MR"
                    passenger.dobDay = UserDefaults.standard.string(forKey: "dobDay") ?? "DATE"
                    passenger.dobMonth = UserDefaults.standard.string(forKey: "dobMonth") ?? "MONTH"
                    passenger.dobYear = UserDefaults.standard.string(forKey: "dobYear") ?? "YEAR"
                    passenger.country = UserDefaults.standard.string(forKey: "country") ?? "Bangladesh"
                    passenger.birthplace = UserDefaults.standard.string(forKey: "birthplace") ?? "Bangladesh"
                    passenger.documentIssuanceCountry = UserDefaults.standard.string(forKey: "documentIssuanceCountry") ?? "Bangladesh"
                    passenger.phoneCode = UserDefaults.standard.string(forKey: "phoneCode") ?? "+880"
                    passenger.phoneNumberWithoutCountryCode = UserDefaults.standard.string(forKey: "phoneNumberWithoutCountryCode") ?? ""
                    passenger.emailAddress = UserDefaults.standard.string(forKey: "emailAddress") ?? ""
                    passenger.ffpNumber = UserDefaults.standard.string(forKey: "ffpNumber") ?? ""
                    passenger.documentNumber = UserDefaults.standard.string(forKey: "documentNumber") ?? ""
                    passenger.documentTypeValue = UserDefaults.standard.string(forKey: "documentTypeValue") ?? "Passport"
                    passenger.documentTypeKey = UserDefaults.standard.string(forKey: "documentTypeKey") ?? "PP"
                    passenger.firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
                    passenger.lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
                }else{
                    passenger.title = "MR"
                    passenger.dobDay = "DATE"
                    passenger.dobMonth = "MONTH"
                    passenger.dobYear = "YEAR"
                    passenger.country = "Bangladesh"
                    passenger.birthplace = "Bangladesh"
                    passenger.documentIssuanceCountry = "Bangladesh"
                    passenger.phoneCode = "+880"
                    passenger.phoneNumberWithoutCountryCode = ""
                    passenger.documentTypeKey = "PP"
                    passenger.documentTypeValue = "Passport"
                    passenger.emailAddress = ""
                    passenger.ffpNumber = ""
                    passenger.documentNumber = ""
                    passenger.firstName = ""
                    passenger.lastName = ""
                }
                computedPassengers.append(passenger)
            }
        }
        tableView.reloadData()
        //        for passenger in computedPassengers{
        //            print(passenger)
        //            print("first name = \(passenger.firstName)")
        //            print("")
        //        }
    }
    
    func validateInput() -> Bool{
        //        for passenger in computedPassengers{
        let passenger = computedPassengers.first ?? Passenger()
        if passenger.firstName.isEmpty{
            showAlert(title: "First Name is Empty.", message: nil, callback: nil)
            return false
        }
        if passenger.lastName.isEmpty{
            showAlert(title: "Last Name is Empty.", message: nil, callback: nil)
            return false
        }
        if passenger.dobDay == "DATE"{
            showAlert(title: "DOB date not selected.", message: nil, callback: nil)
            return false
        }
        if passenger.dobMonth == "MONTH"{
            showAlert(title: "DOB month not selected.", message: nil, callback: nil)
            return false
        }
        if passenger.dobYear == "YEAR"{
            showAlert(title: "DOB year not selected.", message: nil, callback: nil)
            return false
        }
        if isLocalFlight == false{
            if passenger.documentTypeValue.isEmpty{
                showAlert(title: "Document type not selected", message: nil, callback: nil)
                return false
            }
            if passenger.documentNumber.isEmpty{
                showAlert(title: "Document number not added", message: nil, callback: nil)
                return false
            }
            if passenger.documentIssuanceCountry.isEmpty{
                showAlert(title: "Document issuance country not selected", message: nil, callback: nil)
                return false
            }
            if passenger.expireDay == "DATE"{
                showAlert(title: "Expire date not selected.", message: nil, callback: nil)
                return false
            }
            if passenger.expireMonth == "MONTH"{
                showAlert(title: "Expire month not selected.", message: nil, callback: nil)
                return false
            }
            if passenger.expireYear == "YEAR"{
                showAlert(title: "Expire year not selected.", message: nil, callback: nil)
                return false
            }
        }
        if passenger.phoneNumberWithoutCountryCode.isEmpty{
            showAlert(title: "Phone number not added.", message: nil, callback: nil)
            return false
        }
        if passenger.emailAddress.isEmpty{
            showAlert(title: "Email not added.", message: nil, callback: nil)
            return false
        }
        //        }
        return true
    }
    
    func toWebView(type: GivenOption){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomWebViewController") as? CustomWebViewController{
            vc.currentOption = type
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func skyStarTapped(){
        toWebView(type: .skyStarSignUp)
        //        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SkyStarViewController") as? SkyStarViewController{
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
    }
    
    @objc func hotlineTapped(){
        toWebView(type: .hotline)
    }
    
    @objc func manageBookingTapped(){
        toWebView(type: .manageBooking)
        //        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageBookingViewController") as? ManageBookingViewController{
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
    }
    
    @objc func holidayTapped(){
        toWebView(type: .holiday)
    }
    
    @objc func flightScheduleTapped(){
        toWebView(type: .flightSchedule)
    }
    
    @objc func notificationTapped(){
    }
    
    @objc func backTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func crossTapped(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func menuTapped(){
        if (sideBarView?.frame.origin.x == shiftX) {
            visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            visualEffectView.alpha=0.8
            visualEffectView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height+200)
            self.navigationController?.view.addSubview(visualEffectView)
            let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
            visualEffectView.addGestureRecognizer(tap)
            
            sideBarView?.superview?.bringSubviewToFront(sideBarView!)
            
            print("======shiftX = \(shiftX)\n self.sideBarView?.frame.origin.x = \(String(describing: self.sideBarView?.frame.origin.x))")
            
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.sideBarView?.frame.origin.x = 0
            }, completion: nil)
            
            self.sideBarView?.frame.origin.x = 0
            print("======shiftX = \(shiftX)\n self.sideBarView?.frame.origin.x = \(String(describing: self.sideBarView?.frame.origin.x))")
            
        }else {
            if (visualEffectView != nil) {
                visualEffectView.removeFromSuperview()
                visualEffectView = nil
            }
            print("======shiftX = \(shiftX)\n self.sideBarView?.frame.origin.x = \(String(describing: self.sideBarView?.frame.origin.x))")
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.sideBarView?.frame.origin.x = self.shiftX
                print("======shiftX = \(self.shiftX)\n self.sideBarView?.frame.origin.x = \(String(describing: self.sideBarView?.frame.origin.x))")
                
            }, completion: nil)
        }
    }
    
    // hide menu
    @objc func hideMenu() {
        if (visualEffectView != nil) {
            visualEffectView.removeFromSuperview()
            visualEffectView = nil
        }
        print("======shiftX = \(shiftX)\n self.sideBarView?.frame.origin.x = \(String(describing: self.sideBarView?.frame.origin.x))")
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.sideBarView?.frame.origin.x = self.shiftX
            print("======shiftX = \(self.shiftX)\n self.sideBarView?.frame.origin.x = \(String(describing: self.sideBarView?.frame.origin.x))")
        }, completion: nil)
    }
    
    // menu
    func sideBarSetup(willChangeState: Bool = false) {
        print("======shiftX = \(shiftX)")
        var logicalWidth = factX
        var lineY: CGFloat = 200
        var height: CGFloat = 200
        if UIDevice.current.userInterfaceIdiom == .pad{
            logicalWidth = factXiPad
            height = 300
            lineY = 300
        }
        //        if (UserDefaults.standard.object(forKey: "token") != nil) {
        //            sideMenutitleArray = ["ম্যাপ ভিউ", "পিন সাজেশন", "তাঁরাও ছিলেন", "অ্যাকাউন্ট", "সাহায্য", "লগআউট"]
        //        }
        sideBarView = UIView()
        sideBarView.tag = 6
        sideBarView.backgroundColor = CustomColor.primaryColor
        print(" self.view.frame.width = \( self.view.frame.width)")
        print(" self.view.frame.size.width = \( self.view.frame.size.width)")
        print(" -self.view.frame.size.height = \( self.view.frame.height)")
        
        if willChangeState && UIWindow.isLandscape == false {
            // will transit to from protrait to landscape (height become width)
            sideBarView.frame = CGRect(x: shiftX, y: 0, width: self.view.frame.height * 0.8, height: self.view.frame.width)
        }else{
            // portratit
            sideBarView.frame = CGRect(x: shiftX, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height)
        }
        self.navigationController?.view.addSubview(sideBarView)
        if logicalWidth == 1 {
            height = 200
        }
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: (sideBarView.frame.width), height: height)
        sideBarView.addSubview(topView)
        //        topView.backgroundColor = .white
        
        // upper image
        logoImgView = UIImageView(frame: CGRect(x: 20*logicalWidth, y: 30, width:250, height: 200))
        //        let imageWidth: CGFloat = 60
        //        logoImgView=UIImageView(frame: CGRect(x:20*logicalWidth,y:60*logicalWidth,width:imageWidth*logicalWidth,height:imageWidth*logicalWidth))
        //        logoImgView?.layer.cornerRadius = (imageWidth/2)*logicalWidth
        //        logoImgView?.clipsToBounds = true
        logoImgView?.image = UIImage(named: "USBA-Logo-White")
        logoImgView?.contentMode = .scaleAspectFit
        topView.addSubview(logoImgView!)
        
        
        print("lineY = \(lineY)")
        //        // name
        //        cataTopLbl.frame =  CGRect(x: 20*logicalWidth , y: (logoImgView?.frame.origin.y)!+50*logicalWidth, width: 190*logicalWidth, height: (logoImgView?.frame.size.height ?? 0.0 + 20.0)!)
        //
        //        //        cataTopLbl.font = UIFont.boldSystemFont(ofSize: 19.0)
        //        cataTopLbl.font = UIFont.systemFont(ofSize: 19.0, weight: .medium)
        //
        //        cataTopLbl.textColor = .black
        //        cataTopLbl.numberOfLines = 0
        //        //        cataTopLbl.text = "লগইন করুন"
        //        topView.addSubview(cataTopLbl)
        //        //        topView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileTapped)))
        //
        //        let lineView = UIView()
        //        lineView.frame = CGRect(x: 0, y: lineY, width: (sideBarView.frame.width), height: 0.5)
        //        topView.addSubview(lineView)
        //        lineView.backgroundColor =  .lightGray//UIColor(hexFromString: "#00000033")
        
        sideBarTableView = UITableView()
        sideBarTableView.backgroundColor = .clear
        sideBarTableView.frame = CGRect(x: 0,y: topView.frame.origin.y+topView.frame.size.height+16, width: (sideBarView.frame.width), height: (sideBarView.frame.height)-(topView.frame.origin.y+topView.frame.size.height)+16)
        sideBarView.addSubview(sideBarTableView)
        sideBarTableView.separatorStyle = .singleLine
        sideBarTableView.separatorColor = .white
        let footerView = UIView()
        footerView.frame.size.height = 32
        footerView.backgroundColor = .clear
        sideBarTableView.tableFooterView = footerView
        sideBarTableView.dataSource = self
        sideBarTableView.delegate = self
        sideBarTableView.showsVerticalScrollIndicator = false
        sideBarTableView.alwaysBounceVertical = false
        sideBarTableView.isScrollEnabled = true
        sideBarTableView.register(UINib.init(nibName: "SideBarTableViewCell", bundle: nil), forCellReuseIdentifier: "SideBarTableViewCell")
    }
    
}


extension InputPassengerInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == sideBarTableView{
            return 55
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sideBarTableView{
            return sideMenutitleArray.count
        }else{
            //            var count = 0
            //            for passenger in passengers{
            //                count += (passenger.passengerQuantity ?? 0)
            //            }
            //            return count
            return computedPassengers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == sideBarTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SideBarTableViewCell.self)) as! SideBarTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.sideBartitleLabel.text = self.sideMenutitleArray.object(at: indexPath.row) as? String
            cell.sideBarImg.image = self.sideMenuImgArray[indexPath.row]
            cell.sideBarImg.tintColor = .white
            //        if indexPath.row == 0 {
            //            cell.backgroundColor = UIColor(hexFromString: "#F07527", alpha: 0.1)
            //        }
            return cell
            
        }else{
            if indexPath.row == 0{
                if isLocalFlight{
                    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeadPassengerCell.self)) as! LeadPassengerCell
                    cell.selectionStyle = .none
                    cell.passengerTypeLabel.text = "ADULT - 1 (LEAD)"
                    
                    cell.titleLabel.text = computedPassengers[indexPath.row].title
                    cell.dobDateButton.setTitle(computedPassengers[indexPath.row].dobDay, for: .normal)
                    cell.dobMonthButton.setTitle(computedPassengers[indexPath.row].dobMonth, for: .normal)
                    cell.dobYearButton.setTitle(computedPassengers[indexPath.row].dobYear, for: .normal)
                    //                    cell.expireDateButton.setTitle(computedPassengers[indexPath.row].expireDay, for: .normal)
                    //                    cell.expireMonthButton.setTitle(computedPassengers[indexPath.row].expireMonth, for: .normal)
                    //                    cell.expireYearButton.setTitle(computedPassengers[indexPath.row].expireYear, for: .normal)
                    //                    cell.passportNumberTextField.text = computedPassengers[indexPath.row].passportNumber
                    cell.countryLabel.text = computedPassengers[indexPath.row].country
                    cell.phoneCodeLabel.text = computedPassengers[indexPath.row].phoneCode
                    cell.phoneNumberTextField.text = computedPassengers[indexPath.row].phoneNumberWithoutCountryCode
                    cell.emailAddressTextField.text = computedPassengers[indexPath.row].emailAddress
                    cell.ffpNumberTextField.text = computedPassengers[indexPath.row].ffpNumber
                    cell.firstNameTextField.text = computedPassengers[indexPath.row].firstName
                    cell.lastNameTextField.text = computedPassengers[indexPath.row].lastName
                    
                    cell.selectedTitle = { item in
                        self.computedPassengers[indexPath.row].title = item
                        UserDefaults.standard.setValue(item, forKey: "title")
                    }
                    cell.selectedDobDay = { item in
                        self.computedPassengers[indexPath.row].dobDay = item
                        UserDefaults.standard.setValue(item, forKey: "dobDay")
                    }
                    cell.selectedDobMonth = { item in
                        self.computedPassengers[indexPath.row].dobMonth = item
                        UserDefaults.standard.setValue(item, forKey: "dobMonth")
                    }
                    cell.selectedDobYear = { item in
                        self.computedPassengers[indexPath.row].dobYear = item
                        UserDefaults.standard.setValue(item, forKey: "dobYear")
                    }
                    //                    cell.selectedExpireDay = { item in
                    //                        self.computedPassengers[indexPath.row].expireDay = item
                    //                    }
                    //                    cell.selectedExpireMonth = { item in
                    //                        self.computedPassengers[indexPath.row].expireMonth = item
                    //                    }
                    //                    cell.selectedExpireYear = { item in
                    //                        self.computedPassengers[indexPath.row].expireYear = item
                    //                    }
                    //                    cell.selectedPassportNumer = { item in
                    //                        self.computedPassengers[indexPath.row].passportNumber = item
                    //                    }
                    cell.selectedPhoneCode = { item in
                        self.computedPassengers[indexPath.row].phoneCode = item
                        UserDefaults.standard.setValue(item, forKey: "phoneCode")
                    }
                    cell.selectedPhoneNumber = { item in
                        self.computedPassengers[indexPath.row].phoneNumberWithoutCountryCode = item
                        UserDefaults.standard.setValue(item, forKey: "phoneNumberWithoutCountryCode")
                    }
                    cell.selectedCountry = { item, code in
                        self.computedPassengers[indexPath.row].country = item
                        self.computedPassengers[indexPath.row].countryCode = code
                        UserDefaults.standard.setValue(item, forKey: "country")
                    }
                    cell.selectedFirstName = { item in
                        self.computedPassengers[indexPath.row].firstName = item
                        UserDefaults.standard.setValue(item, forKey: "firstName")
                    }
                    cell.selectedLastName = { item in
                        self.computedPassengers[indexPath.row].lastName = item
                        UserDefaults.standard.setValue(item, forKey: "lastName")
                    }
                    cell.selectedFFPNumber = { item in
                        self.computedPassengers[indexPath.row].ffpNumber = item
                        UserDefaults.standard.setValue(item, forKey: "ffpNumber")
                    }
                    cell.selectedEmailAdress = { item in
                        self.computedPassengers[indexPath.row].emailAddress = item
                        UserDefaults.standard.setValue(item, forKey: "emailAddress")
                    }
                    
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeadGlobalPassengerCell.self)) as! LeadGlobalPassengerCell
                    cell.selectionStyle = .none
                    cell.passengerTypeLabel.text = "ADULT - 1 (LEAD)"
                    cell.documentDetailsTitleLabel.text = "ADULT - 1 : DOCUMENT DETAILS"
                    
                    cell.titleLabel.text = computedPassengers[indexPath.row].title
                    cell.dobDateButton.setTitle(computedPassengers[indexPath.row].dobDay, for: .normal)
                    cell.dobMonthButton.setTitle(computedPassengers[indexPath.row].dobMonth, for: .normal)
                    cell.dobYearButton.setTitle(computedPassengers[indexPath.row].dobYear, for: .normal)
                    cell.expireDateButton.setTitle(computedPassengers[indexPath.row].expireDay, for: .normal)
                    cell.expireMonthButton.setTitle(computedPassengers[indexPath.row].expireMonth, for: .normal)
                    cell.expireYearButton.setTitle(computedPassengers[indexPath.row].expireYear, for: .normal)
                    cell.documentNumberTextField.text = computedPassengers[indexPath.row].documentNumber
                    cell.nationalityLabel.text = computedPassengers[indexPath.row].country
                    cell.birthplaceLabel.text = computedPassengers[indexPath.row].birthplace
                    cell.documentIssuanceCountryLabel.text = computedPassengers[indexPath.row].documentIssuanceCountry
                    cell.documentTypeLabel.text = computedPassengers[indexPath.row].documentTypeValue
                    cell.phoneCodeLabel.text = computedPassengers[indexPath.row].phoneCode
                    cell.phoneNumberTextField.text = computedPassengers[indexPath.row].phoneNumberWithoutCountryCode
                    cell.emailAddressTextField.text = computedPassengers[indexPath.row].emailAddress
                    cell.ffpNumberTextField.text = computedPassengers[indexPath.row].ffpNumber
                    cell.firstNameTextField.text = computedPassengers[indexPath.row].firstName
                    cell.lastNameTextField.text = computedPassengers[indexPath.row].lastName
                    
                    cell.selectedTitle = { item in
                        self.computedPassengers[indexPath.row].title = item
                        UserDefaults.standard.setValue(item, forKey: "title")
                    }
                    cell.selectedDobDay = { item in
                        self.computedPassengers[indexPath.row].dobDay = item
                        UserDefaults.standard.setValue(item, forKey: "dobDay")
                    }
                    cell.selectedDobMonth = { item in
                        self.computedPassengers[indexPath.row].dobMonth = item
                        UserDefaults.standard.setValue(item, forKey: "dobMonth")
                    }
                    cell.selectedDobYear = { item in
                        self.computedPassengers[indexPath.row].dobYear = item
                        UserDefaults.standard.setValue(item, forKey: "dobYear")
                    }
                    cell.selectedExpireDay = { item in
                        self.computedPassengers[indexPath.row].expireDay = item
                        UserDefaults.standard.setValue(item, forKey: "expireDay")
                    }
                    cell.selectedExpireMonth = { item in
                        self.computedPassengers[indexPath.row].expireMonth = item
                        UserDefaults.standard.setValue(item, forKey: "expireMonth")
                    }
                    cell.selectedExpireYear = { item in
                        self.computedPassengers[indexPath.row].expireYear = item
                        UserDefaults.standard.setValue(item, forKey: "expireYear")
                    }
                    cell.selectedDocumentNumer = { item in
                        self.computedPassengers[indexPath.row].documentNumber = item
                        UserDefaults.standard.setValue(item, forKey: "documentNumber")
                    }
                    cell.selectedDocumentType = { (key, val) in
                        self.computedPassengers[indexPath.row].documentTypeKey = key
                        self.computedPassengers[indexPath.row].documentTypeValue = val
                        UserDefaults.standard.setValue(key, forKey: "documentTypeKey")
                        UserDefaults.standard.setValue(val, forKey: "documentTypeValue")
                    }
                    cell.selectedPhoneCode = { item in
                        self.computedPassengers[indexPath.row].phoneCode = item
                        UserDefaults.standard.setValue(item, forKey: "phoneCode")
                    }
                    cell.selectedPhoneNumber = { item in
                        self.computedPassengers[indexPath.row].phoneNumberWithoutCountryCode = item
                        UserDefaults.standard.setValue(item, forKey: "phoneNumberWithoutCountryCode")
                    }
                    cell.selectedNationality = { item, code in
                        self.computedPassengers[indexPath.row].country = item
                        self.computedPassengers[indexPath.row].countryCode = code
                        UserDefaults.standard.setValue(item, forKey: "country")
                    }
                    cell.selectedBirthplace = { item, code in
                        self.computedPassengers[indexPath.row].birthplace = item
                        //                        self.computedPassengers[indexPath.row].countryCode = code
                        UserDefaults.standard.setValue(item, forKey: "birthplace")
                    }
                    cell.selectedDocumentIssuanceCountry = { item, code in
                        self.computedPassengers[indexPath.row].documentIssuanceCountry = item
                        //                        self.computedPassengers[indexPath.row].countryCode = code
                        UserDefaults.standard.setValue(item, forKey: "documentIssuanceCountry")
                    }
                    cell.selectedFirstName = { item in
                        self.computedPassengers[indexPath.row].firstName = item
                        UserDefaults.standard.setValue(item, forKey: "firstName")
                    }
                    cell.selectedLastName = { item in
                        self.computedPassengers[indexPath.row].lastName = item
                        UserDefaults.standard.setValue(item, forKey: "lastName")
                    }
                    cell.selectedFFPNumber = { item in
                        self.computedPassengers[indexPath.row].ffpNumber = item
                        UserDefaults.standard.setValue(item, forKey: "ffpNumber")
                    }
                    cell.selectedEmailAdress = { item in
                        self.computedPassengers[indexPath.row].emailAddress = item
                        UserDefaults.standard.setValue(item, forKey: "emailAddress")
                    }
                    
                    return cell
                }
            }else{
                if isLocalFlight{
                    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OtherPassengerCell.self)) as! OtherPassengerCell
                    cell.selectionStyle = .none
                    
                    let passenger = computedPassengers[indexPath.row]
                    
                    if passenger.passengerTypeCode == "AD"{
                        cell.passengerTypeLabel.text = "ADULT - \(passenger.index)"
                    }else if passenger.passengerTypeCode == "CHD"{
                        cell.passengerTypeLabel.text = "CHILD - \(passenger.index)"
                    }else{
                        cell.passengerTypeLabel.text = "INFANT - \(passenger.index)"
                    }
                    
                    cell.titleLabel.text = computedPassengers[indexPath.row].title
                    cell.dobDateButton.setTitle(computedPassengers[indexPath.row].dobDay, for: .normal)
                    cell.dobMonthButton.setTitle(computedPassengers[indexPath.row].dobMonth, for: .normal)
                    cell.dobYearButton.setTitle(computedPassengers[indexPath.row].dobYear, for: .normal)
                    //                    cell.expireDateButton.setTitle(computedPassengers[indexPath.row].expireDay, for: .normal)
                    //                    cell.expireMonthButton.setTitle(computedPassengers[indexPath.row].expireMonth, for: .normal)
                    //                    cell.expireYearButton.setTitle(computedPassengers[indexPath.row].expireYear, for: .normal)
                    //                    cell.passportNumberTextField.text = computedPassengers[indexPath.row].passportNumber
                    //                    cell.countryLabel.text = computedPassengers[indexPath.row].country
                    //                    cell.phoneCodeLabel.text = computedPassengers[indexPath.row].countryCode
                    //                    cell.phoneNumberTextField.text = computedPassengers[indexPath.row].phoneNumberWithoutCountryCode
                    //                    cell.emailAddressTextField.text = computedPassengers[indexPath.row].emailAddress
                    cell.ffpNumberTextField.text = computedPassengers[indexPath.row].ffpNumber
                    cell.firstNameTextField.text = computedPassengers[indexPath.row].firstName
                    cell.lastNameTextField.text = computedPassengers[indexPath.row].lastName
                    
                    cell.selectedTitle = { item in
                        self.computedPassengers[indexPath.row].title = item
                    }
                    cell.selectedDobDay = { item in
                        self.computedPassengers[indexPath.row].dobDay = item
                    }
                    cell.selectedDobMonth = { item in
                        self.computedPassengers[indexPath.row].dobMonth = item
                    }
                    cell.selectedDobYear = { item in
                        self.computedPassengers[indexPath.row].dobYear = item
                    }
                    //                    cell.selectedExpireDay = { item in
                    //                        self.computedPassengers[indexPath.row].expireDay = item
                    //                    }
                    //                    cell.selectedExpireMonth = { item in
                    //                        self.computedPassengers[indexPath.row].expireMonth = item
                    //                    }
                    //                    cell.selectedExpireYear = { item in
                    //                        self.computedPassengers[indexPath.row].expireYear = item
                    //                    }
                    //                    cell.selectedPassportNumer = { item in
                    //                        self.computedPassengers[indexPath.row].passportNumber = item
                    //                    }
                    cell.selectedPhoneCode = { item in
                        self.computedPassengers[indexPath.row].phoneCode = item
                    }
                    cell.selectedPhoneNumber = { item in
                        self.computedPassengers[indexPath.row].phoneNumberWithoutCountryCode = item
                    }
                    cell.selectedCountry = { item, code in
                        self.computedPassengers[indexPath.row].country = item
                        self.computedPassengers[indexPath.row].countryCode = code
                    }
                    cell.selectedFirstName = { item in
                        self.computedPassengers[indexPath.row].firstName = item
                    }
                    cell.selectedLastName = { item in
                        self.computedPassengers[indexPath.row].lastName = item
                    }
                    cell.selectedFFPNumber = { item in
                        self.computedPassengers[indexPath.row].ffpNumber = item
                    }
                    cell.selectedEmailAdress = { item in
                        self.computedPassengers[indexPath.row].emailAddress = item
                    }
                    
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OtherGlobalPassengerTableViewCell.self)) as! OtherGlobalPassengerTableViewCell
                    cell.selectionStyle = .none
                    
                    let passenger = computedPassengers[indexPath.row]
                    
                    if passenger.passengerTypeCode == "AD"{
                        cell.passengerTypeLabel.text = "ADULT - \(indexPath.row + 1)"
                        cell.documentDetailsTitleLabel.text = "ADULT - \(indexPath.row + 1) : DOCUMENT DETAILS"
                    }else if passenger.passengerTypeCode == "CHD"{
                        cell.passengerTypeLabel.text = "CHILD - \(indexPath.row + 1)"
                        cell.documentDetailsTitleLabel.text = "CHILD - \(indexPath.row + 1) : DOCUMENT DETAILS"
                    }else{
                        cell.passengerTypeLabel.text = "INFANT - \(indexPath.row + 1)"
                        cell.documentDetailsTitleLabel.text = "INFANT - \(indexPath.row + 1) : DOCUMENT DETAILS"
                    }
                    
                    cell.titleLabel.text = computedPassengers[indexPath.row].title
                    cell.dobDateButton.setTitle(computedPassengers[indexPath.row].dobDay, for: .normal)
                    cell.dobMonthButton.setTitle(computedPassengers[indexPath.row].dobMonth, for: .normal)
                    cell.dobYearButton.setTitle(computedPassengers[indexPath.row].dobYear, for: .normal)
                    cell.expireDateButton.setTitle(computedPassengers[indexPath.row].expireDay, for: .normal)
                    cell.expireMonthButton.setTitle(computedPassengers[indexPath.row].expireMonth, for: .normal)
                    cell.expireYearButton.setTitle(computedPassengers[indexPath.row].expireYear, for: .normal)
                    cell.documentNumberTextField.text = computedPassengers[indexPath.row].documentNumber
                    cell.documentTypeLabel.text = computedPassengers[indexPath.row].documentTypeValue
                    //                    cell.countryLabel.text = computedPassengers[indexPath.row].country
                    //                    cell.phoneCodeLabel.text = computedPassengers[indexPath.row].countryCode
                    //                    cell.phoneNumberTextField.text = computedPassengers[indexPath.row].phoneNumberWithoutCountryCode
                    //                    cell.emailAddressTextField.text = computedPassengers[indexPath.row].emailAddress
                    cell.ffpNumberTextField.text = computedPassengers[indexPath.row].ffpNumber
                    cell.firstNameTextField.text = computedPassengers[indexPath.row].firstName
                    cell.lastNameTextField.text = computedPassengers[indexPath.row].lastName
                    
                    cell.selectedTitle = { item in
                        self.computedPassengers[indexPath.row].title = item
                    }
                    cell.selectedDobDay = { item in
                        self.computedPassengers[indexPath.row].dobDay = item
                    }
                    cell.selectedDobMonth = { item in
                        self.computedPassengers[indexPath.row].dobMonth = item
                    }
                    cell.selectedDobYear = { item in
                        self.computedPassengers[indexPath.row].dobYear = item
                    }
                    cell.selectedExpireDay = { item in
                        self.computedPassengers[indexPath.row].expireDay = item
                    }
                    cell.selectedExpireMonth = { item in
                        self.computedPassengers[indexPath.row].expireMonth = item
                    }
                    cell.selectedExpireYear = { item in
                        self.computedPassengers[indexPath.row].expireYear = item
                    }
                    cell.selectedDocumentType = { (key, val) in
                        self.computedPassengers[indexPath.row].documentTypeKey = key
                        self.computedPassengers[indexPath.row].documentTypeValue = val
                        UserDefaults.standard.setValue(key, forKey: "documentTypeKey")
                        UserDefaults.standard.setValue(val, forKey: "documentTypeValue")
                    }
                    cell.selectedDocumentNumer = { item in
                        self.computedPassengers[indexPath.row].documentNumber = item
                    }
                    cell.selectedPhoneCode = { item in
                        self.computedPassengers[indexPath.row].phoneCode = item
                    }
                    cell.selectedPhoneNumber = { item in
                        self.computedPassengers[indexPath.row].phoneNumberWithoutCountryCode = item
                    }
                    cell.selectedCountry = { item, code in
                        self.computedPassengers[indexPath.row].country = item
                        self.computedPassengers[indexPath.row].countryCode = code
                    }
                    cell.selectedBirthplace = { item, code in
                        self.computedPassengers[indexPath.row].birthplace = item
                        //                        self.computedPassengers[indexPath.row].countryCode = code
                    }
                    cell.selectedDocumentIssuanceCountry = { item, code in
                        self.computedPassengers[indexPath.row].documentIssuanceCountry = item
                        //                        self.computedPassengers[indexPath.row].countryCode = code
                    }
                    cell.selectedFirstName = { item in
                        self.computedPassengers[indexPath.row].firstName = item
                    }
                    cell.selectedLastName = { item in
                        self.computedPassengers[indexPath.row].lastName = item
                    }
                    cell.selectedFFPNumber = { item in
                        self.computedPassengers[indexPath.row].ffpNumber = item
                    }
                    cell.selectedEmailAdress = { item in
                        self.computedPassengers[indexPath.row].emailAddress = item
                    }
                    
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sideBarTableView{
            hideMenu()
            switch indexPath.row {
            case BOOK_FLIGHT_SECTION:
                print("same page; do nothing")
            case MY_BOOKING_SECTION:
                toWebView(type: .myBooking)
            case WEB_CHECK_IN_SECTION:
                toWebView(type: .webCheckIn)
            case MANAGE_BOOKING_SECTION:
                //            toWebView(type: .manageBooking)
                manageBookingTapped()
            case HOLIDAYS_SECTION:
                toWebView(type: .holiday)
            case FLIGHT_SCHEDULE_SECTION:
                toWebView(type: .flightSchedule)
            case SKY_STAR_SECTION:
                //            toWebView(type: .skyStarSignUp)
                skyStarTapped()
            case SALES_OFFICE_SECTION:
                toWebView(type: .salesOffice)
            case CONTACT_US_SECTION:
                toWebView(type: .hotline)
            default:
                break
            }
            
        }else{
            
        }
    }    
}


// MARK: API CALL
extension InputPassengerInfoViewController{
    
    func createBooking() {
        var passengersParams = [Parameters]()
        var specialServicesParams = [Parameters]()
        
        for passenger in computedPassengers{
            let nameElement: Parameters = [
                "CivilityCode": passenger.title,
                "Firstname": passenger.firstName,
                "Surname": passenger.lastName
            ]
            let item: Parameters = [
                "Ref":  passenger.refPassenger, // passenger.ref ?? "",
                "RefClient": passenger.ref ?? "", // passenger.refClient ?? "",
                "PassengerQuantity": 1,
                "PassengerTypeCode": passenger.passengerTypeCode ?? "",
                "NameElement": nameElement,
                "Extensions": []
            ]
            passengersParams.append(item)
            
            let dobMonth = monthDictionary[passenger.dobMonth] ?? ""
            let expireMonth = monthDictionary[passenger.expireMonth] ?? ""
            let dob = "\(passenger.dobYear)-\(dobMonth)-\(passenger.dobDay)T00:00:00"
            let expireDate = "\(passenger.expireYear)-\(expireMonth)-\(passenger.expireDay)T00:00:00"
            var currentCode = ""
            var dobParamKey = ""
            if passenger.passengerTypeCode == "AD"{
                currentCode = "EXT-ADOB"
                dobParamKey = "Adof"
            }else if passenger.passengerTypeCode == "CHD"{
                currentCode = "CHLD"
                dobParamKey = "Chld"
            }else{
                currentCode = "INFT"
                dobParamKey = "Inft"
            }
            let dobParam: Parameters = [
                "DateOfBirth": dob
            ]
            let dobData: Parameters = [
                dobParamKey: dobParam
            ]
            
            let dobParams: Parameters = [
                "Data": dobData,
                "RefPassenger": passenger.refPassenger,
                "Code": currentCode
            ]
            specialServicesParams.append(dobParams)
            
            if passenger.emailAddress.isEmpty == false{
                let phoneParams: Parameters = [
                    "Text": "\(passenger.phoneCode)\(passenger.phoneNumberWithoutCountryCode)",
                    "RefPassenger": passenger.refPassenger,
                    "Code": "CTCH"
                ]
                specialServicesParams.append(phoneParams)
                
                let emailParams: Parameters = [
                    "Text": passenger.emailAddress,
                    "RefPassenger": passenger.refPassenger,
                    "Code": "CTCE"
                ]
                specialServicesParams.append(emailParams)
            }
            
            if isLocalFlight == false{
                var gender = "F"
                if passenger.title == "MR" || passenger.title == "MSTR"{
                    gender = "M"
                }
                
                var documentsPrams = [Parameters]()
                let documentsParam: Parameters = [
                    "IssueCountryCode": passenger.countryCode,
                    "NationalityCountryCode": passenger.countryCode,
                    "DocumentIssuingCountry": passenger.documentIssuanceCountry,
                    "Nationality": passenger.country,
                    "DateOfBirth": dob,
                    "Gender": gender,
                    "DocumentExpiryDate": expireDate,
                    "DocumentIssuanceDate": "", // not available
                    "Firstname": passenger.firstName,
                    "Surname": passenger.lastName,
                    "DocumentTypeCode": passenger.documentTypeKey,  // "PP",
                    "DocumentNumber": passenger.documentNumber
                ]
                documentsPrams.append(documentsParam)
                
                let docParam: Parameters = [
                    "Documents": documentsPrams
                ]
                let docDataParam: Parameters = [
                    "Docs": docParam
                ]
                let docMainParams: Parameters = [
                    "Data": docDataParam,
                    "RefPassenger": passenger.refPassenger,
                    "Code": "DOCS"
                ]
                specialServicesParams.append(docMainParams)
            }
        }
        
        var selectedItiRef = ""
        if oneWayflight == nil{
            selectedItiRef = returnFlight?.itineraryRef ?? ""
        }else{
            selectedItiRef = oneWayflight?.itineraryRef ?? ""
        }
        let offerParams: Parameters = [
            "RefItinerary": selectedItiRef,
            "Ref": offer?.ref ?? ""
        ]
        
        let emdTicketFares: Parameters = [
            "EMDTicketFares": []
        ]
        
        let requestInfo: Parameters = [
            "AuthenticationKey": GlobalItems.getAuthKey(),
            "CultureName": "en-GB"
        ]
        
        let requestParams: Parameters = [
            "SpecialServices": specialServicesParams,
            "Passengers": passengersParams,
            "FareInfo": emdTicketFares,
            "Offer": offerParams,
            "RequestInfo": requestInfo
        ]
        
        let params: Parameters = [
            "request": requestParams
        ]
        
        guard let url = URL(string: "\(GlobalItems.getBaseUrl())/Zenith/TTI.PublicApi.Services/JsonSaleEngineService.svc/CreateBooking?DateFormatHandling=IsoDateFormat") else{
            return
        }
        
        print("url: \(url) params = \(params) \n\n\(params.jsonString(prettify: true) ?? "")")
        
        SVProgressHUD.show()
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<CreateBookingModel>) in
            print("=== response = \(response)")
            if SVProgressHUD.isVisible(){
                SVProgressHUD.dismiss()
            }
            guard let statusCode = response.response?.statusCode else{
                //                if SVProgressHUD.isVisible(){
                //                    SVProgressHUD.dismiss()
                //                }
                self.showAlert(title: "No data found", message: nil, callback: nil)
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                print("")
                if let pnrInfo = response.result.value?.booking?.pnrInformation{
                    if let vc = UIStoryboard(name: "FlightBookingPart2", bundle: nil).instantiateViewController(withIdentifier: "BookingConfirmationViewController") as? BookingConfirmationViewController{
                        vc.isLocalFlight = self.isLocalFlight
                        vc.pnrInfo = pnrInfo
                        vc.passengers = self.computedPassengers
                        vc.offer = self.offer
                        vc.eTTicketFares = self.eTTicketFares
                        vc.oneWayflight = self.oneWayflight
                        vc.returnFlight = self.returnFlight
                        vc.selectedItiRef = self.selectedItiRef
                        vc.fromTime = self.fromTime
                        vc.toTime = self.toTime
                        vc.fromCityCode = self.fromCityCode
                        vc.toCityCode = self.toCityCode
                        vc.fromCity = self.fromCity
                        vc.toCity = self.toCity
                        vc.forwardFlightClass = self.forwardFlightClass
                        vc.backwardFlightClass = self.backwardFlightClass
                        vc.selectedCurrency = self.selectedCurrency
                        vc.flightClass = self.flightClass
                        self.navigationController?.pushViewController(vc)
                    }
                }else{
                    self.showAlert(title: "Something went wrong! Please provide accurate information", message: nil, callback: nil)
                }
            case .failure(let error):
                //                if SVProgressHUD.isVisible(){
                //                    SVProgressHUD.dismiss()
                //                }
                self.showAlert(title: "Something went wrong! Please provide accurate information", message: nil, callback: nil)
                print("error = \(error)")
            }
        }).responseJSON { (json) in
            print("json = \(json)")
        }
    }
    
}
