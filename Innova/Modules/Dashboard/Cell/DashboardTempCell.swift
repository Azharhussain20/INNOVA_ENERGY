import UIKit

class DashboardTempCell: UICollectionViewCell {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var imgOffline: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var lblDeviceName: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var temperatureSwitch: UISwitch!
    @IBOutlet weak var imgPause: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
