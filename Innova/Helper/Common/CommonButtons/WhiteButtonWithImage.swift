import UIKit

@IBDesignable
class WhiteButtonWithImage: UIButton {
    
    var touchUpInside:(() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    private func setupButton() {
        applyStyle(buttonFont: UIFont(name: "HelveticaNeue-Bold", size: 16),
                   textColor: appConfig.appColors.titleBlack,
                   cornerRadius:16.0,
                   backgroundColor:UIColor.white,
                   borderColor:appConfig.appColors.borderColorOfButtons,
                   borderWidth: 2.0,
                   state: .normal)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc private func buttonTapped() {
        touchUpInside?()
    }
}


