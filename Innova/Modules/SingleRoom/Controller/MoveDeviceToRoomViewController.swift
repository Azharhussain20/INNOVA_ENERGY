import UIKit
import DropDown

class MoveDeviceToRoomViewController: BaseViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var tblDevices: UITableView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    //------------------------------------------
    //MARK: - Class Variables -
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        return layout
    }()
    let data: [(String)] = [
        ("Soggiorno"),
        ("Cucina"),
        ("Bagno"),
        ("Camera"),
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
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        xibRegistration()
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    //------------------------------------------
    //MARK: - Custom Methods -
    func xibRegistration() {
        tblDevices.register(UINib(nibName: "SuggestionsCell", bundle: nil), forCellReuseIdentifier: "SuggestionsCell")
        tblHeight.constant = CGFloat(data.count) * 57.0
    }
    
    func navigationSetup() {
        addTapToDismissKeyboard()
        configurationTitleAndBack(title: "Sposta i dispositivi", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    @IBAction func btnContinueTapped(_ sender: GreenThemeButton) {
        AppInstance.gotoDashboard(transition: true)
    }
}

//------------------------------------------
//MARK: - TableView Delegate Methods -
extension MoveDeviceToRoomViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SuggestionsCell = tblDevices.dequeueReusableCell(withIdentifier: "SuggestionsCell") as! SuggestionsCell
        cell.lblSuggestions.text = data[indexPath.row]
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.seperator.isHidden = true
        } else {
            cell.seperator.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
