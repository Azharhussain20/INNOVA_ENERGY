import UIKit
import DropDown
class OperationModeCell: DropDownCell {

    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var imgOperationModeImage: UIImageView!
    @IBOutlet weak var seperator: UILabel!
    @IBOutlet weak var lblModeType: UILabel!
    @IBOutlet weak var imgCheckMark: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

