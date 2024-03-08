import UIKit

class TemperatureCell: UITableViewCell {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var temperatureSwitch: UISwitch!
    @IBOutlet weak var btnTrash: UIButton!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var btnWifi: UIButton!
    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var lblDeviceName: UILabel!
    @IBOutlet weak var lblTemprature: UILabel!
    @IBOutlet weak var imgHamburger: UIImageView!
    @IBOutlet weak var hamburgerView: UIView!
    @IBOutlet weak var gradientImage: UIImageView!
    @IBOutlet weak var shieldView: UIImageView!
    
    //------------------------------------------
    //MARK: - Class Variables -
    var touchUpInsideArrow:(() -> Void)?
    var touchUpInsideTrash:(() -> Void)?
    var touchUpInsideWifi:(() -> Void)?
    
    //MARK: - View Life Cycle Methods -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    
    @IBAction func btnWifiTapped(_ sender: UIButton) {
        touchUpInsideWifi!()
    }
    
    @IBAction func btnArrowTapped(_ sender: UIButton) {
        touchUpInsideArrow!()
    }
    
    @IBAction func btnTrashTapped(_ sender: UIButton) {
        touchUpInsideTrash!()
    }
    
}
