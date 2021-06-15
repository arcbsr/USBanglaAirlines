//
//  FlightFilterViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 27/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//


import UIKit
import M13Checkbox
import DropDown
import Alamofire
import SVProgressHUD
import AlamofireObjectMapper



class FlightFilterViewController: UIViewController {
    @IBOutlet weak var returnCheckbox: M13Checkbox!{
        didSet{
            returnCheckbox.addTarget(self, action: #selector(returnOptionTapped), for: .valueChanged)
            setupCheckBox(box: returnCheckbox)
        }
    }
    @IBOutlet weak var oneWayCheckbox: M13Checkbox!{
        didSet{
            oneWayCheckbox.addTarget(self, action: #selector(oneWayOptionTapped), for: .valueChanged)
            setupCheckBox(box: oneWayCheckbox)
            oneWayCheckbox.setCheckState(.checked, animated: false)
        }
    }
    @IBOutlet weak var fromCityView: UIView!{
        didSet{
            fromCityView.isUserInteractionEnabled = true
            fromCityView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fromCityTapped)))
            fromCityView.backgroundColor = CustomColor.secondaryColor
        }
    }
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var toCityLabel: UILabel!
    @IBOutlet weak var toCityView: UIView!{
        didSet{
            toCityView.isUserInteractionEnabled = true
            toCityView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toCityTapped)))
            toCityView.backgroundColor = CustomColor.primaryColor
        }
    }
    @IBOutlet weak var flightDirectionImageView: UIImageView!
    @IBOutlet weak var adultView: UIView!{
        didSet{
            adultView.isUserInteractionEnabled = true
            adultView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(adultTapped)))
        }
    }
    @IBOutlet weak var childView: UIView!{
        didSet{
            childView.isUserInteractionEnabled = true
            childView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(childTapped)))
        }
    }
    @IBOutlet weak var adultCountLabel: UILabel!
    @IBOutlet weak var childCountLabel: UILabel!
    @IBOutlet weak var infantView: UIView!{
        didSet{
            infantView.isUserInteractionEnabled = true
            infantView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infantTapped)))
        }
    }
    @IBOutlet weak var infantCountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyView: UIView!{
        didSet{
            currencyView.isUserInteractionEnabled = true
            currencyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(currencyTapped)))
        }
    }
    @IBOutlet weak var departureDateView: UIView!{
        didSet{
            departureDateView.backgroundColor = CustomColor.secondaryColor
            //            departureDateView.isUserInteractionEnabled = true
            //            departureDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(departureDateTapped)))
        }
    }
    @IBOutlet weak var returnDateView: UIView!{
        didSet{
            returnDateView.backgroundColor = CustomColor.secondaryColor
            //            returnDateView.isUserInteractionEnabled = true
            //            returnDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnDateTapped)))
        }
    }
    @IBOutlet weak var departureDateTextField: UITextField!{
        didSet{
            departureDateTextField.tintColor = .clear
            departureDateTextField.attributedPlaceholder = NSAttributedString(string: "DEPARTURE DATE",
                                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            departureDateTextField.inputView = datePicker
            departureDateTextField.addToolbarButton(with: self,
                                                    selector: #selector(departureDateTapped),
                                                    title: "Done",
                                                    tintColor: .systemBlue)
            
        }
    }
    @IBOutlet weak var returnDateTextField: UITextField!{
        didSet{
            returnDateTextField.tintColor = .clear
            returnDateTextField.attributedPlaceholder = NSAttributedString(string: "RETURN DATE",
                                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            returnDateTextField.inputView = datePicker
            returnDateTextField.addToolbarButton(with: self,
                                                 selector: #selector(returnDateTapped),
                                                 title: "Done",
                                                 tintColor: .systemBlue)
        }
    }
    @IBOutlet weak var departureCabinClassLabel: UILabel!
    @IBOutlet weak var returnCabinClassLabel: UILabel!
    @IBOutlet weak var departureCabinClassView: UIView!{
        didSet{
            departureCabinClassView.isUserInteractionEnabled = true
            departureCabinClassView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(departureCabinClassTapped)))
            departureCabinClassView.backgroundColor = CustomColor.primaryColor
        }
    }
    @IBOutlet weak var returnCabinClassView: UIView!{
        didSet{
            returnCabinClassView.isUserInteractionEnabled = true
            returnCabinClassView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnCabinClassTapped)))
            returnCabinClassView.backgroundColor = CustomColor.primaryColor
        }
    }
    @IBOutlet weak var searchView: UIView!{
        didSet{
            searchView.isUserInteractionEnabled = true
            searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchFlightTapped)))
            searchView.backgroundColor = CustomColor.secondaryColor
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
    
    var sideMenutitleArray: NSArray = ["BOOK A FLIGHT", "MY BOOKING" ,"WEB CHECK-IN" ,"MANAGE BOOKING", "HOLIDAYS", "FLIGHT SCHEDULE", "SKY STAR", "SALES OFFICE", "CONTACT US"]
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
    
    var passengers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var cabinClasses = ["ECONOMY", "BUSINESS"]
    var ECONOMYClassCodes = [String()]
    var fromCities = [String]()
    var toCities = [String]()
    var currencyArray = [String]()
    var aiportDictionary = [String: String]()
    var aiportReverseDictionary = [String: String]()
    var airportModel: ValueCodeModel?
    var cityPairModel: CityPairModel?
    var currencyModel: ValueCodeModel?
    var bookingClassModel: ValueCodeModel?
    var searchData: FlightSearchModel?
    let datePicker = UIDatePicker()
    var departureDate = ""
    var returnDate = ""
    var returnFlights = [SaleCurrencyAmount]()
    var returnFlightDictionary = [String: SaleCurrencyAmount]()
    var businessFlights = [FlightInfo]()
    var economyFlights = [FlightInfo]()
    var economyDictionary = [String: FlightInfo]() // one way
    var businessDictionary = [String: FlightInfo]() // one way
    var selectedCurrency = "USD"
    var offerPlaceOriginCode = ""
    var offerPlaceDestinationCode = ""
    var fromCityCode = ""
    var toCityCode = ""
    var fromOffer = false
    var isLocalFlight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        returnCabinClassView.isHidden = true
        returnDateView.isHidden = true
        
        datePicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            shiftX = -850
            if UIWindow.isLandscape{
                shiftX = -1200
            }else{
                shiftX = -850
            }
        }
        sideBarSetup()
        
        fetchCityPair()
        fetchAirports()
        fetchCurrency()
        fetchBookingClass()
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
    
    func setupCheckBox(box: M13Checkbox){
        box.markType = .radio
        box.checkState = .unchecked
        box.stateChangeAnimation = .expand(.fill)
        box.boxType = .circle
        if #available(iOS 13.0, *) {
            box.tintColor = .systemIndigo
        } else {
            // Fallback on earlier versions
            box.tintColor = .systemBlue
        }
        box.backgroundColor = .clear
    }
    
    func laodOffer(){
        if fromOffer{
            fromCityLabel.text = aiportDictionary[offerPlaceOriginCode]
            toCityLabel.text = aiportDictionary[offerPlaceDestinationCode]
            fromCityCode = offerPlaceOriginCode
            toCityCode = offerPlaceDestinationCode
            returnOptionTapped()
            let forwardDate = Date().tomorrow
            let backwardDate = forwardDate.tomorrow
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            departureDate = formatter.string(from: forwardDate)
            returnDate = formatter.string(from: backwardDate)
            formatter.dateFormat = "EEE, dd MMM, YYYY"
            self.departureDateTextField.text = ""
            self.departureDateTextField.text = formatter.string(from: forwardDate)
            self.returnDateTextField.text = ""
            self.returnDateTextField.text = formatter.string(from: backwardDate)
        }
    }
    
    @objc func returnOptionTapped(){
        oneWayCheckbox.checkState = .unchecked
        returnCheckbox.setCheckState(.checked, animated: true)
        returnCabinClassView.isHidden = false
        returnDateView.isHidden = false
    }
    
    @objc func oneWayOptionTapped(){
        returnCheckbox.checkState = .unchecked
        oneWayCheckbox.setCheckState(.checked, animated: true)
        returnCabinClassView.isHidden = true
        returnDateView.isHidden = true
    }
    
    @objc func fromCityTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = fromCityView
        dropDown.dataSource = fromCities
        dropDown.textFont = UIFont.systemFont(ofSize: 15.0)
        dropDown.textColor = .systemGreen
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _self = self else{
                return
            }
            self?.fromCityLabel.text = item
            self?.fromCityCode = self?.aiportReverseDictionary[item] ?? ""
            guard let airportCodes = _self.airportModel?.codes, let cityPairCodes = _self.cityPairModel?.codes else{
                return
            }
            
            if index < airportCodes.count{
                _self.toCities.removeAll()
                let selectedCode = airportCodes[index].code
                for code in cityPairCodes{
                    if code.start == selectedCode{
                        _self.toCities.append(_self.aiportDictionary[code.end] ?? "")
                    }
                }
            }
        }
        dropDown.show()
    }
    
    @objc func toCityTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = toCityView
        dropDown.dataSource = toCities
        dropDown.textFont = UIFont.systemFont(ofSize: 15.0)
        dropDown.textColor = .systemGreen
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.toCityLabel.text = item
            self?.toCityCode = self?.aiportReverseDictionary[item] ?? ""
        }
        dropDown.show()
    }
    
    @objc func adultTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = adultView
        dropDown.dataSource = passengers
        dropDown.textFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        dropDown.textColor = .systemGreen
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.adultCountLabel.text = item
        }
        dropDown.show()
    }
    
    @objc func childTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = childView
        dropDown.dataSource = passengers
        dropDown.textFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        dropDown.textColor = .systemGreen
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.childCountLabel.text = item
        }
        dropDown.show()
    }
    
    @objc func infantTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = infantView
        dropDown.dataSource = passengers
        dropDown.textFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        dropDown.textColor = .systemGreen
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.infantCountLabel.text = item
        }
        dropDown.show()
    }
    
    @objc func currencyTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = currencyView
        dropDown.dataSource = currencyArray
        dropDown.textFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        dropDown.textColor = .systemGreen
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.currencyLabel.text = item
            self?.selectedCurrency = item
        }
        dropDown.show()
    }
    
    @objc func departureCabinClassTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = departureCabinClassView
        dropDown.dataSource = cabinClasses
        dropDown.textFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        dropDown.textColor = .systemGreen
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.departureCabinClassLabel.text = item
        }
        dropDown.show()
    }
    
    @objc func returnCabinClassTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = returnCabinClassView
        dropDown.dataSource = cabinClasses
        dropDown.textFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        dropDown.textColor = .systemGreen
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.returnCabinClassLabel.text = item
        }
        dropDown.show()
    }
    
    @objc func departureDateTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        departureDate = formatter.string(from: datePicker.date)
        formatter.dateFormat = "EEE, dd MMM, YYYY"
        self.departureDateTextField.text = ""
        self.departureDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func returnDateTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        returnDate = formatter.string(from: datePicker.date)
        formatter.dateFormat = "EEE, dd MMM, YYYY"
        self.returnDateTextField.text = ""
        self.returnDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func searchFlightTapped(){
        //        if let vc = UIStoryboard(name: "PassengerInfo", bundle: nil).instantiateViewController(withIdentifier: "InputPassengerInfoViewController") as? InputPassengerInfoViewController{
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
        if oneWayCheckbox.checkState == .checked{
            if validateOneWayFlight(){
                searchOneWayFlight()
            }
        }else{
            if validateReturnFlight(){
                searchReturnFlight()
            }
        }
    }
    
    func validateOneWayFlight() -> Bool{
        let fromCity = fromCityLabel.text ?? ""
        if fromCity.isEmpty{
            showAlert(title: "No departure selected.", message: nil, callback: nil)
            return false
        }
        let toCity = toCityLabel.text ?? ""
        if toCity.isEmpty{
            showAlert(title: "No destination selected.", message: nil, callback: nil)
            return false
        }
        let adultCount = adultCountLabel.text ?? "0"
        if adultCount == "0"{
            showAlert(title: "There must be at least one adult.", message: nil, callback: nil)
            return false
        }
        if departureDate.isEmpty{
            showAlert(title: "No departure date selected.", message: nil, callback: nil)
            return false
        }
        let departureCabinClass = self.departureCabinClassLabel.text ?? "CABIN CLASS"
        if departureCabinClass == "CABIN CLASS"{
            showAlert(title: "No departure cabin class selected.", message: nil, callback: nil)
            return false
        }
        return true
    }
    
    func validateReturnFlight() -> Bool{
        let fromCity = fromCityLabel.text ?? ""
        if fromCity.isEmpty{
            showAlert(title: "No departure selected.", message: nil, callback: nil)
            return false
        }
        let toCity = toCityLabel.text ?? ""
        if toCity.isEmpty{
            showAlert(title: "No destination selected.", message: nil, callback: nil)
            return false
        }
        let adultCount = adultCountLabel.text ?? "0"
        if adultCount == "0"{
            showAlert(title: "There must be at least one adult.", message: nil, callback: nil)
            return false
        }
        if departureDate.isEmpty{
            showAlert(title: "No departure date selected.", message: nil, callback: nil)
            return false
        }
        if returnDate.isEmpty{
            showAlert(title: "No return date selected.", message: nil, callback: nil)
            return false
        }
        let departureCabinClass = self.departureCabinClassLabel.text ?? "CABIN CLASS"
        if departureCabinClass == "CABIN CLASS"{
            showAlert(title: "No departure cabin class selected.", message: nil, callback: nil)
            return false
        }
        let returnCabinClass = self.returnCabinClassLabel.text ?? "CABIN CLASS"
        if returnCabinClass == "CABIN CLASS"{
            showAlert(title: "No return cabin class selected.", message: nil, callback: nil)
            return false
        }
        return true
    }
    
    @objc func notificationTapped(){
    }
    
    func toWebView(type: GivenOption){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomWebViewController") as? CustomWebViewController{
            vc.currentOption = type
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func skyStarTapped(){
        //        toWebView(type: .skyStarSignUp)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SkyStarViewController") as? SkyStarViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func hotlineTapped(){
        toWebView(type: .hotline)
    }
    
    @objc func manageBookingTapped(){
        //        toWebView(type: .manageBooking)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageBookingViewController") as? ManageBookingViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func holidayTapped(){
        toWebView(type: .holiday)
    }
    
    @objc func flightScheduleTapped(){
        toWebView(type: .flightSchedule)
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


extension FlightFilterViewController: UITableViewDelegate, UITableViewDataSource {
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
extension FlightFilterViewController{
    
    func fetchAirports() {
        
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
        
        let request: Parameters = [
            "RequestInfo": requestInfo,
            "ValueCodeName": "Airport"
        ]
        
        let params: Parameters = [
            "request": request
        ]
        
        guard let url = URL(string: "\(GlobalItems.getBaseUrl())/Zenith/TTI.PublicApi.Services/JsonSaleEngineService.svc/GetValueCodes") else{
            return
        }
        
        print("url: \(url) params \(params)")
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<ValueCodeModel>) in
            print("=== response = \(response)")
            guard let statusCode = response.response?.statusCode else{
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                self.airportModel = response.result.value
                guard let codes = self.airportModel?.codes else{
                    return
                }
                self.fromCities.removeAll()
                self.aiportDictionary.removeAll()
                GlobalItems.bdAirportCodes.removeAll()
                for airport in codes{
                    self.fromCities.append(airport.label ?? "")
                    if let key = airport.code, let val = airport.label{
                        self.aiportDictionary[key] = val
                        self.aiportReverseDictionary[val] = key
                    }
                    let countryCode = airport.valueCodeProperties?.last?.stringValue ?? ""
                    if countryCode == "BD"{
                        GlobalItems.bdAirportCodes.append(airport.code ?? "")
                    }
                }
                self.fromCities.sort()
                self.toCities = self.fromCities // initial case
                self.laodOffer()
            case .failure(let error):
                print("error = \(error)")
            }
        })
    }
    
    func fetchCityPair() {
        
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
        
        let request: Parameters = [
            "RequestInfo": requestInfo,
            "ValueCodeName": "CityPair"
        ]
        
        let params: Parameters = [
            "request": request
        ]
        
        guard let url = URL(string: "\(GlobalItems.getBaseUrl())/Zenith/TTI.PublicApi.Services/JsonSaleEngineService.svc/GetValueCodes") else{
            return
        }
        
        print("url: \(url) params \(params)")
        
        SVProgressHUD.show()
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<CityPairModel>) in
            print("=== response = \(response)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if SVProgressHUD.isVisible(){
                    SVProgressHUD.dismiss()
                }
            }
            guard let statusCode = response.response?.statusCode else{
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                self.cityPairModel = response.result.value
            case .failure(let error):
                print("error = \(error)")
            }
        })
    }
    
    func fetchBookingClass() {
        
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
        
        let request: Parameters = [
            "RequestInfo": requestInfo,
            "ValueCodeName": "BookingClass"
        ]
        
        let params: Parameters = [
            "request": request
        ]
        
        guard let url = URL(string: "\(GlobalItems.getBaseUrl())/Zenith/TTI.PublicApi.Services/JsonSaleEngineService.svc/GetValueCodes") else{
            return
        }
        
        print("url: \(url) params \(params)")
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<ValueCodeModel>) in
            print("=== response = \(response)")
            guard let statusCode = response.response?.statusCode else{
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                self.bookingClassModel = response.result.value
                guard let codes = self.bookingClassModel?.codes else{
                    return
                }
                GlobalItems.businessClassCodes.removeAll()
                self.ECONOMYClassCodes.removeAll()
                for code in codes{
                    if (code.label?.contains("Business") ?? false){
                        GlobalItems.businessClassCodes.append(code.code ?? "")
                    }else{
                        self.ECONOMYClassCodes.append(code.code ?? "")
                    }
                }
            case .failure(let error):
                print("error = \(error)")
            }
        })
    }
    
    
    func fetchCurrency() {
        
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
        
        let request: Parameters = [
            "RequestInfo": requestInfo,
            "ValueCodeName": "Currency"
        ]
        
        let params: Parameters = [
            "request": request
        ]
        
        guard let url = URL(string: "\(GlobalItems.getBaseUrl())/Zenith/TTI.PublicApi.Services/JsonSaleEngineService.svc/GetValueCodes") else{
            return
        }
        
        print("url: \(url) params \(params)")
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<ValueCodeModel>) in
            print("=== response = \(response)")
            guard let statusCode = response.response?.statusCode else{
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                self.currencyModel = response.result.value
                guard let codes = self.currencyModel?.codes else{
                    return
                }
                self.currencyArray.removeAll()
                for code in codes{
                    self.currencyArray.append(code.code ?? "")
                }
            case .failure(let error):
                print("error = \(error)")
            }
        })
    }
    
    func searchOneWayFlight() {
        
        let headers: HTTPHeaders = [
            "Accept-Encoding": "gzip"
        ]
        
        var passengers = [Parameters]()
        var child: Parameters?
        var adult: Parameters?
        var infant: Parameters?
        
        var count = Int(adultCountLabel.text ?? "0") ?? 0
        if count != 0 {
            adult = [
                "Ref": UUID().uuidString,
                "PassengerQuantity": count,
                "PassengerTypeCode": "AD"
            ]
        }
        if let value = adult{
            passengers.append(value)
        }
        
        count = Int(childCountLabel.text ?? "0") ?? 0
        if count != 0 {
            child = [
                "Ref": UUID().uuidString,
                "PassengerQuantity": count,
                "PassengerTypeCode": "CHD"
            ]
        }
        if let value = child{
            passengers.append(value)
        }
        
        count = Int(infantCountLabel.text ?? "0") ?? 0
        if count != 0 {
            infant = [
                "Ref": UUID().uuidString,
                "PassengerQuantity": count,
                "PassengerTypeCode": "INF"
            ]
        }
        if let value = infant{
            passengers.append(value)
        }
        
        var originDestinations = [Parameters]()
        let forwardFlight: Parameters = [
            "TargetDate": departureDate,
            "OriginCode": aiportReverseDictionary[fromCityLabel.text ?? ""] ?? "",
            "DestinationCode": aiportReverseDictionary[toCityLabel.text ?? ""] ?? ""
        ]
        originDestinations.append(forwardFlight)
        
        let fareDisplaySettings: Parameters = [
            "SaleCurrencyCode": currencyLabel.text ?? "",
            "FarebasisCodes": [],
            "WebClassesCodes": [],
            "ShowWebClasses": true,
            "PromoCode": promoCodeTextField.text ?? ""
        ]
        
        let availabilitySettings: Parameters = [
            "MaxConnectionCount": "8",
        ]
        
        //        let requestInfo: Parameters = [
        //            //            "AuthenticationKey": "_JEAAAAL436mpPsYP3m2lwfwBiLPdzcUQEHyecX5mtHR1RMK0DTHTEiyA_EYVUazFkn3rIGIGu6wxA8qa1gYyfs1uOib4E_U",
        //                        "AuthenticationKey": "_JEAAAABWU_EYtV0PDQ5AefVBXqTISe7_EqErTgeZryEzUyElkoBqCSdJh8UQdKZLhbSW62OVwi7Ix58ZnGrS9CBDxSnz7g_U",
        //                        "CultureName": "en-GB"
        //        ]
        let requestInfo: Parameters = [
            "AuthenticationKey": GlobalItems.getAuthKey(),
            "CultureName": "en-GB"
        ]
        
        let request: Parameters = [
            "Passengers": passengers,
            "OriginDestinations": originDestinations,
            "FareDisplaySettings": fareDisplaySettings,
            "AvailabilitySettings": availabilitySettings,
            "RequestInfo": requestInfo,
            "Extensions": []
        ]
        
        let params: Parameters = [
            "request": request
        ]
        
        guard let url = URL(string: "\(GlobalItems.getBaseUrl())/Zenith/TTI.PublicApi.Services/JsonSaleEngineService.svc/SearchFlights?DateFormatHandling=IsoDateFormat") else{
            return
        }
        
        print("url: \(url) params \(params)")
        //MARK: Reset
        GlobalItems.segmentRefInfoDictinary.removeAll()
        
        SVProgressHUD.show()
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseObject(completionHandler: { (response: DataResponse<FlightSearchModel>) in
            print("=== response = \(response)")
            //            if SVProgressHUD.isVisible(){
            //                SVProgressHUD.dismiss()
            //            }
            guard let statusCode = response.response?.statusCode else{
                if SVProgressHUD.isVisible(){
                    SVProgressHUD.dismiss()
                }
                self.showAlert(title: "No data found", message: nil, callback: nil)
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                self.searchData = response.result.value
                if self.searchData != nil{
                    self.businessFlights = [FlightInfo]()
                    self.economyFlights = [FlightInfo]()
                    self.economyDictionary = [String: FlightInfo]()
                    self.businessDictionary = [String: FlightInfo]()
                    let type = self.departureCabinClassLabel.text ?? ""
                    
                    //processing
                    guard let segments = self.searchData?.segments, let itineraries = self.searchData?.fareInfo?.itineraries else {
                        if SVProgressHUD.isVisible(){
                            SVProgressHUD.dismiss()
                        }
                        self.showAlert(title: "No data found", message: nil, callback: nil)
                        return
                    }
                    
                    for segment in segments{
                        for itinerary in itineraries{
                            let ref = itinerary.airOriginDestinations?.first?.airCoupons?.first?.refSegment ?? ""
                            if segment.ref == ref{
                                if let info = segment.flightInfo{
                                    info.saleCurrencyAmount = itinerary.saleCurrencyAmount
                                    info.segmentRef = ref
                                    info.itineraryRef = itinerary.ref ?? ""
                                    info.originCode = segment.originCode ?? ""
                                    info.destinationCode = segment.destinationCode ?? ""
                                    let isBusiness = itinerary.airOriginDestinations?.first?.airCoupons?.first?.isBusiness ?? false
                                    
                                    if type == "BUSINESS"{
                                        if isBusiness{
                                            //                                        self.businessFlights.append(info)
                                            if  self.businessDictionary.keys.contains(ref){
                                                let val = self.businessDictionary[ref]
                                                if ((info.saleCurrencyAmount?.totalAmount ?? 0) < (val?.saleCurrencyAmount?.totalAmount ?? 0)){
                                                    self.businessDictionary[ref] = info
                                                }else{
                                                    print("greater, no need to add")
                                                }
                                            }else{
                                                self.businessDictionary[ref] = info
                                            }
                                        }// no else. no need to add economy, only business
                                    }else{
                                        if isBusiness == false{
                                            //                                        self.economyFlights.append(info)
                                            if  self.economyDictionary.keys.contains(ref){
                                                let val = self.economyDictionary[ref]
                                                if ((info.saleCurrencyAmount?.totalAmount ?? 0) < (val?.saleCurrencyAmount?.totalAmount ?? 0)){
                                                    self.economyDictionary[ref] = info
                                                }else{
                                                    print("greater, no need to add")
                                                }
                                            }else{
                                                self.economyDictionary[ref] = info
                                            }
                                        }// no else. no need to add business, only economy
                                    }
                                }
                            }
                        }
                    }
                    
                    if SVProgressHUD.isVisible(){
                        SVProgressHUD.dismiss()
                    }
                    
                    if let vc = UIStoryboard(name: "FlightBooking", bundle: nil).instantiateViewController(withIdentifier: "OneWayFlightViewController") as? OneWayFlightViewController{
                        if type == "BUSINESS"{
                            //                            self.businessFlights = Array(self.businessDictionary.values)
                            vc.flights = Array(self.businessDictionary.values)
                        }else{
                            //                            self.economyFlights = Array(self.economyDictionary.values)
                            vc.flights = Array(self.economyDictionary.values)
                        }
                        vc.offer = self.searchData?.offer
                        vc.passengers = self.searchData?.passengers ?? [Passenger]()
                        vc.eTTicketFares = self.searchData?.fareInfo?.eTTicketFares ?? [ETTicketFare]()
                        vc.selectedCurrency = self.selectedCurrency
                        vc.fromCity = self.fromCityLabel.text ?? ""
                        vc.toCity = self.toCityLabel.text ?? ""
                        vc.fromCityCode = self.fromCityCode
                        vc.toCityCode = self.toCityCode
                        vc.departureDate = self.departureDateTextField.text ?? ""
                        vc.returnDate = self.returnDateTextField.text ?? ""
                        vc.flightClass = self.departureCabinClassLabel.text ?? ""
                        //                        vc.searchData = self.searchData
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                    if SVProgressHUD.isVisible(){
                        SVProgressHUD.dismiss()
                    }
                    self.showAlert(title: "No data found", message: nil, callback: nil)
                }
            case .failure(let error):
                if SVProgressHUD.isVisible(){
                    SVProgressHUD.dismiss()
                }
                self.showAlert(title: "Something went wrong! Status: \(statusCode)", message: nil, callback: nil)
                print("error = \(error)")
            }
        })
//        .responseJSON { (response) in
//            print("json = \(response.result.value)")
//        }
    }
    
    func searchReturnFlight() {
        
        let headers: HTTPHeaders = [
            "Accept-Encoding": "gzip"
        ]
        
        var passengers = [Parameters]()
        var child: Parameters?
        var adult: Parameters?
        var infant: Parameters?
        
        var count = Int(adultCountLabel.text ?? "0") ?? 0
        if count != 0 {
            adult = [
                "Ref": UUID().uuidString,
                "PassengerQuantity": count,
                "PassengerTypeCode": "AD"
            ]
        }
        if let value = adult{
            passengers.append(value)
        }
        
        count = Int(childCountLabel.text ?? "0") ?? 0
        if count != 0 {
            child = [
                "Ref": UUID().uuidString,
                "PassengerQuantity": count,
                "PassengerTypeCode": "CHD"
            ]
        }
        if let value = child{
            passengers.append(value)
        }
        
        count = Int(infantCountLabel.text ?? "0") ?? 0
        if count != 0 {
            infant = [
                "Ref": UUID().uuidString,
                "PassengerQuantity": count,
                "PassengerTypeCode": "INF"
            ]
        }
        if let value = infant{
            passengers.append(value)
        }
        
        var originDestinations = [Parameters]()
        let frowardFlight: Parameters = [
            "TargetDate": departureDate,
            "OriginCode": aiportReverseDictionary[fromCityLabel.text ?? ""] ?? "",
            "DestinationCode": aiportReverseDictionary[toCityLabel.text ?? ""] ?? ""
        ]
        let backwardFlight: Parameters = [
            "TargetDate": returnDate,
            "OriginCode": aiportReverseDictionary[toCityLabel.text ?? ""] ?? "",
            "DestinationCode": aiportReverseDictionary[fromCityLabel.text ?? ""] ?? ""
        ]
        originDestinations.append(frowardFlight)
        originDestinations.append(backwardFlight)
        
        let fareDisplaySettings: Parameters = [
            "SaleCurrencyCode": currencyLabel.text ?? "",
            "FarebasisCodes": [],
            "WebClassesCodes": [],
            "ShowWebClasses": true,
            "PromoCode": promoCodeTextField.text ?? ""
        ]
        
        let availabilitySettings: Parameters = [
            "MaxConnectionCount": "8",
        ]
        
        //        let requestInfo: Parameters = [
        //            //            "AuthenticationKey": "_JEAAAAL436mpPsYP3m2lwfwBiLPdzcUQEHyecX5mtHR1RMK0DTHTEiyA_EYVUazFkn3rIGIGu6wxA8qa1gYyfs1uOib4E_U",
        //                        "AuthenticationKey": "_JEAAAABWU_EYtV0PDQ5AefVBXqTISe7_EqErTgeZryEzUyElkoBqCSdJh8UQdKZLhbSW62OVwi7Ix58ZnGrS9CBDxSnz7g_U",
        //                        "CultureName": "en-GB"
        //        ]
        let requestInfo: Parameters = [
            "AuthenticationKey": GlobalItems.getAuthKey(),
            "CultureName": "en-GB"
        ]
        
        let request: Parameters = [
            "Passengers": passengers,
            "OriginDestinations": originDestinations,
            "FareDisplaySettings": fareDisplaySettings,
            "AvailabilitySettings": availabilitySettings,
            "RequestInfo": requestInfo,
            "Extensions": []
        ]
        
        let params: Parameters = [
            "request": request
        ]
        
        guard let url = URL(string: "\(GlobalItems.getBaseUrl())/Zenith/TTI.PublicApi.Services/JsonSaleEngineService.svc/SearchFlights?DateFormatHandling=IsoDateFormat") else{
            return
        }
        
        print("url: \(url) params \(params)")
        //MARK: Reset
        GlobalItems.segmentRefInfoDictinary.removeAll()
        
        SVProgressHUD.show()
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseObject(completionHandler: { (response: DataResponse<FlightSearchModel>) in
            print("=== response = \(response)")
            //            if SVProgressHUD.isVisible(){
            //                SVProgressHUD.dismiss()
            //            }
            guard let statusCode = response.response?.statusCode else{
                if SVProgressHUD.isVisible(){
                    SVProgressHUD.dismiss()
                }
                self.showAlert(title: "No data found", message: nil, callback: nil)
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                self.searchData = response.result.value
                if self.searchData != nil{
                    self.returnFlights = [SaleCurrencyAmount]()
                    self.returnFlightDictionary.removeAll()
                    //                    self.economyDictionary = [String: FlightInfo]()
                    //                    self.businessDictionary = [String: FlightInfo]()
                    let forwardType = self.departureCabinClassLabel.text ?? ""
                    let backwardType = self.returnCabinClassLabel.text ?? ""
                    
                    //processing
                    guard /*let segments = self.searchData?.segments, */let itineraries = self.searchData?.fareInfo?.itineraries else {
                        if SVProgressHUD.isVisible(){
                            SVProgressHUD.dismiss()
                        }
                        self.showAlert(title: "No data found", message: nil, callback: nil)
                        return
                    }
                    
                    for itinerary in itineraries{
                        let forwardSegRef = itinerary.airOriginDestinations?.first?.airCoupons?.first?.refSegment ?? ""
                        let backwardSegRef = itinerary.airOriginDestinations?.first?.airCoupons?.last?.refSegment ?? ""
                        
                        if let forwardFlightInfo = GlobalItems.segmentRefInfoDictinary[forwardSegRef], let backwardFlightInfo = GlobalItems.segmentRefInfoDictinary[backwardSegRef], let saleCurrencyAmount = itinerary.saleCurrencyAmount {
                            
                            saleCurrencyAmount.forwardflightInfo = forwardFlightInfo
                            saleCurrencyAmount.backwardflightInfo = backwardFlightInfo
                            saleCurrencyAmount.forwardSegmentRef = forwardSegRef
                            saleCurrencyAmount.backwardSegmentRef = backwardSegRef
                            saleCurrencyAmount.itineraryRef = itinerary.ref ?? ""
                            
                            let forwardIsBusiness = itinerary.airOriginDestinations?.first?.airCoupons?.first?.isBusiness ?? false
                            let backwardIsBusiness = itinerary.airOriginDestinations?.first?.airCoupons?.last?.isBusiness ?? false
                            
                            if forwardType == "BUSINESS" && backwardType == "BUSINESS"{
                                if forwardIsBusiness && backwardIsBusiness{
                                    self.returnFlights.append(saleCurrencyAmount)
                                }
                            }else if forwardType == "BUSINESS" && backwardType == "ECONOMY"{
                                if forwardIsBusiness && backwardIsBusiness == false{
                                    self.returnFlights.append(saleCurrencyAmount)
                                }
                            }else if forwardType == "ECONOMY" && backwardType == "BUSINESS"{
                                if forwardIsBusiness == false && backwardIsBusiness{
                                    self.returnFlights.append(saleCurrencyAmount)
                                }
                            }else if forwardType == "ECONOMY" && backwardType == "ECONOMY"{
                                if forwardIsBusiness == false && backwardIsBusiness == false{
                                    self.returnFlights.append(saleCurrencyAmount)
                                }
                            }
                        }
                    }
                    
                    for item in self.returnFlights{
                        let ref = "\(item.forwardSegmentRef)\(item.backwardSegmentRef)"
                        if  self.returnFlightDictionary.keys.contains(ref){
                            let val = self.returnFlightDictionary[ref]
                            if ((item.totalAmount ?? 0) < (val?.totalAmount ?? 0)){
                                self.returnFlightDictionary[ref] = item
                            }else{
                                print("greater, no need to add")
                            }
                        }else{
                            self.returnFlightDictionary[ref] = item
                        }
                    }
                    
                    if SVProgressHUD.isVisible(){
                        SVProgressHUD.dismiss()
                    }
                    
                    if let vc = UIStoryboard(name: "FlightBooking", bundle: nil).instantiateViewController(withIdentifier: "ReturnFlightViewController") as? ReturnFlightViewController{
                        vc.offer = self.searchData?.offer
                        vc.passengers = self.searchData?.passengers ?? [Passenger]()
                        vc.eTTicketFares = self.searchData?.fareInfo?.eTTicketFares ?? [ETTicketFare]()
                        vc.returnFlights = Array(self.returnFlightDictionary.values)
                        //                        vc.forwardCityCode =
                        //                            vc.backwardCityCode =
                        vc.selectedCurrency = self.selectedCurrency
                        vc.fromCity = self.fromCityLabel.text ?? ""
                        vc.toCity = self.toCityLabel.text ?? ""
                        vc.fromCityCode = self.fromCityCode
                        vc.toCityCode = self.toCityCode
                        vc.departureDate = self.departureDateTextField.text ?? ""
                        vc.returnDate = self.returnDateTextField.text ?? ""
                        vc.forwardFlightClass = self.departureCabinClassLabel.text ?? ""
                        vc.backwardFlightClass = self.returnCabinClassLabel.text ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                    if SVProgressHUD.isVisible(){
                        SVProgressHUD.dismiss()
                    }
                    self.showAlert(title: "No data found", message: nil, callback: nil)
                }
            case .failure(let error):
                if SVProgressHUD.isVisible(){
                    SVProgressHUD.dismiss()
                }
                self.showAlert(title: "Something went wrong! Status: \(statusCode)", message: nil, callback: nil)
                print("error = \(error)")
            }
        })
    }
}
