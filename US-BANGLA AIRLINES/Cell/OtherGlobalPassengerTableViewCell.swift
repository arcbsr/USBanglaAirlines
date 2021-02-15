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
    @IBOutlet weak var passengerTypeLabel: UILabel!
    @IBOutlet weak var titleSelectionView: UIView!{
        didSet{
            titleSelectionView.isUserInteractionEnabled = true
            titleSelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleViewTapped)))
        }
    }
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
    
    @IBOutlet weak var expireDateButton: UIButton!
    @IBOutlet weak var expireMonthButton: UIButton!
    @IBOutlet weak var expireYearButton: UIButton!
    @IBOutlet weak var passportNumberTextField: UITextField!{
        didSet{
            passportNumberTextField.delegate = self
        }
    }
    
    var tiltleArray = ["MR", "MRS", "MISS", "MS", "MSTR"]
    var days = [String]()
    var months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    var years = [String]()
    
    var selectedDobDay: ((_ item: String)->())?
    var selectedDobMonth: ((_ item: String)->())?
    var selectedDobYear: ((_ item: String)->())?
    var selectedExpireDay: ((_ item: String)->())?
    var selectedExpireMonth: ((_ item: String)->())?
    var selectedExpireYear:((_ item: String)->())?
    var selectedTitle: ((_ item: String)->())?
    var selectedCountryCode: ((_ item: String)->())?
    var selectedPhoneNumber: ((_ item: String)->())?
    var selectedPassportNumer: ((_ item: String)->())?
    var selectedFirstName: ((_ item: String)->())?
    var selectedLastName: ((_ item: String)->())?
    var selectedCountry: ((_ item: String)->())?
    var selectedFFPNumber: ((_ item: String)->())?
    var selectedEmailAdress: ((_ item: String)->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        for i in 1 ..< 32{
            days.append("\(i)")
        }
        
        let y = Date().year
        for i in (1850 ... y).reversed() {
            years.append("\(i)")
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
        dropDown.dataSource = years
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
        dropDown.dataSource = years
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
        case passportNumberTextField:
            selectedPassportNumer?(text)
        case ffpNumberTextField:
            selectedFFPNumber?(text)
        default:
            break
        }
    }
}
