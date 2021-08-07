//
//  MyBookingCell.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 7/8/21.
//  Copyright © 2021 usbangla. All rights reserved.
//

import UIKit

class MyBookingCell: UITableViewCell {
    @IBOutlet weak var pnrLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!{
        didSet{
            statusLabel.textColor = CustomColor.secondaryColor
        }
    }
    @IBOutlet weak var flightDirectionImageView: UIImageView!
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var toCityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var roundView: UIView!{
        didSet{
            roundView.layer.borderWidth = 1
            roundView.layer.cornerRadius = 5
            //            if #available(iOS 13.0, *) {
            //                roundView.layer.borderColor = UIColor.systemGray3.cgColor
            //                roundView.backgroundColor = UIColor.systemGray6
            //            } else {
            //                // Fallback on earlier versions
            roundView.layer.borderColor = UIColor(red: 199/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1).cgColor
            roundView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1)
            //            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
