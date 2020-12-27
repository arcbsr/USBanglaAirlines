
//
//  Helper.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 25/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//


import Foundation
import UIKit
//import NVActivityIndicatorView

struct CustomColor{
    static let primaryColor = UIColor(red: 81/255, green: 76/255, blue: 152/255, alpha: 1.0)
}

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
}

var navController: UINavigationController!
var factX = UIScreen.main.bounds.size.width/375
var factY = UIScreen.main.bounds.size.height/667
var factXiPad = UIScreen.main.bounds.size.width/768
var factYiPad = UIScreen.main.bounds.size.height/1024

func getAttributedText(string:String, font:UIFont, color:UIColor, lineSpace:Float, alignment:NSTextAlignment) -> NSMutableAttributedString{
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment=alignment
    textStyle.lineSpacing=CGFloat(lineSpace)
    //paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
    let aMutableString = NSMutableAttributedString(
        string: string,
        attributes:[NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle:textStyle,NSAttributedString.Key.foregroundColor:color])
    return aMutableString
}


func shadowForView(shadow:UIView) {
    shadow.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
    shadow.layer.shadowOffset = CGSize(width: 0,height: 1.75)
    shadow.layer.shadowRadius = 1.7
    shadow.layer.shadowOpacity = 0.5
}

func shadowForViewLight(shadow:UIView) {
    shadow.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
    shadow.layer.shadowOffset = CGSize(width: 0,height: 1.75)
    shadow.layer.shadowRadius = 1.7
    shadow.layer.shadowOpacity = 0.2
}

func shadowForButton(shadow:UIButton) {
    shadow.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
    shadow.layer.shadowOffset = CGSize(width: 0,height: 1.9)
    shadow.layer.shadowRadius = 1.7
    shadow.layer.shadowOpacity = 0.45
}

func shadowForButtonLight(shadow:UIButton) {
    shadow.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
    shadow.layer.shadowOffset = CGSize(width: 0,height: 1.9)
    shadow.layer.shadowRadius = 1.7
    shadow.layer.shadowOpacity = 0.2
}


func checkValueTypeString(value:AnyObject?) -> String {
    if value is NSNull || value == nil {
        return ""
    }
    else {
        return "\(value!)"
    }
}

func checkValueTypeInt(value:AnyObject?) -> Int {
    if value is NSNull || value == nil {
        return 0
    }
    else {
        return value as! Int
    }
}
func checkValueTypeNSArray(value:AnyObject?) -> NSArray {
    if value is NSNull || value == nil {
        return []
    }
    else {
        return value as! NSArray
    }
}
func checkValueTypeNSDict(value:AnyObject?) -> NSDictionary {
    if value is NSNull || value == nil {
        return [:]
    }
    else {
        return value as! NSDictionary
    }
}

extension Double {
    
