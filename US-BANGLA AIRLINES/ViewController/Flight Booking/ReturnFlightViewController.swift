//
//  ReturnFlightViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 28/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit
import DropDown
import SVProgressHUD

class ReturnFlightViewController: UIViewController {
    @IBOutlet weak var downImageView: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                downImageView.image = UIImage(named: "down-arrow")
            }
        }
    }
    @IBOutlet weak var downImageView2: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                downImageView2.image = UIImage(named: "down-arrow")
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            //            tableView.separatorStyle = .none
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
            let footerView = UIView()
            footerView.frame.size.height = 16
            footerView.backgroundColor = .clear
            tableView.tableFooterView = footerView
        }
    }
    @IBOutlet weak var directionImageView: UIImageView!
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var toCityLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    
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
    
    @IBOutlet weak var departureShiftLabel: UILabel!
    @IBOutlet weak var returnShiftLabel: UILabel!
    @IBOutlet weak var departureShiftView: UIView!{
        didSet{
            departureShiftView.isUserInteractionEnabled = true
            departureShiftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(departureShiftTapped)))
        }
    }
    @IBOutlet weak var returnShiftView: UIView!{
        didSet{
            returnShiftView.isUserInteractionEnabled = true
            returnShiftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnShiftTapped)))
        }
    }
    
    
    var visualEffectView: UIVisualEffectView!
    var sideBarView: UIView!
    var sideBarTableView: UITableView!
    var cataTopLbl = UILabel()
    var logoImgView: UIImageView?
    // for iPhone
    var shiftX: CGFloat = -400
    var shiftType = ["ALL FLIGHTS", "MORNING", "AFTERNOON", "EVENING"]
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
    var searchData: FlightSearchModel?
    var fromCityCode = ""
    var toCityCode = ""
    var selectedCurrency = ""
    var fromCity = ""
    var toCity = ""
    var departureDate = ""
    var returnDate = ""
    var returnFlights = [SaleCurrencyAmount]()
    var filteredFlights = [SaleCurrencyAmount]()
    var eTTicketFares = [ETTicketFare]()
    var passengers = [Passenger]()
    var offer: Offer?
    var forwardFlightClass = ""
    var backwardFlightClass = ""
    var processedForwardFlights = [SaleCurrencyAmount]()
    var processedBackwardFlights = [SaleCurrencyAmount]()
    var forwardIndex = 0
    var backwardIndex = 0
    
    
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
        
        fromCityLabel.text = fromCity
        toCityLabel.text = toCity
        fromDateLabel.text = departureDate
        toDateLabel.text = returnDate
        
        filteredFlights = returnFlights
        tableView.reloadData()
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
    
    @objc func departureShiftTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = departureShiftView
        dropDown.dataSource = shiftType
        dropDown.backgroundColor = CustomColor.primaryColor
        dropDown.textColor = .white
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.departureShiftLabel.text = item
            self?.forwardIndex = index
            self?.forwardProcessing(index: index, willCallBackward: true)
        }
        dropDown.show()
    }
    
    func forwardProcessing(index: Int, willCallBackward: Bool){
        switch index {
        case 0:
            //                self.filteredFlights = self.returnFlights
            //            backwardProcessing(index: backwardIndex, isUserFilteredData: false)
            //            if forwardIndex == backwardIndex{
            //                filteredFlights = returnFlights
            //                self.tableView.reloadData()
            //            }
            if willCallBackward{
                backwardProcessing(index: backwardIndex, willCallForward: false)
                tableView.reloadData()
            }else{
                filteredFlights = returnFlights
                self.tableView.reloadData()
            }
        case 1:
            // 12:01 AM - 11:59 AM
            if willCallBackward{
                backwardProcessing(index: backwardIndex, willCallForward: false)
                self.filterByShift(start: 0, end: 11, isForward: true, zeroMinHour: nil, iteratableFlights: filteredFlights)
                tableView.reloadData()
            }else{
                self.filterByShift(start: 0, end: 11, isForward: true, zeroMinHour: nil, iteratableFlights: returnFlights)
                tableView.reloadData()
            }
        case 2:
            // DAY 12pm-6pm 12:00 PM - 06:00 PM
            if willCallBackward{
                backwardProcessing(index: backwardIndex, willCallForward: false)
                self.filterByShift(start: 12, end: 17, isForward: true, zeroMinHour: 18, iteratableFlights: filteredFlights)
                tableView.reloadData()
            }else{
                self.filterByShift(start: 12, end: 17, isForward: true, zeroMinHour: 18, iteratableFlights: returnFlights)
                tableView.reloadData()
            }
        case 3:
            //                // EVENING 6pm-3am
            //                self?.filterByShift(start: 18, end: 24, offset: 3)
            // EVENING 06:01 PM - 12:00 PM
            if willCallBackward{
                backwardProcessing(index: backwardIndex, willCallForward: false)
                self.filterByShift(start: 18, end: 23, isForward: true, offset: 0, zeroMinHour: 0, iteratableFlights: filteredFlights)
                tableView.reloadData()
            }else{
                self.filterByShift(start: 18, end: 23, isForward: true, offset: 0, zeroMinHour: 0, iteratableFlights: returnFlights)
                tableView.reloadData()
            }
        default:
            break
        }
    }
    
    @objc func returnShiftTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = returnShiftView
        dropDown.dataSource = shiftType
        dropDown.backgroundColor = CustomColor.primaryColor
        dropDown.textColor = .white
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.returnShiftLabel.text = item
            self?.backwardIndex = index
            self?.backwardProcessing(index: index, willCallForward: true)
        }
        dropDown.show()
    }
    
    func backwardProcessing(index: Int, willCallForward: Bool){
        switch index {
        case 0:
            //                self.filteredFlights = self.returnFlights
            //            forwardProcessing(index: forwardIndex, isUserFilteredData: <#Bool#>)
            //            if forwardIndex == backwardIndex{
            //                filteredFlights = returnFlights
            //                self.tableView.reloadData()
            //            }
            if willCallForward{
                forwardProcessing(index: forwardIndex, willCallBackward: false)
                self.tableView.reloadData()
            }else{
                filteredFlights = returnFlights
                self.tableView.reloadData()
            }
        case 1:
            // 12:01 AM - 11:59 AM
            if willCallForward{
                forwardProcessing(index: forwardIndex, willCallBackward: false)
                self.filterByShift(start: 0, end: 11, isForward: false, zeroMinHour: nil, iteratableFlights: filteredFlights)
                tableView.reloadData()
            }else{
                self.filterByShift(start: 0, end: 11, isForward: false, zeroMinHour: nil, iteratableFlights: returnFlights)
                tableView.reloadData()
            }
        case 2:
            // DAY 12pm-6pm 12:00 PM - 06:00 PM
            if willCallForward{
                forwardProcessing(index: forwardIndex, willCallBackward: false)
                self.filterByShift(start: 12, end: 17, isForward: false, zeroMinHour: 18, iteratableFlights: filteredFlights)
                tableView.reloadData()
            }else{
                self.filterByShift(start: 12, end: 17, isForward: false, zeroMinHour: 18, iteratableFlights: returnFlights)
                tableView.reloadData()
            }
        case 3:
            //                // EVENING 6pm-3am
            //                self?.filterByShift(start: 18, end: 24, offset: 3)
            //EVENING 06:01 PM - 12:00 PM
            if willCallForward{
                forwardProcessing(index: forwardIndex, willCallBackward: false)
                self.filterByShift(start: 18, end: 23, isForward: false, offset: 0, zeroMinHour: 0, iteratableFlights: filteredFlights)
                tableView.reloadData()
            }else{
                self.filterByShift(start: 18, end: 23, isForward: false, offset: 0, zeroMinHour: 0, iteratableFlights: returnFlights)
                tableView.reloadData()
            }
        default:
            break
        }
    }
    
    func filterByShift(start: Int, end: Int, isForward: Bool, offset: Int = 0, zeroMinHour: Int?, iteratableFlights: [SaleCurrencyAmount]){
        //        SVProgressHUD.show()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
        //        var processedForwardFlights = [SaleCurrencyAmount]()
        //        var processedBackwardFlights = [SaleCurrencyAmount]()
        //        var iteratableFlights = [SaleCurrencyAmount]()
        
        //        if backwardFilterAll == false && isForward == true{
        //            if backwardFilterAll{
        //                iteratableFlights = returnFlights
        //            }else{
        //                iteratableFlights = processedBackwardFlights
        //            }
        //        }else if backwardFilterAll == false && isForward == false{
        //            if forwardFilterAll{
        //                iteratableFlights = returnFlights
        //            }else{
        //                iteratableFlights = processedForwardFlights
        //            }
        //        }else{
        //            iteratableFlights = returnFlights
        //        }
        
        if isForward{
            processedForwardFlights.removeAll()
        }else{
            processedBackwardFlights.removeAll()
        }
        
        //        for flight in returnFlights{
        for flight in iteratableFlights{
            if isForward{
                let startDate = flight.forwardflightInfo?.departureDate ?? ""
                if let date = dateFormatter.date(from: startDate) {
                    //                cell.forwardfromTimeLabel.text = "\(date.hour):\(date.minute)"
                    if let zeroMinHr = zeroMinHour{
                        let zeroMin = 0
                        if zeroMinHr == date.hour && zeroMin == date.minute{
                            processedForwardFlights.append(flight)
                            continue
                        }
                    }
                    if date.hour >= start && date.hour <= end{
                        processedForwardFlights.append(flight)
                    }else if offset > 0{
                        if date.hour >= 1 && date.hour <= offset{
                            processedForwardFlights.append(flight)
                        }
                    }
                }
            }else{
                let endDate =  flight.backwardflightInfo?.departureDate ?? ""
                if let date = dateFormatter.date(from: endDate) {
                    //                cell.forwardtoTimeLabel.text = "\(date.hour):\(date.minute)"
                    if let zeroMinHr = zeroMinHour{
                        let zeroMin = 0
                        if zeroMinHr == date.hour && zeroMin == date.minute{
                            processedBackwardFlights.append(flight)
                            continue
                        }
                    }
                    if date.hour >= start && date.hour <= end{
                        processedBackwardFlights.append(flight)
                    }else if offset > 0{
                        if date.hour >= 1 && date.hour <= offset{
                            processedBackwardFlights.append(flight)
                        }
                    }
                }
            }
        }
        if isForward{
            filteredFlights = processedForwardFlights
        }else{
            filteredFlights = processedBackwardFlights
        }
        //        filteredFlights = processedFlights
        //        tableView.reloadData()
        //        SVProgressHUD.dismiss()
    }
    
    func moveToNextVC(row: Int, fromTime: String, toTime: String){
        if let vc = UIStoryboard(name: "FlightBookingPart2", bundle: nil).instantiateViewController(withIdentifier: "FlightSummaryViewController") as? FlightSummaryViewController{
            //                vc.searchData = self.searchData
            vc.returnFlight = filteredFlights[row]
            vc.eTTicketFares = eTTicketFares
            vc.passengers = passengers
            vc.offer = self.offer
            vc.fromCity = fromCityLabel.text ?? ""
            vc.toCity = toCityLabel.text ?? ""
            vc.fromCityCode = self.fromCityCode
            vc.toCityCode = self.toCityCode
            vc.forwardFlightClass = forwardFlightClass
            vc.backwardFlightClass = backwardFlightClass
            vc.selectedCurrency = selectedCurrency
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //        if let vc = UIStoryboard(name: "FlightBookingPart2", bundle: nil).instantiateViewController(withIdentifier: "BookingConfirmationViewController") as? BookingConfirmationViewController{
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
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


extension ReturnFlightViewController: UITableViewDelegate, UITableViewDataSource {
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
            return filteredFlights.count
            //            return 6
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
            if filteredFlights[indexPath.row].isExpand{
                // expanded cell
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReturnFlightExpandedCell.self)) as! ReturnFlightExpandedCell
                cell.selectionStyle = .none
                
                cell.forwardDurationLabel.text = "\(filteredFlights[indexPath.row].forwardflightInfo?.durationMinutes ?? 0) MIN"
                cell.backwardDurationLabel.text = "\(filteredFlights[indexPath.row].backwardflightInfo?.durationMinutes ?? 0) MIN"
                cell.rankingLabel.text = "\(indexPath.row + 1)"
                
                //                cell.priceLabel.text = " \(selectedCurrency) \(filteredFlights[indexPath.row].totalAmount ?? 0) "
                let discount = filteredFlights[indexPath.row].discountAmount ?? 0
                let totalWithoutDiscount = filteredFlights[indexPath.row].totalAmount ?? 0
                let total = totalWithoutDiscount - discount
                if discount > 0{
                    let attributedString = NSAttributedString(string: " \(selectedCurrency) \(totalWithoutDiscount) ", attributes:
                                                                [.strikethroughStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.strikethroughColor: UIColor.red])
                    cell.priceLabel.attributedText = attributedString
                    cell.totalPriceLabel.text = "\(selectedCurrency) \(total) "
                    cell.totalPriceLabel.isHidden = false
                }else{
                    cell.priceLabel.text = " \(selectedCurrency) \(totalWithoutDiscount) "
                    cell.totalPriceLabel.isHidden = true
                }
                
                cell.forwardfromLocationLabel.text = fromCityCode //filteredFlights[indexPath.row].forwardflightInfo?.originCode ?? ""
                cell.forwardtoLocationLabel.text = toCityCode //filteredFlights[indexPath.row].forwardflightInfo?.destinationCode ?? ""
                cell.backwardfromLocationLabel.text = toCityCode //filteredFlights[indexPath.row].backwardflightInfo?.originCode ?? ""
                cell.backwardtoLocationLabel.text = fromCityCode //filteredFlights[indexPath.row].backwardflightInfo?.destinationCode ?? ""
                
                cell.forwardFlightDetailsLabel.text = "FLIGHT: \(filteredFlights[indexPath.row].forwardflightInfo?.operatingAirlineDesignator ?? "") \(filteredFlights[indexPath.row].forwardflightInfo?.operatingFlightNumber ?? "")\n\(filteredFlights[indexPath.row].forwardflightInfo?.equipmentText ?? "")"
                cell.backwardFlightDetailsLabel.text = "FLIGHT: \(filteredFlights[indexPath.row].backwardflightInfo?.operatingAirlineDesignator ?? "") \(filteredFlights[indexPath.row].backwardflightInfo?.operatingFlightNumber ?? "")\n\(filteredFlights[indexPath.row].backwardflightInfo?.equipmentText ?? "")"
                
                let startDate = filteredFlights[indexPath.row].forwardflightInfo?.departureDate ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
                if let date = dateFormatter.date(from: startDate) {
                    cell.forwardfromTimeLabel.text = "\(date.hour):\(date.minute)"
                }
                
                let endDate =  filteredFlights[indexPath.row].forwardflightInfo?.arrivalDate ?? ""
                if let date = dateFormatter.date(from: endDate) {
                    cell.forwardtoTimeLabel.text = "\(date.hour):\(date.minute)"
                }
                
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
                if let date = dateFormatter.date(from: filteredFlights[indexPath.row].backwardflightInfo?.departureDate ?? "") {
                    cell.backwardfromTimeLabel.text = "\(date.hour):\(date.minute)"
                }
                
                if let date = dateFormatter.date(from: filteredFlights[indexPath.row].backwardflightInfo?.arrivalDate ?? "") {
                    cell.backwardtoTimeLabel.text = "\(date.hour):\(date.minute)"
                }
                
                cell.upArrowTapped = {
                    // set false in ietm related to datasource row and reload current row
                    self.filteredFlights[indexPath.row].isExpand = false
                    self.tableView.reloadData()
                }
                
                cell.selectTapped = {
                    self.moveToNextVC(row: indexPath.row, fromTime: cell.forwardfromTimeLabel.text ?? "", toTime: cell.backwardtoTimeLabel.text ?? "")
                }
                
                return cell
            }
            
            // not expanded cell
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReturnFlightCell.self)) as! ReturnFlightCell
            cell.selectionStyle = .none
            
            cell.rankingLabel.text = "\(indexPath.row + 1)"
            
            let discount = filteredFlights[indexPath.row].discountAmount ?? 0
            let totalWithoutDiscount = filteredFlights[indexPath.row].totalAmount ?? 0
            let total = totalWithoutDiscount - discount
            if discount > 0{
                let attributedString = NSAttributedString(string: " \(selectedCurrency) \(totalWithoutDiscount) ", attributes:
                                                            [.strikethroughStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.strikethroughColor: UIColor.red])
                cell.priceLabel.attributedText = attributedString
                cell.totalPriceLabel.text = "\(selectedCurrency) \(total)"
                cell.totalPriceLabel.isHidden = false
            }else{
                cell.priceLabel.text = " \(selectedCurrency) \(totalWithoutDiscount) "
                cell.totalPriceLabel.isHidden = true
            }
            
            cell.forwardfromLocationLabel.text = fromCityCode //filteredFlights[indexPath.row].forwardflightInfo?.originCode ?? ""
            cell.forwardtoLocationLabel.text = toCityCode //filteredFlights[indexPath.row].forwardflightInfo?.destinationCode ?? ""
            
            let startDate = filteredFlights[indexPath.row].forwardflightInfo?.departureDate ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
            if let date = dateFormatter.date(from: startDate) {
                cell.forwardfromTimeLabel.text = "\(date.hour):\(date.minute)"
            }
            
            let endDate =  filteredFlights[indexPath.row].forwardflightInfo?.arrivalDate ?? ""
            if let date = dateFormatter.date(from: endDate) {
                cell.forwardtoTimeLabel.text = "\(date.hour):\(date.minute)"
            }
            
            cell.downArrowTapped = {
                // set true in ietm related to datasource row and relaod current row
                self.filteredFlights[indexPath.row].isExpand = true
                self.tableView.reloadData()
            }
            
            cell.selectTapped = {
                self.moveToNextVC(row: indexPath.row, fromTime: cell.forwardfromTimeLabel.text ?? "", toTime: cell.forwardtoTimeLabel.text ?? "")
            }
            
            return cell
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
            if let cell = tableView.cellForRow(at: indexPath) as? ReturnFlightCell{
                moveToNextVC(row: indexPath.row, fromTime: cell.forwardfromTimeLabel.text ?? "", toTime: cell.forwardtoTimeLabel.text ?? "")
            }else if let cell = tableView.cellForRow(at: indexPath) as? ReturnFlightExpandedCell{
                moveToNextVC(row: indexPath.row, fromTime: cell.forwardfromTimeLabel.text ?? "", toTime: cell.backwardtoTimeLabel.text ?? "")
            }
        }
    }
    
}
