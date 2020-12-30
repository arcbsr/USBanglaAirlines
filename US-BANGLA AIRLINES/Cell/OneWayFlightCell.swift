//
//  OneWayFlightCell.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 30/12/20.
//  Copyright © 2020 usbangla. All rights reserved.
//

import UIKit

class OneWayFlightCell: UITableViewCell {
    @IBOutlet weak var flightDetailsLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    @IBOutlet weak var toLocationLabel: UILabel!
    @IBOutlet weak var toTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
