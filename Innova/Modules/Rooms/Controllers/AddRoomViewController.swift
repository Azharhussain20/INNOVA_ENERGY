import UIKit

class AddRoomViewController:BaseViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var btnAdd: GreenThemeButton!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblSuggestionList: UITableView!
    //------------------------------------------
    //MARK: - Class Variables -
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
        customActions()
        xibRegistrations()
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func navigationSetup(){
        configurationTitleAndBack(title: "Aggiungi una stanza", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func xibRegistrations() {
        tblSuggestionList.register(UINib(nibName: "SuggestionsCell", bundle: nil), forCellReuseIdentifier: "SuggestionsCell")
        tblHeight.constant = CGFloat(data.count) * 57.0
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    func customActions() {
        btnAdd.touchUpInside = {
        }
    }
}

//------------------------------------------
//MARK: - TableView Delegate Methods -
extension AddRoomViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SuggestionsCell = tblSuggestionList.dequeueReusableCell(withIdentifier: "SuggestionsCell") as! SuggestionsCell
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
