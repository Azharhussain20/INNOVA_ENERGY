import Foundation
import UIKit

private var _sharedConfig = AppConfiguration()
var appConfig = AppConfiguration.sharedInstance

class AppConfiguration: NSObject {
    var identifier: String?
    var appColors : ThemeColors!
    var appFonts : ThemeFonts!
    
    override init() {
        super.init()
    }
    class var sharedInstance: AppConfiguration {
        if _sharedConfig.identifier == nil {
            _sharedConfig.loadFromDefault()
        }
        return _sharedConfig
    }
    
    func loadFromDefault() {
        appColors = AppColors()
        appFonts = AppFonts()
    }
    
}
