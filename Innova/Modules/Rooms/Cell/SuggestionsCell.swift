import UIKit

class SuggestionsCell: UITableViewCell {
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var seperator: UILabel!
    @IBOutlet weak var lblSuggestions: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
