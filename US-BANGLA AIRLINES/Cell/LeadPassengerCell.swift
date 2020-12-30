//
//  LeadPassengerCell.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 30/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit

class LeadPassengerCell: UITableViewCell {
    @IBOutlet weak var passengerTypeLabel: UILabel!
    @IBOutlet weak var titleSelectionView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobDateButton: UIButton!
    @IBOutlet weak var dobMonthButton: UIButton!
    @IBOutlet weak var dobYearButton: UIButton!
    @IBOutlet weak var ffpNumberTextField: UITextField!
    
    @IBOutlet weak var phoneCodeLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countrySelectionView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
