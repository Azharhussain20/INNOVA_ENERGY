import Foundation
import UIKit
import Photos
import WebKit

enum FontType: String, CaseIterable {
    case HelveticaNeueItalic = "HelveticaNeue-Italic"
    case HelveticaNeueUltraLight = "HelveticaNeue-UltraLight"
    case HelveticaNeueUltraLightItalic = "HelveticaNeue-UltraLightItalic"
    case HelveticaNeueThin = "HelveticaNeue-Thin"
    case HelveticaNeueThinItalic = "HelveticaNeue-ThinItalic"
    case HelveticaNeueLight = "HelveticaNeue-Light"
    case HelveticaNeueLightItalic = "HelveticaNeue-LightItalic"
    case HelveticaNeueMedium = "HelveticaNeue-Medium"
    case HelveticaNeueMediumItalic = "HelveticaNeue-MediumItalic"
    case HelveticaNeueBold = "HelveticaNeue-Bold"
    case HelveticaNeueBoldItalic = "HelveticaNeue-BoldItalic"
    case HelveticaNeueCondensedBold = "HelveticaNeue-CondensedBold"
    case HelveticaNeueCondensedBlack = "HelveticaNeue-CondensedBlack"
    case HelveticaNeueRegular = "HelveticaNeue-Regular"
}

let arrFontsType = ["HelveticaNeue-Italic",
                    "HelveticaNeue-UltraLight",
                    "HelveticaNeue-UltraLightItalic",
                    "HelveticaNeue-Thin",
                    "HelveticaNeue-ThinItalic",
                    "HelveticaNeue-Light",
                    "HelveticaNeue-LightItalic",
                    "HelveticaNeue-Medium",
                    "HelveticaNeue-MediumItalic",
                    "HelveticaNeue-Bold",
                    "HelveticaNeue-BoldItalic",
                    "HelveticaNeue-CondensedBold",
                    "HelveticaNeue-CondensedBlack",
                    "HelveticaNeue-Regular"]

extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}

extension UIFont {
    class func applyHelveticaNeueRegular(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueRegular , size: fontSize)!
    }
    
    class func applyHelveticaNeueItalic(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueItalic , size: fontSize)!
    }
    
    class func applyHelveticaNeueUltraLight(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueUltraLight , size: fontSize)!
    }
    
    class func applyHelveticaNeueUltraLightItalic(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueUltraLightItalic , size: fontSize)!
    }
    
    class func applyHelveticaNeueThin(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueThin , size: fontSize)!
    }
    class func applyHelveticaNeueThinItalic(fontSize : CGFloat) -> UIFont{
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueThinItalic , size: fontSize)!
    }
    
    class func applyHelveticaNeueLight(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueLight , size: fontSize)!
    }
    
    class func applyHelveticaNeueLightItalic(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueLightItalic , size: fontSize)!
    }
    
    class func applyHelveticaNeueMedium(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueMedium , size: fontSize)!
    }
    
    class func applyHelveticaNeueMediumItalic(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueMediumItalic , size: fontSize)!
    }
    
    class func applyHelveticaNeueBold(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueBold , size: fontSize)!
    }
    
    class func applyHelveticaNeueBoldItalic(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueBoldItalic , size: fontSize)!
    }
    
    class func applyHelveticaNeueCondensedBold(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueCondensedBold , size: fontSize)!
    }
    
    class func applyHelveticaNeueCondensedBlack(fontSize : CGFloat) -> UIFont {
        return UIFont.init(name: appConfig.appFonts.HelveticaNeueCondensedBlack , size: fontSize)!
    }
    
    func configureFonts() -> UIFont {
        let _fonttype = FontType.allCases.filter{self.fontName.contains($0.rawValue)}.first
        switch _fonttype {
        case .HelveticaNeueItalic:
            return UIFont.applyHelveticaNeueItalic(fontSize: self.pointSize)
        case .HelveticaNeueUltraLight:
            return UIFont.applyHelveticaNeueUltraLight(fontSize: self.pointSize)
        case .HelveticaNeueUltraLightItalic:
            return UIFont.applyHelveticaNeueUltraLightItalic(fontSize: self.pointSize)
        case .HelveticaNeueThin:
            return UIFont.applyHelveticaNeueThin(fontSize: self.pointSize)
        case .HelveticaNeueThinItalic:
            return UIFont.applyHelveticaNeueThinItalic(fontSize: self.pointSize)
        case .HelveticaNeueLight:
            return UIFont.applyHelveticaNeueLight(fontSize: self.pointSize)
        case .HelveticaNeueLightItalic:
            return UIFont.applyHelveticaNeueLightItalic(fontSize: self.pointSize)
        case .HelveticaNeueMedium:
            return UIFont.applyHelveticaNeueMedium(fontSize: self.pointSize)
        case .HelveticaNeueMediumItalic:
            return UIFont.applyHelveticaNeueMediumItalic(fontSize: self.pointSize)
        case .HelveticaNeueBold:
            return UIFont.applyHelveticaNeueBold(fontSize: self.pointSize)
        case .HelveticaNeueBoldItalic:
            return UIFont.applyHelveticaNeueBoldItalic(fontSize: self.pointSize)
        case .HelveticaNeueCondensedBold:
            return UIFont.applyHelveticaNeueCondensedBold(fontSize: self.pointSize)
        case .HelveticaNeueCondensedBlack:
            return UIFont.applyHelveticaNeueCondensedBlack(fontSize: self.pointSize)
        default:
            return UIFont.applyHelveticaNeueRegular(fontSize: self.pointSize)
        }
    }
}

