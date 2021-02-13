//
//  LeadPassengerCell.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 30/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit
import DropDown


class LeadPassengerCell: UITableViewCell {
    @IBOutlet weak var passengerTypeLabel: UILabel!
    @IBOutlet weak var titleSelectionView: UIView!{
        didSet{
            titleSelectionView.isUserInteractionEnabled = true
            titleSelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleViewTapped)))
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobDateButton: UIButton!
    @IBOutlet weak var dobMonthButton: UIButton!
    @IBOutlet weak var dobYearButton: UIButton!
    @IBOutlet weak var ffpNumberTextField: UITextField!
    
    @IBOutlet weak var phoneCodeView: UIView!{
        didSet{
            phoneCodeView.isUserInteractionEnabled = true
            phoneCodeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneCodeViewTapped)))
        }
    }
    @IBOutlet weak var phoneCodeLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countrySelectionView: UIView!{
        didSet{
            countrySelectionView.isUserInteractionEnabled = true
            countrySelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(countrySelectionViewTapped)))
        }
    }
    
    var tiltleArray = ["MR", "MRS", "MISS", "MS", "MSTR"]
    var days = [String]()
    var months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    var years = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        for i in 0 ..< 32{
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
        }
        dropDown.show()
    }
    
    @IBAction func monthButtonTapped(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = dobMonthButton
        dropDown.dataSource = months
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dobMonthButton.setTitle(item, for: .normal)
        }
        dropDown.show()
    }
    
    @IBAction func yearButtonTapped(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = dobYearButton
        dropDown.dataSource = years
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dobYearButton.setTitle(item, for: .normal)
        }
        dropDown.show()
    }
    
    @objc func titleViewTapped(){
        let dropDown = DropDown()
        dropDown.anchorView = titleSelectionView
        dropDown.dataSource = tiltleArray
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.titleLabel.text = item
        }
        dropDown.show()
    }
    
    @objc func phoneCodeViewTapped(){
        let alert = UIAlertController(style: .actionSheet, title: "Phone Codes")
        alert.addLocalePicker(type: .phoneCode) { info in
            self.phoneCodeLabel.text = info?.phoneCode ?? ""
        }
        alert.addAction(title: "Cancel", style: .cancel)
        let topVC = UIApplication.topViewController()
        topVC?.present(alert, animated: true, completion: nil)
    }
    
    @objc func countrySelectionViewTapped(){
        let alert = UIAlertController(style: .actionSheet, title: "Country")
        alert.addLocalePicker(type: .country) { info in
            self.countryLabel.text = info?.country ?? ""
        }
        alert.addAction(title: "Cancel", style: .cancel)
        let topVC = UIApplication.topViewController()
        topVC?.present(alert, animated: true, completion: nil)
    }
    
}

