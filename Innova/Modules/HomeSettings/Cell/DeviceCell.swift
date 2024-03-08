import UIKit

class DeviceCell: UITableViewCell {
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var imgForward: UIImageView!
    @IBOutlet weak var seperator: UILabel!
    @IBOutlet weak var lblDeviceType: UILabel!
    @IBOutlet weak var lblDeviceName: UILabel!
    @IBOutlet weak var imgDeviceIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
