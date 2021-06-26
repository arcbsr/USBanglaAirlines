//
//  FlightSummaryViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 28/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import AlamofireObjectMapper


class FlightSummaryViewController: UIViewController {
    @IBOutlet weak var bookNowButton: UIButton!{
        didSet{
            bookNowButton.setTitleColor(CustomColor.primaryColor, for: .normal)
            let attributedText = NSAttributedString(string: "BOOK NOW!", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .semibold), .underlineStyle: NSUnderlineStyle.single.rawValue])
            bookNowButton.setAttributedTitle(attributedText, for: .normal)
        }
    }
    @IBOutlet weak var fareAndBaggageRulesView: UIView!{
        didSet{
            fareAndBaggageRulesView.isUserInteractionEnabled = true
            fareAndBaggageRulesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fareAndBaggageRulesTapped)))
        }
    }
    @IBOutlet weak var flightIdLabel: UILabel!
    @IBOutlet weak var flightNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var toTimeLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    @IBOutlet weak var cabinClassLabel: UILabel!
    
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var adultFareLabel: UILabel!
    @IBOutlet weak var adultSeparatorView: UIView!
    @IBOutlet weak var adultTaxLabel: UILabel!
    
    @IBOutlet weak var childrenLabel: UILabel!
    @IBOutlet weak var childrenFareLabel: UILabel!
    @IBOutlet weak var childrenSeparatorView: UIView!
    @IBOutlet weak var childrenTaxLabel: UILabel!
    
    @IBOutlet weak var infantLabel: UILabel!
    @IBOutlet weak var infantFareLabel: UILabel!
    @IBOutlet weak var infantSeparatorView: UIView!
    @IBOutlet weak var infantTaxLabel: UILabel!
    
    @IBOutlet weak var baseAmountLabel: UILabel!
    @IBOutlet weak var taxAmountLabel: UILabel!
    @IBOutlet weak var totalFareLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var amountPayableLabel: UILabel!
    @IBOutlet weak var proceedButton: UIButton!{
        didSet{
            proceedButton.backgroundColor = CustomColor.secondaryColor
        }
    }
    @IBOutlet weak var notificationImageView: UIImageView!{
        didSet{
            notificationImageView.isUserInteractionEnabled = true
            notificationImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notificationTapped)))
        }
    }
    @IBOutlet weak var menuImageView: UIImageView!{
        didSet{
            menuImageView.isUserInteractionEnabled = true
            menuImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(menuTapped)))
        }
    }
    @IBOutlet weak var backImageView: UIImageView!{
        didSet{
            backImageView.isUserInteractionEnabled = true
            backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTapped)))
        }
    }
    @IBOutlet weak var crossImageView: UIImageView!{
        didSet{
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
    var eTTicketFares = [ETTicketFare]()
    var passengers = [Passenger]()
    var offer: Offer?
    var oneWayflight: FlightInfo?
    var returnFlight: SaleCurrencyAmount?
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
    var prepareFlightInfo: PrepareFlight?
    
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
        
        SVProgressHUD.show()
        extractTicketInfo()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareFlight()
    }
    
    @IBAction func proceedButtonTapped(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "PassengerInfo", bundle: nil).instantiateViewController(withIdentifier: "InputPassengerInfoViewController") as? InputPassengerInfoViewController{
            vc.passengers = passengers
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
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func fareAndBaggageRulesTapped(){
        
    }
    
    func extractTicketInfo(){
        if oneWayflight == nil{
            selectedItiRef = returnFlight?.itineraryRef ?? ""
            loadReturnData()
        }else{
            selectedItiRef = oneWayflight?.itineraryRef ?? ""
            loadOneWayData()
        }
        print("selectedItiRef = \(selectedItiRef)")
        for ticketFare in eTTicketFares{
            if selectedItiRef == ticketFare.refItinerary{
                for passenger in passengers{
                    if passenger.ref == ticketFare.refPassenger{
                        passenger.eTTicketFare = ticketFare
                        break
                    }
                }
            }
        }
        
        for passenger in passengers{
            if passenger.passengerTypeCode == "AD"{
                let count = passenger.passengerQuantity ?? 0
                adultLabel.text = "ADULT X \(count)"
                let totalFare = (passenger.eTTicketFare?.saleCurrencyAmount?.baseAmount ?? 0.0) * Double(count)
                adultFareLabel.text = "\(selectedCurrency) \(totalFare)"
                let totalTax = (passenger.eTTicketFare?.saleCurrencyAmount?.taxAmount ?? 0.0) * Double(count)
                adultTaxLabel.text = "\(selectedCurrency) \(totalTax)"
            }else if passenger.passengerTypeCode == "CHD"{
                let count = passenger.passengerQuantity ?? 0
                childrenLabel.text = "CHILD X \(count)"
                let totalFare = (passenger.eTTicketFare?.saleCurrencyAmount?.baseAmount ?? 0.0) * Double(count)
                childrenFareLabel.text = "\(selectedCurrency) \(totalFare)"
                let totalTax = (passenger.eTTicketFare?.saleCurrencyAmount?.taxAmount ?? 0.0) * Double(count)
                childrenTaxLabel.text = "\(selectedCurrency) \(totalTax)"
            }else{
                let count = passenger.passengerQuantity ?? 0
                infantLabel.text = "INFANT X \(count)"
                let totalFare = (passenger.eTTicketFare?.saleCurrencyAmount?.baseAmount ?? 0.0) * Double(count)
                infantFareLabel.text = "\(selectedCurrency) \(totalFare)"
                let totalTax = (passenger.eTTicketFare?.saleCurrencyAmount?.taxAmount ?? 0.0) * Double(count)
                infantTaxLabel.text = "\(selectedCurrency) \(totalTax)"
            }
        }
        
        SVProgressHUD.dismiss()
    }
    
    func loadReturnData(){
        flightIdLabel.text = "FLIGHT: \(returnFlight?.forwardflightInfo?.operatingAirlineDesignator ?? "") \(returnFlight?.forwardflightInfo?.operatingFlightNumber ?? ""))"
        flightNameLabel.text = returnFlight?.forwardflightInfo?.equipmentText ?? ""
        let duration = ((returnFlight?.forwardflightInfo?.durationMinutes ?? 0) + (returnFlight?.backwardflightInfo?.durationMinutes ?? 0))
        durationLabel.text = "\(duration) MIN"
        
        let startDate = returnFlight?.forwardflightInfo?.departureDate ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
        if let date = dateFormatter.date(from: startDate) {
            dateFormatter.dateFormat = "EEE, dd MMM, YYYY"
            fromDateLabel.text = dateFormatter.string(from: date)
        }
        
        let endDate = returnFlight?.forwardflightInfo?.arrivalDate ?? ""
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
        if let date = dateFormatter.date(from: endDate) {
            dateFormatter.dateFormat = "EEE, dd MMM, YYYY"
            toDateLabel.text = dateFormatter.string(from: date)
        }
        
        fromTimeLabel.text = "\(fromTime) \(fromCityCode)"
        toTimeLabel.text = "\(toTime) \(toCityCode)"
        cabinClassLabel.text = forwardFlightClass
        
        let discount = returnFlight?.discountAmount ?? 0
        let totalWithoutDiscount = returnFlight?.totalAmount ?? 0
        let total = totalWithoutDiscount - discount
        discountLabel.text = "\(selectedCurrency) \(discount)"
        totalFareLabel.text = "\(selectedCurrency) \(total)"
    }
    
    func loadOneWayData(){
        flightIdLabel.text = "FLIGHT: \(oneWayflight?.operatingAirlineDesignator ?? "") \(oneWayflight?.operatingFlightNumber ?? "")"
        flightNameLabel.text = oneWayflight?.equipmentText ?? ""
        let duration = ((oneWayflight?.durationMinutes ?? 0) + (oneWayflight?.durationMinutes ?? 0))
        durationLabel.text = "\(duration) MIN"
        
        let startDate = oneWayflight?.departureDate ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
        if let date = dateFormatter.date(from: startDate) {
            dateFormatter.dateFormat = "EEE, dd MMM, YYYY"
            fromDateLabel.text = dateFormatter.string(from: date)
        }
        
        let endDate = oneWayflight?.arrivalDate ?? ""
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
        if let date = dateFormatter.date(from: endDate) {
            dateFormatter.dateFormat = "EEE, dd MMM, YYYY"
            toDateLabel.text = dateFormatter.string(from: date)
        }
        fromTimeLabel.text = "\(fromTime) \(fromCityCode)"
        toTimeLabel.text = "\(toTime) \(toCityCode)"
        cabinClassLabel.text = flightClass
        
        let discount = oneWayflight?.saleCurrencyAmount?.discountAmount ?? 0
        let totalWithoutDiscount = oneWayflight?.saleCurrencyAmount?.totalAmount ?? 0
        let total = totalWithoutDiscount - discount
        discountLabel.text = "\(selectedCurrency) \(discount)"
        totalFareLabel.text = "\(selectedCurrency) \(total)"
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


extension FlightSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenutitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }
    
}


// MARK: API CALL
extension FlightSummaryViewController{
    
    func prepareFlight() {
        
        //            let headers: HTTPHeaders = [
        //                "Authorization": "token \(UserInfo.token)"
        //            ]
        
        //        let requestInfo: Parameters = [
        //            //            "AuthenticationKey": "_JEAAAAL436mpPsYP3m2lwfwBiLPdzcUQEHyecX5mtHR1RMK0DTHTEiyA_EYVUazFkn3rIGIGu6wxA8qa1gYyfs1uOib4E_U",
        //                        "AuthenticationKey": "_JEAAAABWU_EYtV0PDQ5AefVBXqTISe7_EqErTgeZryEzUyElkoBqCSdJh8UQdKZLhbSW62OVwi7Ix58ZnGrS9CBDxSnz7g_U",
        //                        "CultureName": "en-GB"
        //        ]
        
        let requestInfo: Parameters = [
            "AuthenticationKey": GlobalItems.getAuthKey(),
            "CultureName": "en-GB"
        ]
        
        let offerParams: Parameters = [
            "RefItinerary": selectedItiRef,
            "Ref": offer?.ref ?? ""
        ]
        
        let request: Parameters = [
            "RequestInfo": requestInfo,
            "Offer": offerParams
        ]
        
        let params: Parameters = [
            "request": request
        ]
        
        guard let url = URL(string: "\(GlobalItems.getBaseUrl())/Zenith/TTI.PublicApi.Services/JsonSaleEngineService.svc/PrepareFlights") else{
            return
        }
        
        print("url: \(url) params \(params)")
        
        SVProgressHUD.show()
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<PrepareFlight>) in
            print("=== response = \(response)")
            
            if SVProgressHUD.isVisible(){
                SVProgressHUD.dismiss()
            }
            
            guard let statusCode = response.response?.statusCode else{
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                self.prepareFlightInfo = response.result.value
                print("")
            case .failure(let error):
                print("error = \(error)")
            }
        })
    }
    
}

