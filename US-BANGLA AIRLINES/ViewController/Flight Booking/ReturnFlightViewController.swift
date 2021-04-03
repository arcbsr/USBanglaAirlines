//
//  ReturnFlightViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 28/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit



class ReturnFlightViewController: UIViewController {
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
    var searchData: FlightSearchModel?
    var fromCityCode = ""
    var toCityCode = ""
    var selectedCurrency = ""
    var fromCity = ""
    var toCity = ""
    var departureDate = ""
    var returnDate = ""
    var returnFlights = [SaleCurrencyAmount]()
    var eTTicketFares = [ETTicketFare]()
    var passengers = [Passenger]()
    var offer: Offer?
    var forwardFlightClass = ""
    var backwardFlightClass = ""
    
    
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
    
    func moveToNextVC(row: Int, fromTime: String, toTime: String){
        if let vc = UIStoryboard(name: "FlightBookingPart2", bundle: nil).instantiateViewController(withIdentifier: "FlightSummaryViewController") as? FlightSummaryViewController{
            //                vc.searchData = self.searchData
            vc.returnFlight = returnFlights[row]
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
            return returnFlights.count
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
            if returnFlights[indexPath.row].isExpand{
                // expanded cell
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReturnFlightExpandedCell.self)) as! ReturnFlightExpandedCell
                cell.selectionStyle = .none
                
                cell.forwardDurationLabel.text = "\(returnFlights[indexPath.row].forwardflightInfo?.durationMinutes ?? 0) MIN"
                cell.backwardDurationLabel.text = "\(returnFlights[indexPath.row].backwardflightInfo?.durationMinutes ?? 0) MIN"
                cell.rankingLabel.text = "\(indexPath.row + 1)"
                
                //                cell.priceLabel.text = " \(selectedCurrency) \(returnFlights[indexPath.row].totalAmount ?? 0) "
                let discount = returnFlights[indexPath.row].discountAmount ?? 0
                let totalWithoutDiscount = returnFlights[indexPath.row].totalAmount ?? 0
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
                
                cell.forwardfromLocationLabel.text = returnFlights[indexPath.row].forwardflightInfo?.originCode ?? ""
                cell.forwardtoLocationLabel.text = returnFlights[indexPath.row].forwardflightInfo?.destinationCode ?? ""
                cell.backwardfromLocationLabel.text = returnFlights[indexPath.row].backwardflightInfo?.originCode ?? ""
                cell.backwardtoLocationLabel.text = returnFlights[indexPath.row].backwardflightInfo?.destinationCode ?? ""
                cell.forwardFlightDetailsLabel.text = "FLIGHT: \(returnFlights[indexPath.row].forwardflightInfo?.operatingAirlineDesignator ?? "") \(returnFlights[indexPath.row].forwardflightInfo?.operatingFlightNumber ?? "")\n\(returnFlights[indexPath.row].forwardflightInfo?.equipmentText ?? "")"
                cell.backwardFlightDetailsLabel.text = "FLIGHT: \(returnFlights[indexPath.row].backwardflightInfo?.operatingAirlineDesignator ?? "") \(returnFlights[indexPath.row].backwardflightInfo?.operatingFlightNumber ?? "")\n\(returnFlights[indexPath.row].backwardflightInfo?.equipmentText ?? "")"
                
                let startDate = returnFlights[indexPath.row].forwardflightInfo?.departureDate ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
                if let date = dateFormatter.date(from: startDate) {
                    cell.forwardfromTimeLabel.text = "\(date.hour):\(date.minute)"
                }
                
                let endDate =  returnFlights[indexPath.row].forwardflightInfo?.arrivalDate ?? ""
                if let date = dateFormatter.date(from: endDate) {
                    cell.forwardtoTimeLabel.text = "\(date.hour):\(date.minute)"
                }
                
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
                if let date = dateFormatter.date(from: returnFlights[indexPath.row].backwardflightInfo?.departureDate ?? "") {
                    cell.backwardfromTimeLabel.text = "\(date.hour):\(date.minute)"
                }
                
                if let date = dateFormatter.date(from: returnFlights[indexPath.row].backwardflightInfo?.arrivalDate ?? "") {
                    cell.backwardtoTimeLabel.text = "\(date.hour):\(date.minute)"
                }
                
                cell.upArrowTapped = {
                    // set false in ietm related to datasource row and reload current row
                    self.returnFlights[indexPath.row].isExpand = false
                    self.tableView.reloadData()
                }
                
                cell.selectTapped = {
                    self.moveToNextVC(row: indexPath.row, fromTime: cell.forwardtoTimeLabel.text ?? "", toTime: cell.backwardtoTimeLabel.text ?? "")
                }
                
                return cell
            }
            
            // not expanded cell
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReturnFlightCell.self)) as! ReturnFlightCell
            cell.selectionStyle = .none
            
            cell.rankingLabel.text = "\(indexPath.row + 1)"
            
            let discount = returnFlights[indexPath.row].discountAmount ?? 0
            let totalWithoutDiscount = returnFlights[indexPath.row].totalAmount ?? 0
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
            
            cell.forwardfromLocationLabel.text = returnFlights[indexPath.row].forwardflightInfo?.originCode ?? ""
            cell.forwardtoLocationLabel.text = returnFlights[indexPath.row].forwardflightInfo?.destinationCode ?? ""
            
            let startDate = returnFlights[indexPath.row].forwardflightInfo?.departureDate ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2021-02-27T11:25:00
            if let date = dateFormatter.date(from: startDate) {
                cell.forwardfromTimeLabel.text = "\(date.hour):\(date.minute)"
            }
            
            let endDate =  returnFlights[indexPath.row].forwardflightInfo?.arrivalDate ?? ""
            if let date = dateFormatter.date(from: endDate) {
                cell.forwardtoTimeLabel.text = "\(date.hour):\(date.minute)"
            }
            
            cell.downArrowTapped = {
                // set true in ietm related to datasource row and relaod current row
                self.returnFlights[indexPath.row].isExpand = true
                self.tableView.reloadData()
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
                moveToNextVC(row: indexPath.row, fromTime: cell.forwardtoTimeLabel.text ?? "", toTime: cell.forwardtoTimeLabel.text ?? "")
            }else if let cell = tableView.cellForRow(at: indexPath) as? ReturnFlightExpandedCell{
                moveToNextVC(row: indexPath.row, fromTime: cell.forwardtoTimeLabel.text ?? "", toTime: cell.forwardtoTimeLabel.text ?? "")
            }
        }
    }
    
}
