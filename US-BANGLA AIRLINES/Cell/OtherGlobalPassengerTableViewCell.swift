//
//  OtherGlobalPassengerTableViewCell.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 14/2/21.
//  Copyright © 2021 usbangla. All rights reserved.
//

import UIKit
import DropDown


class OtherGlobalPassengerTableViewCell: UITableViewCell {
    @IBOutlet weak var downImageView5: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                downImageView5.image = UIImage(named: "down-arrow")
            }
        }
    }
    @IBOutlet weak var downImageView4: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                downImageView4.image = UIImage(named: "down-arrow")
            }
        }
    }
    @IBOutlet weak var downImageView3: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                downImageView3.image = UIImage(named: "down-arrow")
            }
        }
    }
    @IBOutlet weak var down2ImageView: UIImageView!{
        didSet{
            if #available(iOS 13.0, *) {
                print("no change")
            } else {
                // Fallback on earlier versions
                down2ImageView.image = UIImage(named: "down-arrow")
            }
        }
    }
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
    @IBOutlet weak var documentDetailsTitleLabel: UILabel!
    @IBOutlet weak var passengerTypeLabel: UILabel!
    @IBOutlet weak var titleSelectionView: UIView!{
        didSet{
            titleSelectionView.isUserInteractionEnabled = true
            titleSelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleViewTapped)))
        }
    }
    @IBOutlet weak var documentTypeSelectionView: UIView!{
        didSet{
            documentTypeSelectionView.isUserInteractionEnabled = true
            documentTypeSelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(documentTypeViewTapped)))
        }
    }
    @IBOutlet weak var documentTypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!{
        didSet{
            firstNameTextField.delegate = self
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField!{
        didSet{
            lastNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var dobDateButton: UIButton!
    @IBOutlet weak var dobMonthButton: UIButton!
    @IBOutlet weak var dobYearButton: UIButton!
    @IBOutlet weak var ffpNumberTextField: UITextField!{
        didSet{
            ffpNumberTextField.delegate = self
        }
    }
    
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var nationalitySelectionView: UIView!{
        didSet{
            nationalitySelectionView.isUserInteractionEnabled = true
            nationalitySelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nationalitySelectionViewTapped)))
        }
    }
    @IBOutlet weak var birthplaceLabel: UILabel!
    @IBOutlet weak var birthplaceSelectionView: UIView!{
        didSet{
            birthplaceSelectionView.isUserInteractionEnabled = true
            birthplaceSelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(birthpalceSelectionViewTapped)))
        }
    }
    @IBOutlet weak var documentIssuanceCountryLabel: UILabel!
    @IBOutlet weak var documentIssunaceCountrySelectionView: UIView!{
        didSet{
            documentIssunaceCountrySelectionView.isUserInteractionEnabled = true
            documentIssunaceCountrySelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(documentIssuanceCountrySelectionViewTapped)))
        }
    }
    
    @IBOutlet weak var expireDateButton: UIButton!
    @IBOutlet weak var expireMonthButton: UIButton!
    @IBOutlet weak var expireYearButton: UIButton!
    @IBOutlet weak var documentNumberTextField: UITextField!{
        didSet{
            documentNumberTextField.delegate = self
        }
    }
    
    var documentTypeArray = ["Passport", "Driving license", "ID Card", "Visa"]
    var documentTypeKeys = ["PP", "DL", "ID", "VISA"]
    var tiltleArray = ["MR", "MRS", "MISS", "MS", "MSTR"]
    var days = [String]()
    var months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    var infantDobYears = [String]()
    var childDobYears = [String]()
    var adultDobYears = [String]()
    var expirationYears = [String]()
    var passengerTypeCode = ""
    
    var selectedDobDay: ((_ item: String)->())?
    var selectedDobMonth: ((_ item: String)->())?
    var selectedDobYear: ((_ item: String)->())?
    var selectedExpireDay: ((_ item: String)->())?
    var selectedExpireMonth: ((_ item: String)->())?
    var selectedExpireYear:((_ item: String)->())?
    var selectedTitle: ((_ item: String)->())?
    var selectedDocumentType:  ((_ key: String, _ val: String)->())?
    var selectedPhoneCode: ((_ item: String)->())?
    var selectedPhoneNumber: ((_ item: String)->())?
    var selectedDocumentNumer: ((_ item: String)->())?
    var selectedFirstName: ((_ item: String)->())?
    var selectedLastName: ((_ item: String)->())?
    var selectedCountry: ((_ name: String, _ code: String)->())?
    var selectedFFPNumber: ((_ item: String)->())?
    var selectedEmailAdress: ((_ item: String)->())?
    var selectedNationality: ((_ name: String, _ code: String)->())?
    var selectedBirthplace: ((_ name: String, _ code: String)->())?
    var selectedDocumentIssuanceCountry: ((_ name: String, _ code: String)->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        for i in 1 ..< 32{
            days.append("\(i)")
        }
        
        let flightYear = UserDefaults.standard.integer(forKey: "flightYear")
        let twelveYears = flightYear - 12
        let twoYears = flightYear - 2
        
        for i in (1900 ... twelveYears).reversed() {
            adultDobYears.append("\(i)")
        }
        
        for i in (twelveYears ... twoYears).reversed() {
            childDobYears.append("\(i)")
        }
        
        for i in (twoYears ... flightYear).reversed() {
            infantDobYears.append("\(i)")
        }
        
        let y = Date().year
        for i in y ... 2100 {
            expirationYears.append("\(i)")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func dayButtonTapped(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = dobDateButton
        dropDown.dataSource = days
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dobDateButton.setTitle(item, for: .normal)
            self?.selectedDobDay?(item)
        }
        dropDown.show()
    }
    
    @IBAction func monthButtonTapped(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = dobMonthButton
        dropDown.dataSource = months
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dobMonthButton.setTitle(item, for: .normal)
            self?.selectedDobMonth?(item)
        }
        dropDown.show()
    }
    
    @IBAction func yearButtonTapped(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = dobYearButton
        if passengerTypeCode == "AD"{
            dropDown.dataSource = adultDobYears
        }else if passengerTypeCode == "CHD"{
            dropDown.dataSource = childDobYears
        }else{
            dropDown.dataSource = infantDobYears
        }
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dobYearButton.setTitle(item, for: .normal)
            self?.selectedDobYear?(item)
        }
        dropDown.show()
    }
    
    @IBAction func expireDayButtonTapped(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = expireDateButton
        dropDown.dataSource = days
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.expireDateButton.setTitle(item, for: .normal)
            self?.selectedExpireDay?(item)
        }
        dropDown.show()
    }
    
    @IBAction func expireMonthButtonTapped(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = expireMonthButton
        dropDown.dataSource = months
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.expireMonthButton.setTitle(item, for: .normal)
            self?.selectedExpireMonth?(item)
        }
        dropDown.show()
    }
    
    @IBAction func expireYearButtonTapped(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = expireYearButton
        dropDown.dataSource = expirationYears
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.expireYearButton.setTitle(item, for: .normal)
            self?.selectedExpireYear?(item)
        }
        dropDown.show()
    }
    
    @objc func titleViewTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = titleSelectionView
        dropDown.dataSource = tiltleArray
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.titleLabel.text = item
            self?.selectedTitle?(item)
        }
        dropDown.show()
    }
    
    @objc func documentTypeViewTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = documentTypeSelectionView
        dropDown.dataSource = documentTypeArray
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.documentTypeLabel.text = item
            self?.selectedDocumentType?(self?.documentTypeKeys[index] ?? "", item)
        }
        dropDown.show()
    }
    
    @objc func nationalitySelectionViewTapped(){
        let alert = UIAlertController(style: .actionSheet, title: "Country")
        alert.addLocalePicker(type: .country) { info in
            self.nationalityLabel.text = info?.country ?? ""
            self.selectedNationality?(info?.country ?? "", info?.code ?? "")
        }
        alert.addAction(title: "Cancel", style: .cancel)
        let topVC = UIApplication.topViewController()
        topVC?.present(alert, animated: true, completion: nil)
    }
    
    @objc func birthpalceSelectionViewTapped(){
        let alert = UIAlertController(style: .actionSheet, title: "Country")
        alert.addLocalePicker(type: .country) { info in
            self.birthplaceLabel.text = info?.country ?? ""
            self.selectedBirthplace?(info?.country ?? "", info?.code ?? "")
        }
        alert.addAction(title: "Cancel", style: .cancel)
        let topVC = UIApplication.topViewController()
        topVC?.present(alert, animated: true, completion: nil)
    }
    
    @objc func documentIssuanceCountrySelectionViewTapped(){
        let alert = UIAlertController(style: .actionSheet, title: "Country")
        alert.addLocalePicker(type: .country) { info in
            self.documentIssuanceCountryLabel.text = info?.country ?? ""
            self.selectedDocumentIssuanceCountry?(info?.country ?? "", info?.code ?? "")
        }
        alert.addAction(title: "Cancel", style: .cancel)
        let topVC = UIApplication.topViewController()
        topVC?.present(alert, animated: true, completion: nil)
    }
    
}


extension OtherGlobalPassengerTableViewCell: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else{
            return
        }
        switch textField {
        case firstNameTextField:
            selectedFirstName?(text)
        case lastNameTextField:
            selectedLastName?(text)
        case documentNumberTextField:
            selectedDocumentNumer?(text)
        case ffpNumberTextField:
            selectedFFPNumber?(text)
        default:
            break
        }
    }
}
