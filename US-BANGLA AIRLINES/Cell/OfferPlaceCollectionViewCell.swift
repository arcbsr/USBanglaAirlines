//
//  OfferPlaceCollectionViewCell.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 5/2/21.
//  Copyright © 2021 usbangla. All rights reserved.
//

import UIKit

class OfferPlaceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var crossTapped: (()->())?
    var leftTapped: (()->())?
    var rightTapped: (()->())?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func corssButtonTapped(_ sender: Any) {
        crossTapped?()
    }
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        leftTapped?()
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        rightTapped?()
    }
    
}
