//
//  HomeViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 25/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import AlamofireObjectMapper
import Kingfisher

class HomeViewController: UIViewController {
    @IBOutlet weak var offerCollectionView: UICollectionView!{
        didSet{
            offerCollectionView.dataSource = self
            offerCollectionView.delegate = self
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
    @IBOutlet weak var flightBookingView: UIView!{
        didSet{
            flightBookingView.isUserInteractionEnabled = true
            flightBookingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flightBookingTapped)))
        }
    }
    @IBOutlet weak var skyStarView: UIView!{
        didSet{
            skyStarView.isUserInteractionEnabled = true
            skyStarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skyStarTapped)))
        }
    }
    @IBOutlet weak var hotlineView: UIView!{
        didSet{
            hotlineView.isUserInteractionEnabled = true
            hotlineView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hotlineTapped)))
        }
    }
    @IBOutlet weak var manageBookingView: UIView!{
        didSet{
            manageBookingView.isUserInteractionEnabled = true
            manageBookingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(manageBookingTapped)))
        }
    }
    @IBOutlet weak var holidayView: UIView!{
        didSet{
            holidayView.isUserInteractionEnabled = true
            holidayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(holidayTapped)))
        }
    }
    @IBOutlet weak var flightScheduleView: UIView!{
        didSet{
            flightScheduleView.isUserInteractionEnabled = true
            flightScheduleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flightScheduleTapped)))
        }
    }
    var visualEffectView: UIVisualEffectView!
    var sideBarView: UIView!
    var sideBarTableView: UITableView!
    var cataTopLbl = UILabel()
    var logoImgView: UIImageView?
    // for iPhone
    var shiftX: CGFloat = -400
    
    var sideMenutitleArray:NSArray = ["BOOK A FLIGHT", "MANAGE BOOKING", "HOLIDAYS", "FLIGHT SCHEDULE", "SKY STAR", "CONTACT US"]
    var sideMenuImgArray = [UIImage(named: "warning")!, UIImage(named: "warning")!, UIImage(named: "warning"), UIImage(named: "warning")!, UIImage(named: "warning")!, UIImage(named: "warning")!]
    
    var offerplaces = [Offerplace]()
    
    
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
        setUpCollectionView()
        sideBarSetup()
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
        
        fetchOfferPlaces()
    }
    
    func setUpCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        offerCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        offerCollectionView.showsHorizontalScrollIndicator = false
        offerCollectionView.showsVerticalScrollIndicator = false
        offerCollectionView.isScrollEnabled = true
        offerCollectionView.isPagingEnabled = true
    }
    
    @objc func flightBookingTapped(){
        if let vc = UIStoryboard(name: "FlightBooking", bundle: nil).instantiateViewController(withIdentifier: "FlightFilterViewController") as? FlightFilterViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func skyStarTapped(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomWebViewController") as? CustomWebViewController{
            vc.currentOption = .skyStar
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func hotlineTapped(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomWebViewController") as? CustomWebViewController{
            vc.currentOption = .hotline
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func manageBookingTapped(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomWebViewController") as? CustomWebViewController{
            vc.currentOption = .manageBooking
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func holidayTapped(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomWebViewController") as? CustomWebViewController{
            vc.currentOption = .holiday
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func flightScheduleTapped(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomWebViewController") as? CustomWebViewController{
            vc.currentOption = .flightSchedule
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func notificationTapped(){
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
        logoImgView?.image = UIImage(named: "bs_logo_wrgb")
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
        footerView.frame.size.height = 16
        footerView.backgroundColor = .clear
        sideBarTableView.tableFooterView = footerView
        sideBarTableView.dataSource = self
        sideBarTableView.delegate = self
        sideBarTableView.showsVerticalScrollIndicator = false
        sideBarTableView.alwaysBounceVertical = false
        sideBarTableView.isScrollEnabled = false
        sideBarTableView.register(UINib.init(nibName: "SideBarTableViewCell", bundle: nil), forCellReuseIdentifier: "SideBarTableViewCell")
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
        case 0:
            flightBookingTapped()
        case 1:
            manageBookingTapped()
        case 2:
            holidayTapped()
        case 3:
            flightScheduleTapped()
        case 4:
            skyStarTapped()
        case 5:
            hotlineTapped()
        default:
            break
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerplaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferPlaceCollectionViewCell", for: indexPath) as! OfferPlaceCollectionViewCell
        
        let placeholderImage = UIImage(named: "placeholder")
        if let urlStr = offerplaces[indexPath.row].image{
            cell.offerImageView.kf.setImage(with: URL(string: urlStr), placeholder: placeholderImage)
        }else{
            cell.offerImageView.image = placeholderImage
        }
        
        cell.crossTapped = {
            self.offerCollectionView.isHidden = true
        }
        
        cell.leftTapped = {
            if indexPath.row == 0{
                return
            }
            let prevRow = indexPath.row - 1
            collectionView.scrollToItem(at: IndexPath(row: prevRow, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        cell.rightTapped = {
            if indexPath.row == self.offerplaces.count - 1{
                return
            }
            let nextRow = indexPath.row + 1
            collectionView.scrollToItem(at: IndexPath(row: nextRow, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "FlightBooking", bundle: nil).instantiateViewController(withIdentifier: "FlightFilterViewController") as? FlightFilterViewController{
            vc.offerPlaceOriginCode = offerplaces[indexPath.row].originCode ?? ""
            vc.offerPlaceDestinationCode = offerplaces[indexPath.row].destinationCode ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = collectionView.bounds.height
        
        return CGSize(width: width  , height: height)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //       return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    //    }
    
}


// MARK: API CALL
extension HomeViewController{
    
    func fetchOfferPlaces() {
        
        //            let headers: HTTPHeaders = [
        //                "Authorization": "token \(UserInfo.token)"
        //            ]
        
        //        let requestInfo: Parameters = [
        //            "AuthenticationKey": "_JEAAAAL436mpPsYP3m2lwfwBiLPdzcUQEHyecX5mtHR1RMK0DTHTEiyA_EYVUazFkn3rIGIGu6wxA8qa1gYyfs1uOib4E_U",
        //            "CultureName": "en-GB"
        //        ]
        //
        //        let request: Parameters = [
        //            "RequestInfo": requestInfo,
        //            "ValueCodeName": "Airport"
        //        ]
        //
        //        let params: Parameters = [
        //            "request": request
        //        ]
        
        guard let url = URL(string: "https://usbair.com/app2/LoadHomePageSpecialOfferImage.json") else{
            return
        }
        
        print("send user Activity url:\(url)")
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject(completionHandler: { (response: DataResponse<OfferPlaceModel>) in
            print("=== response = \(response)")
            guard let statusCode = response.response?.statusCode else{
                return
            }
            print("statusCode = \(statusCode)")
            switch response.result {
            case .success:
                self.offerplaces = response.result.value?.offerplace ?? [Offerplace]()
                self.offerCollectionView.reloadData()
            case .failure(let error):
                print("error = \(error)")
            }
        })
    }
    
}
