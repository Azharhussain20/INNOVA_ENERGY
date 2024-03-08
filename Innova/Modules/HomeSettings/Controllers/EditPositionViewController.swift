import UIKit

class EditPositionViewController: BaseViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblSuggestions: UITableView!
    @IBOutlet weak var btnSavePosition: GreenThemeButton!
    @IBOutlet weak var txtPositionName: UITextField!
    //------------------------------------------
    //MARK: - Class Variables -
    let suggestionsData: [(image: String, locationName: String, userInitials:String)] = [
        ("in_locationArrow", "Rovereto", "TN"),
        ("in_locationArrow", "Rovere' della Luna", "VR"),
        ("in_locationArrow", "Rovere' della Luna", "VR"),
        ("in_locationArrow", "Rovere' della Luna", "VR"),
        ("in_locationArrow", "Rovere' della Luna", "VR"),
        ("in_locationArrow", "Rovere' della Luna", "VR"),
        ("in_locationArrow", "Rovere' della Luna", "VR"),
        ("in_locationArrow", "Rovere' della Luna", "VR"),
        ("in_locationArrow", "Roverbella", "MN")
    ]
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
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseViews()
        navigationSetup()
        xibRegistrations()
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func initialiseViews() {
        btnSavePosition.isValidate = false
        btnSavePosition.updateButtonAppearance()
    }
    
    func navigationSetup() {
        configurationTitleAndBack(title: "Modifica posizione", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func xibRegistrations() {
        tblSuggestions.register(UINib(nibName: "DeviceCell", bundle: nil), forCellReuseIdentifier: "DeviceCell")
        tblHeight.constant = CGFloat(suggestionsData.count) * 61.0
    }
    //------------------------------------------
    //MARK: - Action Methods -
    @IBAction func btnEditPositionTapped(_ sender: UIButton) {
        
    }
}
//------------------------------------------
//MARK: - TableView Delegate Methods -
extension EditPositionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DeviceCell = tblSuggestions.dequeueReusableCell(withIdentifier: "DeviceCell") as! DeviceCell
        cell.lblDeviceName.text = suggestionsData[indexPath.row].locationName
        cell.lblDeviceType.text = suggestionsData[indexPath.row].userInitials
        cell.imgDeviceIcon.image = UIImage(named: suggestionsData[indexPath.row].image)
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.seperator.isHidden = true
        } else {
            cell.seperator.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestionsData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
//------------------------------------------
//MARK: - TextField Delegate -
extension EditPositionViewController : UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        btnSavePosition.isValidate = !textField.text!.isEmpty
        btnSavePosition.updateButtonAppearance()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
