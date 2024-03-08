import UIKit
import Foundation

class BackgroundImage: UIImageView {
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
    }
}

class ThemeButton : UIButton {
    override func awakeFromNib() {
        self.applyStyle(buttonFont: UIFont.applyHelveticaNeueRegular(fontSize: 14), textColor: UIColor.black, cornerRadius: 0.0, backgroundColor: UIColor.green, borderColor: nil, borderWidth: nil, state: .normal)
    }
}

