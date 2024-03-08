import UIKit
import DropDown

class HomeSettings: BaseViewController {
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var tblRoomsType: UITableView!
    @IBOutlet weak var tblPersons: UITableView!
    @IBOutlet weak var tblModeTypes: UITableView!
    
    @IBOutlet weak var tblPersonHeight: NSLayoutConstraint!
    @IBOutlet weak var tblModeTypeHeight: NSLayoutConstraint!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnLeaveHouse: UIButton!
    @IBOutlet weak var btnDeleteHouse: UIButton!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    //------------------------------------------
    //MARK: - Class Variables -
    var data: [(imageName: String, text: String,  isSelected: Bool)] = [
        ("in_flame", "Raffrescamento".localize(), true),
        ("in_snow", "Riscaldamento".localize(), false),
    ]
    let dropDown = DropDown()
    let roomData: [(imageName: String, roomName: String, numberOfDevices: Int)] = [
        ("in_roomIcon", "Salotto".localize(), 1),
        ("in_roomIcon", "Cucina".localize(), 2),
        ("in_roomIcon", "Bagno".localize(), 3),
        ("in_roomIcon", "Dispositivo".localize(), 2),
    ]
    let personData: [(userName: String, userType: String, userInitials:String, Images:String)] = [
        ("Francesco Carli", "Casa", "FC", ""),
        ("Hazel", "Casa", "",  "InnovaOne"),
        ("Jenis", "Aggiungi", "",  "InnovaThree"),
        ("Angelo Fiore", "Ufficio", "AF", ""),
        ("Sandy", "Ufficio", "",  "InnovaTwo"),
        ("Travis", "Casa", "",  "InnovaFour"),
        ("Mario Rossi", "Aggiungi", "MR", ""),
        ("Gabriel", "Ufficio", "",  "InnovaFive"),
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
        xibRegistrations()
    }
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func navigationSetup() {
        configurationTitleAndBack(title: "Impostazioni casa", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func xibRegistrations() {
        tblRoomsType.register(UINib(nibName: "DeviceCell", bundle: nil), forCellReuseIdentifier: "DeviceCell")
        tblPersons.register(UINib(nibName: "DeviceCell", bundle: nil), forCellReuseIdentifier: "DeviceCell")
        tblModeTypes.register(UINib(nibName: "OperationModeCell", bundle: nil), forCellReuseIdentifier: "OperationModeCell")
        tblHeight.constant = CGFloat(roomData.count) * 60.0
        tblPersonHeight.constant = CGFloat(personData.count) * 60.0
        tblModeTypeHeight.constant = CGFloat(data.count) * 44.0
    }
    
    func popAlert(title:String, message:String, secondButttonName:String) {
        showAlert( title: title, message: message, type: .twoButtons (
            button1: (
                title: "Cancel".localize(),
                style: .default,
                handler: {
                    AppInstance._navigation.popViewController(animated: true)
                }
            ),
            button2: (
                title: secondButttonName,
                style: .default,
                handler: {
                    AppInstance.gotoDashboard(transition: true)
                }
            )
        ), viewController: self
        )
    }
    
    func imageWithText(_ text: String) -> UIImage? {
        let size = CGSize(width: 30, height: 30)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { context in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle,
            ]
            
            let attributedString = NSAttributedString(string: text, attributes: attributes)
            let textRect = CGRect(x: 0, y: (size.height - attributedString.size().height) / 2, width: size.width, height: size.height)
            attributedString.draw(in: textRect)
        }
        return image
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    @IBAction func btnInvitePersonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnDeleteHouseTapped(_ sender: UIButton) {
        popAlert(title: "Delete the house".localize(), message: "Since you are the owner of this house, deleting this residence will result in the loss of all related data. This action is irreversible. Continue?".localize(), secondButttonName: "Delete house".localize())
    }
    
    @IBAction func btnLeaveHouseTapped(_ sender: UIButton) {
        popAlert(title: "Leave this house".localize(), message: "Since you are the owner of this house, deleting this residence will result in the loss of all related data. This action is irreversible. Continue?".localize(), secondButttonName: "Leave house".localize())
    }
    
    @IBAction func btnEditName(_ sender: UIButton) {
        
    }
    
    @IBAction func btnEditPosition(_ sender: UIButton) {
        let initiliazeVC : EditPositionViewController = Utilities.viewController(name: "EditPositionViewController", onStoryboard: "Settings") as! EditPositionViewController
        initiliazeVC.hidesBottomBarWhenPushed = true
        navigationController!.pushViewController(initiliazeVC, animated: true)
    }
    
    @IBAction func btnRearrangeRooms(_ sender: UIButton) {
        
    }
    
    @IBAction func btnAddRoom(_ sender: UIButton) {
        let initiliazeVC : AddRoomViewController = Utilities.viewController(name: "AddRoomViewController", onStoryboard: "Rooms") as! AddRoomViewController
        initiliazeVC.hidesBottomBarWhenPushed = true
        navigationController!.pushViewController(initiliazeVC, animated: true)
    }
}

//------------------------------------------
//MARK: - TableView Delegate Methods -
extension HomeSettings : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblRoomsType {
            let cell : DeviceCell = tblRoomsType.dequeueReusableCell(withIdentifier: "DeviceCell") as! DeviceCell
            cell.lblDeviceName.text = roomData[indexPath.row].roomName
            cell.lblDeviceType.text = "\(roomData[indexPath.row].numberOfDevices) dispositivo"
            cell.imgDeviceIcon.image = UIImage(named: roomData[indexPath.row].imageName)
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.seperator.isHidden = true
            } else {
                cell.seperator.isHidden = false
            }
            return cell
        } else if tableView == tblModeTypes {
            let cell : OperationModeCell = tblModeTypes.dequeueReusableCell(withIdentifier: "OperationModeCell") as! OperationModeCell
            cell.lblModeType.text = data[indexPath.row].text
            cell.imgOperationModeImage.image = UIImage(named: data[indexPath.row].imageName)
            if data[indexPath.row].isSelected {
                cell.imgCheckMark.isHidden = false
            } else {
                cell.imgCheckMark.isHidden = true
            }
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.seperator.isHidden = true
            } else {
                cell.seperator.isHidden = false
            }
            return cell
        }
        
        else {
            let cell : DeviceCell = tblPersons.dequeueReusableCell(withIdentifier: "DeviceCell") as! DeviceCell
            cell.lblDeviceName.text = personData[indexPath.row].userName
            cell.lblDeviceType.text = personData[indexPath.row].userType
            if personData[indexPath.row].Images == "" {
                if let image = imageWithText(personData[indexPath.row].userInitials) {
                    cell.imgDeviceIcon.image = image
                }
            } else {
                cell.imgDeviceIcon.image = UIImage(named: personData[indexPath.row].Images)
            }
            cell.imgDeviceIcon.backgroundColor = appConfig.appColors.btnInActiveView
            cell.imgDeviceIcon.layer.cornerRadius = 18.0
            
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.seperator.isHidden = true
            } else {
                cell.seperator.isHidden = false
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblRoomsType {
            return roomData.count
        } else if tableView == tblModeTypes {
            return data.count
        } else {
            return personData.count
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblRoomsType {
            return 60.0
        } else if tableView == tblModeTypes {
            return 44.0
        } else {
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblRoomsType {
        } else if tableView == tblModeTypes {
            data.indices.forEach { index in
                data[index].isSelected = index == indexPath.item
            }
            tblModeTypes.reloadData()
        } else {
            let initiliazeVC : PersonDetailsViewController = Utilities.viewController(name: "PersonDetailsViewController", onStoryboard: "Settings") as! PersonDetailsViewController
            initiliazeVC.hidesBottomBarWhenPushed = true
            navigationController!.pushViewController(initiliazeVC, animated: true)
        }
    }
}
