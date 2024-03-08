import UIKit

class ProfileViewController: UIViewController {
  
    //------------------------------------------
    //MARK: - Memory Management -
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit
    {
        
    }
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnDidSelectLanguage(_ sender: UIButton) {
        showLanguageSelectionAlert()
    }
    func showLanguageSelectionAlert() {
        let alertController = UIAlertController(title: "Select Language".localize(), message: nil, preferredStyle: .actionSheet)
        let englishAction = UIAlertAction(title: "English".localize(), style: .default) { _ in
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            Bundle.setLanguage("en")
            AppInstance.goToIntroDuctionPage(transition: true)
        }
        alertController.addAction(englishAction)
        
        let italianAction = UIAlertAction(title: "Italian".localize(), style: .default) { _ in
            UserDefaults.standard.set(["it"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            Bundle.setLanguage("it")
            AppInstance.goToIntroDuctionPage(transition: true)
        }
        alertController.addAction(italianAction)
        let cancelAction = UIAlertAction(title: "Cancel".localize(), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
