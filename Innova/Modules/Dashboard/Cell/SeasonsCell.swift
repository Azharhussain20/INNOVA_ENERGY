//
//  SeasonsCell.swift
//  Innova
//
//  Created by Azhar - M1 on 22/03/24.
//

import UIKit

class SeasonsCell: UITableViewCell {

    
    @IBOutlet weak var lblSeasonName: UILabel!
    @IBOutlet weak var imgCheckMark: UIImageView!
    @IBOutlet weak var btnInfo: UIButton!
    var touchupInfo:(() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnInfoTapped(_ sender: UIButton) {
        touchupInfo!()
    }
    
}
