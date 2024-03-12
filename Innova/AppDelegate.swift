import UIKit
import IQKeyboardManagerSwift
var AppInstance: AppDelegate!
let APPLE_LANGUAGE_KEY = "AppleLanguages"
private var kBundleKey: UInt8 = 0

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var _navigation : UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppInstance = self
        window = UIWindow(frame:UIScreen.main.bounds)
        gotoCustomSplash(transition: false)
        initailizeIQKeyboard()
        return true
    }
    
    //MARK: - Keyboard Init methods -
    func initailizeIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 5
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarManageBehaviour = IQAutoToolbarManageBehaviour.bySubviews
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
    }
    
    //MARK: - Function of Error Message view -
    func showMessages(message: String) {
        let toastView = CustomToastView.loadFromNib()
        toastView.toastConfigure(message, UIImage(named: "in_close"), true, appConfig.appColors.titleBlack, appConfig.appColors.grayFour, true)
        toastView.showToast(toastView)
    }

    //MARK: - Navigation methods -
    func goToHomeCreationPage(transition : Bool) {
        let initiliazeVC : CreateHomeViewController = Utilities.viewController(name: "CreateHomeViewController", onStoryboard: "Introduction") as! CreateHomeViewController
        _navigation = UINavigationController(rootViewController: initiliazeVC)
        _navigation.setNavigationBarHidden(false, animated: true)
        let transitionOption = transition ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromLeft
        gotoViewController(viewController: _navigation, transition: transitionOption)
    }
    
    func gotoCustomSplash(transition : Bool) {
        let initiliazeVC : CustomSplashScreen = Utilities.viewController(name: "CustomSplashScreen", onStoryboard: "Introduction") as! CustomSplashScreen
        _navigation = UINavigationController(rootViewController: initiliazeVC)
        _navigation.setNavigationBarHidden(true, animated: true)
        let transitionOption = transition ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromLeft
        gotoViewController(viewController: _navigation, transition: transitionOption)
    }
    
    func goToIntroDuctionPage(transition : Bool) {
        let initiliazeVC : IntroductionScreen = Utilities.viewController(name: "IntroductionScreen", onStoryboard: "Introduction") as! IntroductionScreen
        _navigation = UINavigationController(rootViewController: initiliazeVC)
        _navigation.setNavigationBarHidden(false, animated: true)
        let transitionOption = transition ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromLeft
        gotoViewController(viewController: _navigation, transition: transitionOption)
    }
    
    func gotoDashboard(transition : Bool) {
        let initiliazeVC : DashTabController = Utilities.viewController(name: "DashTabController", onStoryboard: "Dashboard") as! DashTabController
        _navigation = UINavigationController(rootViewController: initiliazeVC)
        _navigation.setNavigationBarHidden(true, animated: true)
        let transitionOption = transition ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromLeft
        gotoViewController(viewController: _navigation, transition: transitionOption)
    }
    
    
    func gotoViewController(viewController: UIViewController, transition: UIView.AnimationOptions) {
        if transition != UIView.AnimationOptions.showHideTransitionViews {
            UIView.transition(with: window!, duration: 0.5, options: transition, animations: { () -> Void in
                self.window!.rootViewController = viewController
            }, completion: { (finished: Bool) -> Void in
                
            })
        } else {
            window!.rootViewController = viewController
        }
    }
    
    //MARK: - Localization -
    class func getBundle(_ lang : String) -> Bundle {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle!
    }
    
    class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        return currentWithoutLocale
    }
    
    class func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
}

//------------------------------------------
// MARK: Localisation Bundle extensions
extension String {
    func localize(comment: String = "") -> String {
        let defaultLanguage = "en"
        let value = NSLocalizedString(self, comment: comment)
        if value != self || NSLocale.preferredLanguages.first == defaultLanguage {
            return value // String localization was found
        }
        guard let path = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj"), let bundle = Bundle(path: path) else {
            return value
        }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}

class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &kBundleKey) {
            return (bundle as! Bundle).localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    
    static let once: Void = {
        object_setClass(Bundle.main, type(of: BundleEx()))
    }()
    
    class func setLanguage(_ language: String?) {
        Bundle.once
        let isLanguageRTL = Bundle.isLanguageRTL(language)
        if (isLanguageRTL) {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        UserDefaults.standard.set(isLanguageRTL, forKey: "AppleTextDirection")
        UserDefaults.standard.set(isLanguageRTL, forKey: "NSForceRightToLeftWritingDirection")
        UserDefaults.standard.synchronize()
        
        let value = (language != nil ? Bundle.init(path: (Bundle.main.path(forResource: language, ofType: "lproj"))!) : nil)
        objc_setAssociatedObject(Bundle.main, &kBundleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    class func isLanguageRTL(_ languageCode: String?) -> Bool {
        return (languageCode != nil && Locale.Language(identifier:languageCode!).characterDirection == .rightToLeft)
    }
    
}
