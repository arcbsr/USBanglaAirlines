//
//  ReturnFlightCell.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 30/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit

class ReturnFlightCell: UITableViewCell {
    @IBOutlet weak var downArrowButton: UIButton!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var forwardfromLocationLabel: UILabel!
    @IBOutlet weak var forwardfromTimeLabel: UILabel!
    @IBOutlet weak var forwardtoLocationLabel: UILabel!
    @IBOutlet weak var forwardtoTimeLabel: UILabel!
//    @IBOutlet weak var forwardDurationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var downArrowTapped: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func downArrowButtonTapped(_ sender: Any) {
        downArrowTapped?()
    }
}
