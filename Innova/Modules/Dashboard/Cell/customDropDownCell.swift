import UIKit
import DropDown
class customDropDownCell: DropDownCell {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
