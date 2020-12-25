

import UIKit


class SideBarTableViewCell: UITableViewCell {

    @IBOutlet weak var sideBarImg: UIImageView!
    @IBOutlet weak var sideBartitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
