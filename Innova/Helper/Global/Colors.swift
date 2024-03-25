import Foundation
import UIKit

protocol ThemeColors {
    var themeColor: UIColor { get }
    var grayFour: UIColor { get }
    var tabbarBackground: UIColor { get }
    var btnInActiveView: UIColor { get }
    var btnInActiveTextColor: UIColor { get }
    var buttonThemeColor: UIColor { get }
    var btnActiveView: UIColor { get }
    var btnInActiveViewBorderColor: UIColor { get }
    var borderColorOfButtons: UIColor { get }
    var gradientOne: UIColor { get }
    var gradientTwo: UIColor { get }
    var gradientThree: UIColor { get }
    var titleBlack: UIColor { get }
    var circleTrack: UIColor { get }
    var grayFive: UIColor { get }
    var grayTwo: UIColor { get }
    var night: UIColor { get }
    var eco: UIColor { get }
    var outside: UIColor { get }
    var antifreeze: UIColor { get }
}

class AppColors : ThemeColors {
    var themeColor = UIColor(red: 0, green: 0.514, blue: 0.459, alpha: 1)
    let grayFour = UIColor(hexString: "#F0F0F0")
    let tabbarBackground = UIColor(hexString: "#F8F8F8")
    let btnInActiveView = UIColor(hexString: "#E0E0E0")
    let btnInActiveTextColor = UIColor(hexString: "#636569")
    let buttonThemeColor = UIColor(hexString: "#008375")
    let btnActiveView = UIColor(hexString: "#008375")
    let btnInActiveViewBorderColor = UIColor(hexString: "#E4E9F2")
    let borderColorOfButtons = UIColor(hexString: "#636569")
    let circleTrack = UIColor(hexString: "#D9D9D9")
    let grayFive = UIColor(hexString: "#F8F8F8")
    var grayTwo = UIColor(hexString: "#CACACA")
    var night = UIColor(hexString: "##264653")
    var eco = UIColor(hexString: "#E9C46A")
    var outside = UIColor(hexString: "#F4A261")
    var antifreeze = UIColor(hexString: "#D03E1A")
    
    let gradientOne = UIColor(red: 0/255, green: 131/255, blue: 117/255, alpha: 1.0)
    let gradientTwo = UIColor(red: 142/255, green: 177/255, blue: 124/255, alpha: 1.0)
    let gradientThree = UIColor(red: 244/255, green: 162/255, blue: 97/255, alpha: 1.0)
    let titleBlack = UIColor(red: 31.0/255.0, green: 0.0/255.0, blue: 5.0/255.0, alpha: 1.0)
}
