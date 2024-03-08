import UIKit

class CreateHomeViewController: BaseViewController {
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnCreateHomeViaQR: PlainTextButton!
    @IBOutlet weak var btnSaveHome: GreenThemeButton!
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
        initialiseViews()
        navigationSetup()
        customActions()
    }
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func initialiseViews(){
        txtName.delegate = self
        btnSaveHome.isValidate = false
        btnSaveHome.updateButtonAppearance()
    }
    
    func navigationSetup(){
        configurationTitleAndBack(title: "", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    //------------------------------------------
    //MARK: - Action Methods -
    func customActions() {
        btnSaveHome.touchUpInside = {
            AppInstance.gotoDashboard(transition: true)
        }
        btnCreateHomeViaQR.touchUpInside = {
            AppInstance.gotoDashboard(transition: true)
        }
    }
    
}
//------------------------------------------
//MARK: - TextField Delegate -
extension CreateHomeViewController : UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        btnSaveHome.isValidate = !textField.text!.isEmpty
        btnSaveHome.updateButtonAppearance()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
