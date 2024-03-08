import UIKit

class PersonDetailsViewController: BaseViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var btnTransferProperty: GreenBordered!
    
    //------------------------------------------
    //MARK: - Class Variables -
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
        customActions()
        navigationSetup()
    }
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func customActions() {
        btnTransferProperty.touchUpInside = {
            
        }
    }
    func navigationSetup() {
        configurationTitleAndBack(title: "Persone", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    //------------------------------------------
    //MARK: - Action Methods -
    
}