    private static var commaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    internal var commaRepresentation: String {
        return Double.commaFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

func get2Decimal(aValue:Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 2
    return numberFormatter.string(from: NSNumber(value:aValue))!
}

func changeImgTintColor(imgview:UIImageView, color:UIColor) {
    imgview.image = imgview.image!.withRenderingMode(.alwaysTemplate)
    imgview.tintColor = color
}


//var lodaingbgView:UIView? = nil
//var loadingAnim:NVActivityIndicatorView!
//
//func showActivityIndic(loaderColor:UIColor) {
//    let window = UIApplication.shared.keyWindow!
//    lodaingbgView=UIView(frame:CGRect(x:0,y:0,width:window.frame.size.width,height:window.frame.size.height))
//    lodaingbgView?.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.60)
//    window.addSubview(lodaingbgView!)
//    let logoSzW:CGFloat=75*factX
//    let logoSzH:CGFloat=95*factX
//    let logoImgView:UIImageView=UIImageView(frame: CGRect(x:window.frame.size.width*0.5-logoSzW*0.5,y:window.frame.size.height*0.5-logoSzH*0.5,width:logoSzW,height:logoSzH))
//    let image = UIImage(named:"splash.png")
//    //logoImgView.tintColor = UIColor.orange
//    logoImgView.image = image
//    logoImgView.contentMode = .scaleAspectFit
//
//    lodaingbgView?.addSubview(logoImgView)
//    let frame = CGRect(x: (window.frame.size.width*0.5-45*factX*0.5), y: (logoImgView.frame.origin.y+logoImgView.frame.size.height), width: 45*factX, height: 45*factX)
//    loadingAnim  = NVActivityIndicatorView(frame: frame)
//    loadingAnim.type = .ballPulse
//    loadingAnim.color = UIColor.orange
//    lodaingbgView?.addSubview(loadingAnim)
//    loadingAnim.startAnimating()
//}
//
//
//func hideActivityIndicator() {
//    loadingAnim?.stopAnimating()
//    lodaingbgView?.removeFromSuperview()
//}

extension UINavigationController{
    func addNavigationBarTitleImage(){
        self.isNavigationBarHidden = false
        let navController = self
        if let image = UIImage(named: "ic_appLogo"){
            let imageView = UIImageView(image: image)
            
            let bannerWidth = navController.navigationBar.frame.size.width
            let bannerHeight = navController.navigationBar.frame.size.height
            
            let bannerX = bannerWidth / 2 - image.size.width / 2
            let bannerY = bannerHeight / 2 - image.size.height / 2
            
            imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
            imageView.contentMode = .scaleAspectFit
            
            navigationItem.titleView = imageView
        }
    }
}

extension UIWindow {
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}

extension UIView{
    func customizeForInput(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
    }
    
    func showAlert(title: String?, message: String?, callback: ((_ action: UIAlertAction)->Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "হ্যাঁ", style: .default) { (action) in
            callback?(action)
        }
        alertController.addAction(okAction)
        alertController.addAction(UIAlertAction(title: "না", style: .destructive, handler: nil
        ))
        parentContainerViewController()?.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController{
    //    public func showAlert(title: String?, message: String?, callback: ((_ action: UIAlertAction)->Void)?) {
    //        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //        let okAction = UIAlertAction(title: "হ্যাঁ", style: .default) { (action) in
    //            callback?(action)
    //        }
    //        alertController.addAction(okAction)
    //        alertController.addAction(UIAlertAction(title: "না", style: .destructive, handler: nil))
    //        self.present(alertController, animated: true, completion: nil)
    //    }
    
    // login with priyo
    public func showAlert(title: String?, message: String?, callback: ((_ action: UIAlertAction)->Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            callback?(action)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showYesNoAlert(title: String?, message: String?, callback: ((_ action: UIAlertAction)->Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            callback?(action)
        }
        alertController.addAction(okAction)
        alertController.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}


extension UIImageView{
    func setTintColor(){
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = .orange
    }
}

extension UITextField {
    
    // login with priyo
    func addToolbarButton(with target: Any, selector: Selector, title: String, tintColor: UIColor) {
        let toolBar = UIToolbar.init()
        let space = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace,
                                         target: self,
                                         action: nil)
        let doneBtn = UIBarButtonItem.init(title: title,
                                           style: .plain,
                                           target: target,
                                           action: selector)
        doneBtn.tintColor = tintColor
        toolBar.items = [space, doneBtn]
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func isEmpty() -> Bool{
        let text = self.text ?? ""
        return text.isEmpty
    }
    
}

//extension UITextView {
//    func setLeftPaddingPoints(_ amount:CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//}

//func postData(urlString: String, postDict:NSDictionary, baseURL: String, completion: @escaping (NSDictionary) -> Void) {
//
//    let urlStr=urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
//    let url : URL = URL(string: urlStr)!
//    var request: URLRequest = URLRequest(url:url)
//    request.httpMethod = "PUT"
//    if postDict != [:] {
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let jsonData = try? JSONSerialization.data(withJSONObject: postDict)
//        request.httpBody = jsonData//postString.data(using: String.Encoding.utf8)!//jsonData//
//    }
//    let config = URLSessionConfiguration.default
//    let session = URLSession(configuration: config)
//
//    let task = session.dataTask(with: request) { (data, response, error) in
//
//        if(error != nil){
//            // print(error?.localizedDescription ?? "")
//            DispatchQueue.main.async {
//                hideActivityIndicator()
//                completion([:])
//            }
//        }
//        else  {
//
//            do {
//                let jsonDict:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
//                //let quotes:NSArray = ((jsonDict.object(forKey: "query") as! NSDictionary).object(forKey: "results") as! NSDictionary).object(forKey: "quote") as! NSArray
//                // // print(jsonDict)
//                DispatchQueue.main.async {
//                    hideActivityIndicator()
//                    completion(jsonDict)
//                }
//            }
//            catch {
//                // print(error.localizedDescription)
//                DispatchQueue.main.async {
//                    hideActivityIndicator()
//
//                    completion([:])
//                }
//            }
//        }
//    };
//    task.resume()
//}



extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

func displayAlertViewForCamera() {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: "This feature requires camera access", message: "In iPhone settings, tap MyTelenor and turn on Camera", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Not Now", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { action in
            UIApplication.openAppSettings()
        }))
        navController.present(alert, animated: true, completion: nil)
    }
}

func displayAlertViewOutSideAVC(title:String,details:String) {
    let alert = UIAlertController(title: title, message: details, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "ঠিক আছে", style: UIAlertAction.Style.default, handler: nil))
    UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: nil)
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
//           UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
//self.view.layoutIfNeeded()
//}, completion: nil)
func apiBodyString(postString:[String:Any]) -> String {
    let pStr = "\(postString)"
    let formattedString = pStr.replacingOccurrences(of: " ", with: "")
    let newFormatedStr = formattedString.replacingOccurrences(of: "[", with: "{")
    let anoFormat = newFormatedStr.replacingOccurrences(of: "]", with: "}")
    return anoFormat
}



func setViewBackgroundImageDash(vc:UIViewController) {
    let aview = UIView(frame: vc.view.bounds)
    aview.backgroundColor = UIColor.white//buttonColor
    vc.view.insertSubview(aview, at: 0)
    let background = UIImage(named: "newFill1Copy.png")
    var imageView : UIImageView!
    imageView = UIImageView(frame: CGRect(x: vc.view.frame.width-vc.view.frame.width*0.7, y: 0, width: vc.view.frame.width*0.7, height: vc.view.frame.width*0.7))
    imageView.image = background
    imageView.contentMode =  .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.backgroundColor = .clear
    aview.insertSubview(imageView, at: 1)
}

func setViewBackgroundImageDartnBallons(vc:UIViewController) {
    let aview = UIView(frame: vc.view.bounds)
    aview.backgroundColor = UIColor.white//buttonColor
    vc.view.insertSubview(aview, at: 0)
    let background = UIImage(named: "newFill1Copy.png")
    var imageView : UIImageView!
    imageView = UIImageView(frame: CGRect(x: vc.view.frame.width-vc.view.frame.width*0.7, y: 0, width: vc.view.frame.width*0.7, height: vc.view.frame.width*0.7))
    imageView.image = background
    imageView.contentMode =  .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.backgroundColor = .clear
    aview.insertSubview(imageView, at: 1)
    
    let confirtyBg = UIImage(named: "History-BG.png")
    var confirty : UIImageView!
    confirty = UIImageView(frame: CGRect(x: 0, y: 0, width: vc.view.frame.width, height: vc.view.frame.width*0.35))
    confirty.image = confirtyBg
    confirty.contentMode =  .scaleAspectFit
    confirty.clipsToBounds = true
    confirty.backgroundColor = .clear
    aview.insertSubview(confirty, at: 2)
    
}
func setViewBackgroundImage(vc:UIViewController) {
    let aview = UIView(frame: vc.view.bounds)
    aview.backgroundColor = UIColor.clear
    vc.view.insertSubview(aview, at: 0)
}

func setViewBackgroundView(vc:UIViewController) {
    let aview = UIView(frame: vc.view.bounds)
    aview.backgroundColor = UIColor.init(red: 0.286, green: 0.663, blue: 0.949, alpha: 1)//buttonColor
    vc.view.insertSubview(aview, at: 0)
}
func setIconOnType(imageView:UIImageView, type:String) {
    //imageView.image = UIImage(named: "Data Copy.png")
    if type == "data" {
        imageView.image = UIImage(named: "Data.png")
        
    }
    if type == "voice" {
        imageView.image = UIImage(named: "phone.png")
        
    }
    if type == "sms" {
        imageView.image = UIImage(named: "sms_shop@3x.png")
        
    }
    if type == "currency" {
        imageView.image = UIImage(named: "Data Copy.png")
    }
    if type == "validity" {
        imageView.image = UIImage(named: "battery.png")
    }
    if type == "dollar" {
        imageView.image = UIImage(named: "money.png")
    }
    
}

var updateavailTimestamp: TimeInterval {
    return NSDate().timeIntervalSince1970
}

var currentTimestamp: TimeInterval {
    return NSDate().timeIntervalSince1970
}

//Display Toast
func displayToast(messsage:String, color:UIColor) {
    
    let window = UIApplication.shared.keyWindow!
    let padding=10
    let toastH=20;
    let toastW=window.frame.size.width*0.85;
    let toastLbl = UILabel()
    toastLbl.text = messsage
    toastLbl.numberOfLines = 10
    toastLbl.textColor = UIColor.white
    toastLbl.textAlignment = NSTextAlignment.center
    toastLbl.frame = CGRect(x: CGFloat(padding), y: CGFloat(padding), width: toastW, height: CGFloat(toastH))
    
    //let imgIcon = UIImageView()
    //imgIcon.contentMode = .scaleAspectFit
    //imgIcon.frame = CGRect(x: 10, y: 5, width: 25, height: 25)
    //imgIcon.image = UIImage(named: "bin.png")
    
    toastLbl.sizeToFit()
    let vWidth=toastLbl.frame.size.width+CGFloat(padding)*2
    
    let v = UIView(frame: CGRect(x: window.frame.size.width*0.5-vWidth*0.5, y: window.frame.size.height*0.8, width: vWidth, height: CGFloat(toastLbl.frame.size.height+CGFloat(padding)*2)))
    //v.addSubview(imgIcon)
    v.addSubview(toastLbl)
    window.addSubview(v)
    v.layer.cornerRadius = v.frame.size.height/2;
    v.layer.masksToBounds = true;
    v.backgroundColor = color
    
    let DurAnim1=0.5
    let DurDelay1=2
    
    UIView.animate(withDuration: DurAnim1, delay: TimeInterval(DurDelay1), options: [], animations: {
        v.alpha = 1.0
    }) { (finished: Bool) in
        UIView.animate(withDuration: DurAnim1, delay: TimeInterval(DurDelay1), options: [], animations: {
            v.alpha = 0.0
        }) { (finished: Bool) in
            v.removeFromSuperview()
        }
    }
}


extension String {
    //Convert HTML to HTML
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    //Convert HTML to String
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

//Open App Settings
extension UIApplication {
    @discardableResult
    static func openAppSettings() -> Bool {
        guard
            let settingsURL = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsURL)
            else {
                return false
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(settingsURL)
        } else {
            // Fallback on earlier versions
        }
        return true
    }
}


func buttonPressedAnimation(sender:Any) {
    let btn:UIButton = (sender as! UIButton)
    
    let DurAnim1 = 0.3
    let DurDelay1 = 0.0
    
    UIView.animate(withDuration: DurAnim1, delay: TimeInterval(DurDelay1), options: [], animations: {
        btn.alpha =  0.6
    }) { (finished: Bool) in
        
        UIView.animate(withDuration: DurAnim1, delay: DurDelay1, options: [], animations: {
            btn.alpha = 1
        }, completion: nil)
    }
    
}





//MARK: -  Device Check

let iPad = UIUserInterfaceIdiom.pad
let iPhone = UIUserInterfaceIdiom.phone
@available(iOS 9.0, *) /* AppleTV check is iOS9+ */
let TV = UIUserInterfaceIdiom.tv

extension UIDevice {
    static var type: UIUserInterfaceIdiom
    { return UIDevice.current.userInterfaceIdiom }
}


func mixPanelDateFormat() -> String {
    let dateeee = Date()
    let formatterrr = DateFormatter()
    formatterrr.dateFormat = "yyyy-MM-dd'T'HH:ss.SSSZZZZZ"
    formatterrr.timeZone = TimeZone(identifier: "MMT")
    formatterrr.locale = Locale.current
    // print(formatterrr.string(from: dateeee))
    let dateString = formatterrr.string(from: dateeee)
    return dateString
}


let buttonColor = UIColor(red: 19/255, green: 124/255, blue: 205/255, alpha: 1)

extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
