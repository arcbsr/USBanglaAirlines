//
//  ReturnFlightExpandedCell.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 30/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit

class ReturnFlightExpandedCell: UITableViewCell {
    @IBOutlet weak var upArrowButton: UIButton!
    @IBOutlet weak var forwardFlightDetailsLabel: UILabel!
    @IBOutlet weak var backwardFlightDetailsLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var forwardfromLocationLabel: UILabel!
    @IBOutlet weak var forwardfromTimeLabel: UILabel!
    @IBOutlet weak var forwardtoLocationLabel: UILabel!
    @IBOutlet weak var forwardtoTimeLabel: UILabel!
    @IBOutlet weak var backwardfromLocationLabel: UILabel!
    @IBOutlet weak var backwardfromTimeLabel: UILabel!
    @IBOutlet weak var backwardtoLocationLabel: UILabel!
    @IBOutlet weak var backwardtoTimeLabel: UILabel!
    @IBOutlet weak var forwardDurationLabel: UILabel!
    @IBOutlet weak var backwardDurationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!{
        didSet{
            priceLabel.backgroundColor = CustomColor.primaryColor
        }
    }
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!{
        didSet{
            selectButton.backgroundColor = CustomColor.secondaryColor
//            selectButton.layer.cornerRadius = selectButton.frame.size.height/2
//            selectButton.clipsToBounds = true
        }
    }
    
    var upArrowTapped: (()->())?
    var selectTapped: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        selectTapped?()
    }
    
    @IBAction func upArrowButtonTapped(_ sender: Any) {
        upArrowTapped?()
    }
    
}
