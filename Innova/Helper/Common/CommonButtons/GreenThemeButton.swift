import UIKit

class GreenThemeButton: UIButton {
    var touchUpInside:(() -> Void)?
    var isValidate: Bool = false
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
                   textColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                   cornerRadius:16.0,
                   backgroundColor:appConfig.appColors.themeColor,
                   borderColor:appConfig.appColors.themeColor,
                   borderWidth: 0,
                   state: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    @objc private func buttonTapped() {
        self.touchUpInside?()
    }
    
    func updateButtonAppearance() {
        if isValidate {
            applyStyle(buttonFont: UIFont(name: "HelveticaNeue-Bold", size: 16),
                       textColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                       cornerRadius:16.0,
                       backgroundColor:appConfig.appColors.themeColor,
                       borderColor:appConfig.appColors.themeColor,
                       borderWidth: 0,
                       state: .normal)
            
        } else {
            applyStyle(buttonFont: UIFont(name: "HelveticaNeue-Bold", size: 16),
                       textColor: appConfig.appColors.btnInActiveTextColor,
                       cornerRadius:16.0,
                       backgroundColor:appConfig.appColors.btnInActiveView,
                       borderColor:appConfig.appColors.btnInActiveView,
                       borderWidth: 0,
                       state: .normal)
        }
    }
}
