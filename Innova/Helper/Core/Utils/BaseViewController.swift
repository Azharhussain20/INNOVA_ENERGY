import UIKit
import Photos

class BaseViewController : UIViewController {
    //------------------------------------------
    //MARK: - Class Variables -
    
    var style:UIStatusBarStyle = .default
    var backTapped:(() -> Void)?
    var dismissKeyboardTap : UITapGestureRecognizer?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return style
    }
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        if let font = UIFont(name: "HelveticaNeue-Medium", size: 24.0) {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
    }
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func changeStyle(_ myStyle : UIStatusBarStyle) {
        style = myStyle
        setNeedsStatusBarAppearanceUpdate()
    }
    
    open func addTapToDismissKeyboard () {
        dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardTap!)
    }
    
    open func configurationTitleAndBack(title : String, imageName : String) {
        self.title = title
        let chevronleft = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: #selector(back))
        chevronleft.tintColor = appConfig.appColors.themeColor
        navigationItem.leftBarButtonItem  = chevronleft
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    @objc func back(){
        backTapped?()
        AppInstance._navigation.popViewController(animated: true)
    }
    @objc open func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