extension UILabel {
    open override func awakeFromNib() {
        //self.font = self.font.configureFonts()
    }
    func applyStyle(labelFont: UIFont? = nil,
                    textColor: UIColor? = nil,
                    cornerRadius: CGFloat? = nil,
                    backgroundColor: UIColor? = nil,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat? = 1.5,
                    alignment: NSTextAlignment = .left) {
        if cornerRadius != nil {
            self.layer.cornerRadius = cornerRadius!
        } else {
            self.layer.cornerRadius = 0
        }
        
        if borderColor != nil {
            self.layer.borderColor = borderColor?.cgColor
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
        
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        } else {
            self.backgroundColor = UIColor.clear
        }
        
        if borderWidth != nil {
            self.layer.borderWidth = borderWidth!
        } else {
            self.layer.borderWidth = 0
        }
        
        if labelFont != nil {
            self.font = labelFont
            self.setFontDynamically(labelFont!)
        } else {
            self.font = UIFont.applyHelveticaNeueRegular(fontSize: 14)
            self.setFontDynamically(UIFont.applyHelveticaNeueRegular(fontSize: 14))
        }
        
        if textColor != nil {
            self.textColor = textColor
        } else {
            self.textColor = UIColor.white
        }
        
        self.textAlignment = alignment
    }
    
    func setAttributedString(_ arrStr : [String] , attributes : [[NSAttributedString.Key : Any]]) {
        let str = self.text!
        let attributedString = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.font: self.font as Any])
        for index in 0...arrStr.count - 1 {
            let attr = attributes[index]
            attributedString.addAttributes(attr, range: (str as NSString).range(of: arrStr[index]))
        }
        self.attributedText = attributedString
    }
    
    func setFontDynamically(_ fontToSet : UIFont) {
        self.font = UIFontMetrics.default.scaledFont(for: fontToSet)
        self.adjustsFontForContentSizeCategory = true
    }
    
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
        }
    }
    
    func setValue(msg: String) {
        DispatchQueue.main.async {
            self.text = msg
        }
    }
}

extension UIButton
{
    open override func awakeFromNib(){}
    
    func applyStyle(buttonFont: UIFont? = nil,
                    textColor: UIColor? = nil,
                    cornerRadius: CGFloat? = nil,
                    backgroundColor: UIColor? = nil,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat? = 1.5,
                    state: UIControl.State = .normal) {
        
        if cornerRadius != nil {
            self.layer.cornerRadius = cornerRadius!
        } else {
            self.layer.cornerRadius = 0
        }
        
        if borderColor != nil {
            self.layer.borderColor = borderColor?.cgColor
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
        
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        } else {
            self.backgroundColor = UIColor.clear
        }
        
        if borderWidth != nil {
            self.layer.borderWidth = borderWidth!
        } else {
            self.layer.borderWidth = 0
        }
        
        if buttonFont != nil {
            self.titleLabel?.font =  buttonFont!
            self.titleLabel?.setFontDynamically(buttonFont!)
        } else {
            self.titleLabel?.font = UIFont.applyHelveticaNeueRegular(fontSize: 14)
            self.titleLabel?.setFontDynamically(UIFont.applyHelveticaNeueRegular(fontSize: 14))
        }
        
        if textColor != nil {
            self.setTitleColor(textColor, for: state)
        } else {
            self.setTitleColor(UIColor.white, for: state)
        }
    }
}

@IBDesignable extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor.init(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
    }
    
    @IBInspectable var Radius: CGFloat {
        get{return self.layer.cornerRadius}
        set(newValue) {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    func setViewShadow() {
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1
        self.layer.masksToBounds =  false
    }
    
    @IBInspectable var ApplyViewShadow : Bool {
        set(value){ if value {setViewShadow()}}
        get{return false}
    }
}
